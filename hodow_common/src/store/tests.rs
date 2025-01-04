use std::sync::Arc;

use super::*;
use crate::datadir::DataDir;
use crate::event::{Finding, Verdict};
use crate::report::Reporter;
use crate::sink::Sink;

fn store() -> (tempfile::TempDir, Store) {
    let tmp = tempfile::tempdir().unwrap();
    let store = Store::new(tmp.path().join("results"));
    (tmp, store)
}

fn meta(id: &str, module: &str, started_ms: u64) -> RunMeta {
    RunMeta {
        id: id.into(),
        module: module.into(),
        title: module.into(),
        args: vec![],
        started_ms,
        finished_ms: None,
        status: RunStatus::Running,
        summary: None,
        version: "0".into(),
        os: "linux".into(),
        arch: "x86_64".into(),
        host: None,
    }
}

fn finished_run(store: &Store, id: &str, module: &str, started_ms: u64, payload: usize) {
    let writer = store.open_run(meta(id, module, started_ms)).unwrap();
    for i in 0..payload {
        writer.emit(&Event::Finding(Finding::new(
            format!("test_{i}_padding_padding_padding"),
            Verdict::Passed,
        )));
    }
    writer.finish();
}

#[test]
fn a_finished_run_is_on_disk_compressed_and_reads_back_in_order() {
    let (_tmp, store) = store();
    let writer = store.create_run("cpu", "CPU tests", &["-f".into()]).unwrap();
    let id = writer.id();
    let reporter = Reporter::new(Arc::new(writer));
    reporter.run_started("cpu", "CPU tests", &[], Some(id.clone()));
    reporter.finding(Finding::new("a", Verdict::Passed));
    reporter.finding(Finding::new("b", Verdict::Unverified).value("0x2"));
    reporter.finding(Finding::new("c", Verdict::Failed).detail("got 1, want 2"));
    let mut summary = Summary::default();
    [Verdict::Passed, Verdict::Unverified, Verdict::Failed]
        .into_iter()
        .for_each(|v| summary.add(v));
    reporter.run_finished(RunStatus::Failed, summary);
    drop(reporter);

    let dir = store.run_dir(&id).unwrap();
    assert!(dir.join(EVENTS_GZ_FILE).is_file() && !dir.join(EVENTS_FILE).exists());
    let meta = store.meta(&id).unwrap();
    assert_eq!(
        (meta.status, meta.args.clone()),
        (RunStatus::Failed, vec!["-f".to_string()])
    );
    assert_eq!(meta.summary.unwrap().unverified, 1);

    let names: Vec<_> = store
        .read_events(&id)
        .unwrap()
        .map(|r| match r.unwrap().event {
            Event::Finding(f) => f.name,
            other => format!("{other:?}").split_whitespace().next().unwrap().to_owned(),
        })
        .collect();
    assert_eq!(names, ["RunStarted", "a", "b", "c", "RunFinished"]);
}

#[test]
fn progress_events_are_never_written() {
    let (_tmp, store) = store();
    let writer = Arc::new(store.create_run("cpu", "CPU", &[]).unwrap());
    let reporter = Reporter::new(writer.clone()).with_progress_interval(std::time::Duration::ZERO);
    let mut step = reporter.step("x").total(10).start();
    for i in 0..10 {
        step.progress(i, None);
    }
    step.finish(crate::event::StepOutcome::Done);
    writer.finish();
    let kinds: Vec<_> = store
        .read_events(&writer.id())
        .unwrap()
        .map(|r| r.unwrap().event)
        .collect();
    assert!(kinds.iter().all(|e| !matches!(e, Event::StepProgress { .. })));
    assert!(kinds.iter().any(|e| matches!(e, Event::StepStarted { .. })));
}

#[test]
fn finish_derives_the_status_from_the_findings() {
    let (_tmp, store) = store();
    let writer = store.create_run("gpu", "GPU", &[]).unwrap();
    writer.emit(&Event::Finding(Finding::new("t", Verdict::Crashed)));
    writer.finish();
    assert_eq!(store.meta(&writer.id()).unwrap().status, RunStatus::Crashed);
    writer.finish();
}

