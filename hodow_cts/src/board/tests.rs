// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2026 Rafal Mikrut
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).

use std::path::PathBuf;

use super::findings::{Kind, Status};
use super::plan::Corpus;
use super::sim::{Rule, SimBoard};
use super::target::FatalKind;
use super::tester::{Config, Halt, Tester};

fn corpus() -> Corpus {
    let mut names = Vec::new();
    for root in ["dEQP-GLES2", "dEQP-GLES3", "dEQP-GLES31"] {
        for i in 0..40 {
            names.push(format!("{root}.group.c{i:02}"));
        }
    }
    Corpus::from_names(&names)
}

fn dir(name: &str) -> PathBuf {
    let dir = std::env::temp_dir().join(format!("hodow-board-{name}-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&dir);
    dir
}

fn config() -> Config {
    Config {
        batch: 10,
        dry_epochs: 2,
        once: true,
        ..Config::default()
    }
}

fn run(name: &str, board: SimBoard, cfg: Config) -> Tester<SimBoard> {
    let mut tester = Tester::open(board, dir(name), corpus(), 7, cfg).unwrap();
    let halt = tester.run();
    assert!(matches!(halt, Halt::Once), "ended with {halt:?}");
    assert!(tester.board.violations.is_empty(), "{:?}", tester.board.violations);
    tester
}

fn c(root: &str, i: usize) -> String {
    format!("dEQP-{root}.group.c{i:02}")
}

fn summary(tester: &Tester<SimBoard>) -> Vec<(Kind, Status, Vec<String>)> {
    tester
        .findings
        .list
        .iter()
        .map(|f| (f.kind, f.status, f.cases.clone()))
        .collect()
}

#[test]
fn a_case_that_hangs_on_its_own_is_its_own_reproducer_and_is_quarantined() {
    let mut board = SimBoard::new(1);
    board.rules.push(Rule::alone(&c("GLES3", 7), FatalKind::Hang));
    let tester = run("alone", board, config());
    let fatal: Vec<_> = tester
        .findings
        .list
        .iter()
        .filter(|f| f.kind == Kind::Fatal(FatalKind::Hang))
        .collect();
    assert_eq!(fatal.len(), 1, "{:?}", summary(&tester));
    assert_eq!(fatal[0].status, Status::Minimal);
    assert_eq!(fatal[0].cases, vec![c("GLES3", 7)]);
    assert!(tester.quarantine.excludes(&c("GLES3", 7)));
}

#[test]
fn a_poisoning_pair_is_shrunk_to_the_pair_and_the_trigger_is_what_gets_quarantined() {
    let mut board = SimBoard::new(2);
    board
        .rules
        .push(Rule::after(&c("GLES31", 3), &c("GLES31", 8), FatalKind::Hang, 1.0));
    let tester = run("pair", board, config());
    let found: Vec<_> = tester
        .findings
        .list
        .iter()
        .filter(|f| f.status == Status::Minimal)
        .collect();
    assert_eq!(found.len(), 1, "{:?}", summary(&tester));
    assert_eq!(found[0].cases, vec![c("GLES31", 3), c("GLES31", 8)]);
    assert!(tester.quarantine.excludes(&c("GLES31", 3)));
    assert!(!tester.quarantine.excludes(&c("GLES31", 8)), "the victim is innocent");
}

#[test]
fn a_pair_that_only_poisons_half_the_time_is_still_shrunk_to_the_pair() {
    let mut found = 0;
    for seed in 0..32 {
        let mut board = SimBoard::new(100 + seed);
        board
            .rules
            .push(Rule::after(&c("GLES3", 2), &c("GLES3", 9), FatalKind::Crash, 0.5));
        let tester = run(&format!("flaky-{seed}"), board, config());
        // The pair only meets now and then in shuffled groups, and then fires half the time,
        // so some seeds never see it at all; whatever is found has to be exactly right.
        for f in tester.findings.list.iter().filter(|f| f.status == Status::Minimal) {
            assert_eq!(
                f.cases,
                vec![c("GLES3", 2), c("GLES3", 9)],
                "seed {seed}: {:?}",
                summary(&tester)
            );
            found += 1;
        }
        assert!(!tester.quarantine.excludes(&c("GLES3", 9)), "seed {seed}");
    }
    assert!(found >= 16, "only {found} of 32 seeds minimised the pair");
}

#[test]
fn runs_that_find_no_driver_after_a_reboot_are_not_taken_as_answers() {
    let mut board = SimBoard::new(11);
    board.no_driver_after_boot = 2;
    board
        .rules
        .push(Rule::after(&c("GLES3", 1), &c("GLES3", 6), FatalKind::Hang, 1.0));
    let tester = run("no-driver", board, config());
    let minimal: Vec<_> = tester
        .findings
        .list
        .iter()
        .filter(|f| f.status == Status::Minimal)
        .collect();
    assert_eq!(minimal.len(), 1, "{:?}", summary(&tester));
    assert_eq!(minimal[0].cases, vec![c("GLES3", 1), c("GLES3", 6)]);
}

#[test]
fn a_case_that_hangs_alone_only_sometimes_never_gets_an_innocent_quarantined() {
    for seed in 0..16 {
        let mut board = SimBoard::new(300 + seed);
        let mut rule = Rule::alone(&c("GLES31", 15), FatalKind::Hang);
        rule.chance = 0.3;
        board.rules.push(rule);
        let tester = run(&format!("rare-alone-{seed}"), board, config());
        for entry in tester.quarantine.entries() {
            assert_eq!(entry.case, c("GLES31", 15), "seed {seed}: {:?}", summary(&tester));
        }
    }
}

#[test]
fn a_list_that_only_holds_up_unminimised_does_not_get_its_first_case_quarantined() {
    let mut board = SimBoard::new(12);
    board
        .rules
        .push(Rule::after(&c("GLES31", 5), &c("GLES31", 8), FatalKind::Hang, 1.0));
    // Hangs alone exactly once, on its second run alone - not from a fresh boot, so the
    // one-case list cannot be verified and the tester falls back to the original list.
    let mut fluke = Rule::alone(&c("GLES31", 8), FatalKind::Hang);
    fluke.once = true;
    fluke.skip = 1;
    board.rules.push(fluke);
    let tester = run("unsettled", board, config());
    assert!(!tester.quarantine.excludes(&c("GLES31", 0)), "{:?}", summary(&tester));
    assert!(
        tester.findings.list.iter().any(|f| f.status == Status::Flaky),
        "{:?}",
        summary(&tester)
    );
}

#[test]
fn a_case_that_fails_on_its_own_is_noted_and_never_minimised() {
    let mut board = SimBoard::new(3);
    board.fails_alone.push(c("GLES2", 4));
    let tester = run("fail-alone", board, config());
    assert!(
        tester.findings.list.iter().all(|f| f.victim != c("GLES2", 4)),
        "{:?}",
        summary(&tester)
    );
    assert!(!tester.findings.baseline.alone[&c("GLES2", 4)].passes);
    assert!(tester.quarantine.is_empty());
}

#[test]
fn a_fail_that_needs_company_is_shrunk_to_the_pair_and_not_quarantined() {
    let mut board = SimBoard::new(4);
    board.order_fails.push((c("GLES2", 1), c("GLES2", 6)));
    let tester = run("order-fail", board, config());
    let order: Vec<_> = tester
        .findings
        .list
        .iter()
        .filter(|f| f.kind == Kind::OrderFail)
        .collect();
    assert_eq!(order.len(), 1, "{:?}", summary(&tester));
    assert_eq!(order[0].status, Status::Minimal);
    assert_eq!(order[0].cases, vec![c("GLES2", 1), c("GLES2", 6)]);
    assert!(tester.quarantine.is_empty());
}

#[test]
fn a_crash_that_never_comes_back_is_recorded_and_not_quarantined() {
    let mut board = SimBoard::new(5);
    let mut rule = Rule::alone(&c("GLES3", 5), FatalKind::Crash);
    rule.once = true;
    board.rules.push(rule);
    let tester = run("once", board, config());
    assert_eq!(tester.findings.list.len(), 1, "{:?}", summary(&tester));
    assert_eq!(tester.findings.list[0].status, Status::NotReproducible);
    assert!(tester.quarantine.is_empty());
}

#[test]
fn a_board_that_goes_down_is_waited_for_and_the_case_still_found() {
    let mut board = SimBoard::new(6);
    board.rules.push(Rule::alone(&c("GLES2", 30), FatalKind::System));
    let tester = run("system", board, config());
    let minimal: Vec<_> = tester
        .findings
        .list
        .iter()
        .filter(|f| f.status == Status::Minimal)
        .collect();
    assert_eq!(minimal.len(), 1, "{:?}", summary(&tester));
    assert_eq!(minimal[0].cases, vec![c("GLES2", 30)]);
}

#[test]
fn a_minimisation_out_of_budget_quarantines_nothing_long_and_splits_the_unit() {
    let mut board = SimBoard::new(8);
    board
        .rules
        .push(Rule::after(&c("GLES31", 0), &c("GLES31", 39), FatalKind::Hang, 1.0));
    let cfg = Config {
        batch: 40,
        budget_calls: 2,
        ..config()
    };
    let tester = run("parked", board, cfg);
    let parked: Vec<_> = tester
        .findings
        .list
        .iter()
        .filter(|f| f.status == Status::Parked)
        .collect();
    assert!(!parked.is_empty(), "{:?}", summary(&tester));
    assert!(!tester.quarantine.excludes(&c("GLES31", 39)), "the victim is innocent");
}

#[test]
fn being_killed_anywhere_and_started_again_ends_where_an_unbroken_run_does() {
    let rules = || {
        let mut board = SimBoard::new(9);
        board
            .rules
            .push(Rule::after(&c("GLES3", 1), &c("GLES3", 4), FatalKind::Hang, 1.0));
        board.rules.push(Rule::alone(&c("GLES31", 20), FatalKind::Crash));
        board.order_fails.push((c("GLES2", 0), c("GLES2", 5)));
        board.order_fails.push((c("GLES2", 0), c("GLES2", 7)));
        board
    };
    let settled = |tester: &Tester<SimBoard>| -> Vec<(Kind, Status, Vec<String>, String)> {
        tester
            .findings
            .list
            .iter()
            .filter(|f| f.status == Status::Minimal)
            .map(|f| (f.kind, f.status, f.cases.clone(), f.found_in.clone()))
            .collect()
    };
    let expected = settled(&run("unbroken", rules(), config()));
    assert_eq!(expected.len(), 4, "{expected:?}");
    for kill_after in (1..80).step_by(3) {
        let path = dir(&format!("killed-{kill_after}"));
        let cfg = Config {
            max_runs: Some(kill_after),
            ..config()
        };
        let mut first = Tester::open(rules(), path.clone(), corpus(), 7, cfg).unwrap();
        let halt = first.run();
        drop(first);
        if matches!(halt, Halt::Once) {
            continue;
        }
        assert!(matches!(halt, Halt::Killed), "{halt:?}");
        let mut second = Tester::open(rules(), path, corpus(), 7, config()).unwrap();
        assert!(matches!(second.run(), Halt::Once));
        assert_eq!(settled(&second), expected, "killed after {kill_after} runs");
    }
}

#[test]
fn every_case_of_every_api_runs_through_all_three_phases() {
    let board = SimBoard::new(10);
    let tester = run("clean", board, config());
    assert!(tester.findings.list.is_empty());
    for (api, stats) in &tester.state.apis {
        assert!(stats.epochs >= 2, "{api} ran {} shuffled epochs", stats.epochs);
    }
}
