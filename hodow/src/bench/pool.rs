//! Long-lived workers, one per backend family, each fed one row at a time. A worker that
//! dies or stops reporting costs the row it was on; the next row of its family starts a
//! fresh one.

use std::collections::{HashMap, VecDeque};
use std::io::{BufRead, BufReader, Write};
use std::process::{Child, ChildStdin, Command, Stdio};
use std::sync::mpsc::{self, Receiver, RecvTimeoutError};
use std::sync::{Arc, Mutex};
use std::time::{Duration, Instant};

use hodow_bench::bench::spec::{Backend, RowResult, RowSpec, RowStatus};

use super::protocol::{Msg, Probe, Request, parse};
use crate::burn::supervise::kill_and_reap;

const STDERR_TAIL: usize = 8;
const PROBE_TIMEOUT: Duration = Duration::from_secs(60);

struct Worker {
    child: Child,
    stdin: ChildStdin,
    rx: Receiver<Option<Msg>>,
    stderr: Arc<Mutex<VecDeque<String>>>,
}

impl Worker {
    fn spawn() -> std::io::Result<Worker> {
        let exe = std::env::current_exe().unwrap_or_else(|_| "hodow".into());
        let mut child = Command::new(exe)
            .args(["--no-log-file", "bench", "--worker"])
            .stdin(Stdio::piped())
            .stdout(Stdio::piped())
            .stderr(Stdio::piped())
            .spawn()?;
        let stdout = child.stdout.take().expect("piped stdout");
        let (tx, rx) = mpsc::channel();
        std::thread::spawn(move || {
            for line in BufReader::new(stdout).lines().map_while(Result::ok) {
                if let Some(msg) = parse(&line) {
                    let _ = tx.send(Some(msg));
                }
            }
            let _ = tx.send(None);
        });
        let stderr = Arc::new(Mutex::new(VecDeque::new()));
        let pipe = child.stderr.take().expect("piped stderr");
        let tail = stderr.clone();
        std::thread::spawn(move || {
            for line in BufReader::new(pipe).lines().map_while(Result::ok) {
                let mut tail = tail.lock().unwrap_or_else(|e| e.into_inner());
                if tail.len() == STDERR_TAIL {
                    tail.pop_front();
                }
                tail.push_back(line);
            }
        });
        let stdin = child.stdin.take().expect("piped stdin");
        Ok(Worker {
            child,
            stdin,
            rx,
            stderr,
        })
    }

    fn send(&mut self, request: &Request) -> std::io::Result<()> {
        let line = serde_json::to_string(request).expect("request serializes");
        writeln!(self.stdin, "{line}")?;
        self.stdin.flush()
    }

    /// Why the worker ended, once its stdout has closed.
    fn death(&mut self) -> String {
        let status = (0..50).find_map(|_| match self.child.try_wait() {
            Ok(Some(status)) => Some(status),
            _ => {
                std::thread::sleep(Duration::from_millis(20));
                None
            }
        });
        let mut reason = match status {
            Some(s) if s.success() => "the worker exited without reporting a result".to_string(),
            Some(s) => crate::isolate::crash_reason(Some(s)),
            None => "the worker closed its output and did not exit".to_string(),
        };
        let tail = self.stderr.lock().unwrap_or_else(|e| e.into_inner());
        if !tail.is_empty() {
            reason.push_str(&format!(
                " - stderr: {}",
                tail.iter().cloned().collect::<Vec<_>>().join(" / ")
            ));
        }
        reason
    }
}

impl Drop for Worker {
    fn drop(&mut self) {
        if !matches!(self.child.try_wait(), Ok(Some(_))) {
            let _ = kill_and_reap(&mut self.child);
        }
    }
}

#[derive(Default)]
pub struct Pool {
    workers: HashMap<String, Worker>,
}