#[test]
fn a_writer_dropped_unfinished_leaves_an_interrupted_run_with_its_events() {
    let (_tmp, store) = store();
    let id = {
        let writer = store.create_run("cpu", "CPU", &[]).unwrap();
        writer.emit(&Event::Finding(Finding::new("t", Verdict::Passed)));
        writer.id()
    };
    assert_eq!(store.meta(&id).unwrap().status, RunStatus::Interrupted);
    assert_eq!(store.read_events(&id).unwrap().count(), 1);
}

#[test]
fn a_torn_last_line_is_skipped_not_fatal() {
    let (_tmp, store) = store();
    let id = {
        let writer = store.create_run("cpu", "CPU", &[]).unwrap();
        writer.emit(&Event::Finding(Finding::new("t", Verdict::Passed)));
        writer.id()
    };
    let path = store.run_dir(&id).unwrap().join(EVENTS_FILE);
    let mut text = std::fs::read_to_string(&path).unwrap();
    text.push_str("{\"t\":1,\"ev\":\"finding\",\"na");
    std::fs::write(&path, text).unwrap();
    let mut events = store.read_events(&id).unwrap();
    assert_eq!(events.by_ref().count(), 1);
    assert_eq!(events.skipped(), 1);
}

#[test]
fn a_run_silent_for_an_hour_reads_as_interrupted_and_can_be_reaped() {
    let (_tmp, store) = store();
    let writer = store.open_run(meta("old", "cpu", 1)).unwrap();
    std::mem::forget(writer);
    let dir = store.run_dir("old").unwrap();
    let long_ago = std::time::SystemTime::now() - std::time::Duration::from_secs(2 * 3600);
    for f in [EVENTS_FILE, META_FILE] {
        std::fs::File::options()
            .write(true)
            .open(dir.join(f))
            .unwrap()
            .set_modified(long_ago)
            .unwrap();
    }
    assert_eq!(store.meta("old").unwrap().status, RunStatus::Interrupted);
    assert_eq!(store.reap_stale(), 1);
    let on_disk: RunMeta = serde_json::from_slice(&std::fs::read(dir.join(META_FILE)).unwrap()).unwrap();
    assert_eq!(on_disk.status, RunStatus::Interrupted);
}

#[test]
fn list_is_newest_first_and_skips_directories_that_are_not_runs() {
    let (_tmp, store) = store();
    finished_run(&store, "r1", "cpu", 100, 1);
    finished_run(&store, "r2", "cpu", 200, 1);
    std::fs::create_dir_all(store.dir().join("junk")).unwrap();
    let ids: Vec<_> = store.list().into_iter().map(|m| m.id).collect();
    assert_eq!(ids, ["r2", "r1"]);
}

#[test]
fn ids_that_could_escape_the_results_directory_are_refused() {
    let (_tmp, store) = store();
    for bad in ["", ".", "..", "../x", "a/b", ".hidden", "a\\b", "a b"] {
        assert!(!is_valid_id(bad), "{bad:?}");
        assert!(store.read_events(bad).is_err());
        assert!(store.meta(bad).is_none());
    }
    assert!(is_valid_id("20261109-153012-cpu-2"));
}

#[test]
fn pinning_survives_and_unpinning_is_idempotent() {
    let (_tmp, store) = store();
    finished_run(&store, "r1", "cpu", 1, 1);
    store.pin("r1", true).unwrap();
    assert!(store.is_pinned("r1"));
    store.pin("r1", false).unwrap();
    store.pin("r1", false).unwrap();
    assert!(!store.is_pinned("r1"));
    assert!(store.pin("missing", true).is_err());
}

fn data_dir_with_runs() -> (tempfile::TempDir, DataDir, Store) {
    let tmp = tempfile::tempdir().unwrap();
    let dir = DataDir::at(tmp.path().join("h"));
    dir.ensure().unwrap();
    let store = Store::new(dir.results());
    finished_run(&store, "cpu-old", "cpu", 100, 400);
    finished_run(&store, "cpu-mid", "cpu", 200, 400);
    finished_run(&store, "cpu-new", "cpu", 300, 400);
    finished_run(&store, "gpu-only", "gpu", 50, 400);
    (tmp, dir, store)
}

