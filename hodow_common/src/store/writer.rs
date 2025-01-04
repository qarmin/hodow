use std::fs::{File, OpenOptions};
use std::io::{self, BufWriter, Write};
use std::path::{Path, PathBuf};
use std::sync::Mutex;
use std::time::{Duration, Instant};

use flate2::Compression;
use flate2::write::GzEncoder;

use super::{EVENTS_FILE, EVENTS_GZ_FILE, META_FILE, Record, RunMeta};
use crate::event::{Event, RunStatus, Summary};
use crate::sink::Sink;
use crate::time::now_ms;

/// How long ordinary passes may sit in memory before they are forced to disk. Notable events never wait.
const SYNC_INTERVAL: Duration = Duration::from_secs(1);

pub(super) fn write_meta(dir: &Path, meta: &RunMeta) -> io::Result<()> {
    let tmp = dir.join(format!("{META_FILE}.tmp"));
    std::fs::write(&tmp, serde_json::to_vec_pretty(meta).map_err(io::Error::other)?)?;
    std::fs::rename(tmp, dir.join(META_FILE))
}

struct Inner {
    events: Option<BufWriter<File>>,
    meta: RunMeta,
    summary: Summary,
    last_sync: Instant,
    finished: bool,
    error: Option<String>,
}

/// Writes one run to its directory as the run goes, so the result is on disk whether or not anyone is watching.
/// Dropping it unfinished marks the run interrupted.
pub struct RunWriter {
    dir: PathBuf,
    inner: Mutex<Inner>,
}

impl RunWriter {
    pub(super) fn create(dir: PathBuf, meta: RunMeta) -> io::Result<Self> {
        write_meta(&dir, &meta)?;
        let file = OpenOptions::new()
            .create(true)
            .append(true)
            .open(dir.join(EVENTS_FILE))?;
        Ok(Self {
            dir,
            inner: Mutex::new(Inner {
                events: Some(BufWriter::new(file)),
                meta,
                summary: Summary::default(),
                last_sync: Instant::now(),
                finished: false,
                error: None,
            }),
        })
    }

    pub fn id(&self) -> String {
        self.lock().meta.id.clone()
    }

    pub fn dir(&self) -> &Path {
        &self.dir
    }

    /// The first write error, if results stopped being recorded.
    pub fn error(&self) -> Option<String> {
        self.lock().error.clone()
    }

    /// Ends the run with the status its own counts imply, unless a `RunFinished` event already did.
    pub fn finish(&self) {
        let (status, summary) = {
            let inner = self.lock();
            if inner.finished {
                return;
            }
            (inner.summary.status(), inner.summary.clone())
        };
        self.emit(&Event::RunFinished { status, summary });
    }

    fn lock(&self) -> std::sync::MutexGuard<'_, Inner> {
        self.inner.lock().unwrap_or_else(|e| e.into_inner())
    }

    fn fail(inner: &mut Inner, what: &str, error: &io::Error) {
        if inner.error.is_none() {
            let message = format!("{what}: {error}");
            eprintln!("hodow: results are no longer being recorded ({message})");
            inner.error = Some(message);
        }
        inner.events = None;
    }

    fn write_record(inner: &mut Inner, event: &Event) {
        let Some(file) = inner.events.as_mut() else { return };
        let record = Record {
            t: now_ms(),
            event: event.clone(),
        };
        let line = serde_json::to_string(&record).expect("a record always serializes");
        let mut result = writeln!(file, "{line}");
        if result.is_ok() && (event.is_urgent() || inner.last_sync.elapsed() >= SYNC_INTERVAL) {
            result = file.flush().and_then(|()| file.get_ref().sync_data());
            inner.last_sync = Instant::now();
        }
        if let Err(e) = result {
            Self::fail(inner, "writing events", &e);
        }
    }

    fn close(&self, inner: &mut Inner, status: RunStatus, summary: Option<Summary>, compress: bool) {
        inner.finished = true;
        inner.meta.status = status;
        inner.meta.finished_ms = Some(now_ms());
        inner.meta.summary = summary;
        if let Some(mut file) = inner.events.take() {
            let synced = file.flush().and_then(|()| file.get_ref().sync_data());
            if let Err(e) = synced {
                Self::fail(inner, "syncing events", &e);
            }
        }
        if let Err(e) = write_meta(&self.dir, &inner.meta) {
            Self::fail(inner, "writing meta.json", &e);
        }
        if compress && let Err(e) = compress_events(&self.dir) {
            eprintln!("hodow: could not compress {}: {e}", self.dir.display());
        }
    }
}

impl Sink for RunWriter {
    fn emit(&self, event: &Event) {
        if event.is_ephemeral() {
            return;
        }
        let mut inner = self.lock();
        if inner.finished {
            return;
        }
        if let Event::Finding(finding) = event {
            inner.summary.add(finding.verdict);
        }
        Self::write_record(&mut inner, event);
        if let Event::RunFinished { status, summary } = event {
            self.close(&mut inner, *status, Some(summary.clone()), true);
        }
    }
}

impl Drop for RunWriter {
    fn drop(&mut self) {
        let mut inner = self.inner.lock().unwrap_or_else(|e| e.into_inner());
        if !inner.finished {
            let summary = inner.summary.clone();
            self.close(&mut inner, RunStatus::Interrupted, Some(summary), false);
        }
    }
}

fn compress_events(dir: &Path) -> io::Result<()> {
    let plain = dir.join(EVENTS_FILE);
    let tmp = dir.join(format!("{EVENTS_GZ_FILE}.tmp"));
    {
        let mut input = File::open(&plain)?;
        let mut encoder = GzEncoder::new(BufWriter::new(File::create(&tmp)?), Compression::fast());
        io::copy(&mut input, &mut encoder)?;
        encoder
            .finish()?
            .into_inner()
            .map_err(io::IntoInnerError::into_error)?
            .sync_data()?;
    }
    std::fs::rename(&tmp, dir.join(EVENTS_GZ_FILE))?;
    std::fs::remove_file(plain)
}