fn family_key(backend: &Backend) -> String {
    match backend {
        Backend::Cpu { .. } => "cpu".into(),
        Backend::OpenCl { lib, .. } => format!("opencl:{lib}"),
        Backend::Gles { .. } => "gles".into(),
        Backend::Vulkan { .. } => "vulkan".into(),
        Backend::External { .. } => "external".into(),
        Backend::Tflite { .. } => "tflite".into(),
    }
}

pub enum Ended {
    Result(RowResult),
    /// The worker would not die - it is stuck in the driver, and so is the GPU.
    Wedged(RowResult),
}

impl Pool {
    fn worker(&mut self, key: &str) -> Result<&mut Worker, String> {
        if !self.workers.contains_key(key) {
            let worker = Worker::spawn().map_err(|e| format!("could not start a worker: {e}"))?;
            self.workers.insert(key.to_string(), worker);
        }
        Ok(self.workers.get_mut(key).expect("just inserted"))
    }

    /// The OpenCL libraries and devices here, asked of a worker of its own since loading a
    /// driver is already the kind of thing that can crash.
    pub fn probe() -> Result<Probe, String> {
        let mut worker = Worker::spawn().map_err(|e| format!("could not start a worker: {e}"))?;
        worker
            .send(&Request::Probe)
            .map_err(|e| format!("worker refused the probe: {e}"))?;
        match worker.rx.recv_timeout(PROBE_TIMEOUT) {
            Ok(Some(Msg::Probe { probe })) => Ok(probe),
            Ok(_) => Err(format!("probe failed: {}", worker.death())),
            Err(_) => Err(format!("probe did not answer within {}s", PROBE_TIMEOUT.as_secs())),
        }
    }

    pub fn run(&mut self, spec: &RowSpec, hang_timeout: Duration, mut on_beat: impl FnMut(u32)) -> Ended {
        let key = family_key(&spec.backend);
        let request = Request::Row { spec: spec.clone() };
        let sent = match self
            .worker(&key)
            .and_then(|w| w.send(&request).map_err(|e| e.to_string()))
        {
            Ok(()) => Ok(()),
            // A worker that died between rows: one fresh attempt.
            Err(_) => {
                self.workers.remove(&key);
                self.worker(&key)
                    .and_then(|w| w.send(&request).map_err(|e| e.to_string()))
            }
        };
        if let Err(e) = sent {
            self.workers.remove(&key);
            return Ended::Result(RowResult::status(RowStatus::Crash, e));
        }
        let worker = self.workers.get_mut(&key).expect("worker exists");
        let mut last = Instant::now();
        loop {
            match worker.rx.recv_timeout(Duration::from_millis(100)) {
                Ok(Some(Msg::Beat { reps })) => {
                    last = Instant::now();
                    on_beat(reps);
                }
                Ok(Some(Msg::Result { result })) => return Ended::Result(*result),
                Ok(Some(Msg::Probe { .. })) => {}
                Ok(None) | Err(RecvTimeoutError::Disconnected) => {
                    let why = worker.death();
                    self.workers.remove(&key);
                    return Ended::Result(RowResult::status(RowStatus::Crash, why));
                }
                Err(RecvTimeoutError::Timeout) if last.elapsed() > hang_timeout => {
                    let silent = last.elapsed().as_secs();
                    let mut worker = self.workers.remove(&key).expect("worker exists");
                    let stuck = kill_and_reap(&mut worker.child);
                    if stuck.is_some() {
                        // Its pipes stay open while it sits in the driver; nothing may wait on them.
                        std::mem::forget(worker);
                    }
                    return match stuck {
                        None => Ended::Result(RowResult::status(
                            RowStatus::Hang,
                            format!("no frame finished for {silent}s"),
                        )),
                        Some(stuck) => Ended::Wedged(RowResult::status(
                            RowStatus::Hang,
                            format!("no frame finished for {silent}s; {stuck}"),
                        )),
                    };
                }
                Err(RecvTimeoutError::Timeout) => {}
            }
        }
    }
}