#[test]
fn retention_removes_oldest_first_but_keeps_the_newest_run_of_every_module() {
    let (_tmp, dir, store) = data_dir_with_runs();
    let report = retention::enforce(&dir, 1).unwrap();
    assert_eq!(report.removed, ["cpu-old", "cpu-mid"]);
    let left: Vec<_> = store.list().into_iter().map(|m| m.id).collect();
    assert_eq!(left, ["cpu-new", "gpu-only"]);
    assert!(report.over_limit);
}

#[test]
fn retention_stops_as_soon_as_the_directory_fits() {
    let (_tmp, dir, store) = data_dir_with_runs();
    let total = retention::size_of(dir.root());
    let one_run = retention::size_of(&store.run_dir("cpu-old").unwrap());
    let report = retention::enforce(&dir, total - one_run / 2).unwrap();
    assert_eq!(report.removed, ["cpu-old"]);
    assert!(!report.over_limit);
    assert_eq!(store.list().len(), 3);
}

#[test]
fn retention_never_touches_pinned_or_running_runs() {
    let (_tmp, dir, store) = data_dir_with_runs();
    store.pin("cpu-old", true).unwrap();
    let live = store.open_run(meta("live", "cpu", 10)).unwrap();
    live.emit(&Event::Finding(Finding::new("t", Verdict::Passed)));
    retention::enforce(&dir, 1).unwrap();
    let left: Vec<_> = store.list().into_iter().map(|m| m.id).collect();
    assert!(left.contains(&"cpu-old".to_string()) && left.contains(&"live".to_string()));
    assert!(!left.contains(&"cpu-mid".to_string()));
}

#[test]
fn retention_trims_old_logs_and_keeps_the_newest_per_directory_and_the_symlink() {
    let tmp = tempfile::tempdir().unwrap();
    let dir = DataDir::at(tmp.path().join("h"));
    dir.ensure().unwrap();
    let cmd = dir.logs().join("cpu");
    std::fs::create_dir_all(&cmd).unwrap();
    for (i, name) in ["a.log", "b.log", "c.log"].iter().enumerate() {
        let path = cmd.join(name);
        std::fs::write(&path, vec![b'x'; 1000]).unwrap();
        let t = std::time::SystemTime::now() - std::time::Duration::from_secs(1000 - i as u64 * 100);
        std::fs::File::options()
            .write(true)
            .open(&path)
            .unwrap()
            .set_modified(t)
            .unwrap();
    }
    #[cfg(unix)]
    std::os::unix::fs::symlink(cmd.join("c.log"), dir.logs().join("cpu-last.log")).unwrap();
    retention::enforce(&dir, 1).unwrap();
    assert!(!cmd.join("a.log").exists() && !cmd.join("b.log").exists() && cmd.join("c.log").exists());
    #[cfg(unix)]
    assert!(std::fs::symlink_metadata(dir.logs().join("cpu-last.log")).is_ok());
}

#[test]
fn the_default_limit_is_five_gibibytes() {
    assert_eq!(retention::DEFAULT_LIMIT_BYTES, 5_368_709_120);
}

#[test]
fn an_abandoned_run_gets_the_status_it_is_given_once_and_a_finished_one_keeps_its_own() {
    let (_tmp, store) = store();
    let live = store.open_run(meta("gone", "cpu", 1)).unwrap();
    std::mem::forget(live);
    store.finish_abandoned("gone", RunStatus::Cancelled).unwrap();
    let after = store.meta("gone").unwrap();
    assert_eq!(after.status, RunStatus::Cancelled);
    assert!(after.finished_ms.is_some());
    store.finish_abandoned("gone", RunStatus::Crashed).unwrap();
    assert_eq!(store.meta("gone").unwrap().status, RunStatus::Cancelled);
    assert!(store.finish_abandoned("../x", RunStatus::Cancelled).is_err());
}
