use std::sync::{Arc, Mutex};
use std::thread;

use hodow_core::{TestProgress, TestStatistics, available_modes, list_all_functions, reset_stop_flag, set_iterations, set_only_features, set_only_tests, set_skip_tests, test_all_extensions};
use log::info;
use slint::Weak;
use tokio::sync::mpsc;

use crate::AppWindow;

#[cfg(feature = "gpu")]
use hodow_core::{DisplayApiHint, GlApiHint, GpuOptions, test_all_opengl};

pub enum ProgressUpdate {
    TestProgress(TestProgress),
    Completed(TestStatistics),
    Error(String),
}

pub struct AppState {
    pub tests_running: bool,
}

impl AppState {
    pub fn new() -> Self {
        Self { tests_running: false }
    }
}

pub fn handle_start_tests(ui_weak: Weak<AppWindow>, app_state: Arc<Mutex<AppState>>) {
    let ui = match ui_weak.upgrade() {
        Some(ui) => ui,
        None => return,
    };

    {
        let mut state = app_state.lock().unwrap();
        if state.tests_running {
            info!("Tests already running, ignoring start request");
            return;
        }
        state.tests_running = true;
    }

    reset_stop_flag();
    ui.set_tests_running(true);
    ui.set_status_message("Starting tests...".into());
    ui.set_results_text("".into());
    ui.set_overall_progress_current(0);
    ui.set_overall_progress_total(0);
    ui.set_feature_progress_current(0);
    ui.set_feature_progress_total(0);
    ui.set_current_feature_name("".into());
    ui.set_current_test_name("".into());

    let is_cpu_mode = ui.get_is_cpu_mode();

    if is_cpu_mode {
        handle_cpu_tests(ui_weak, app_state, ui);
    } else {
        handle_gpu_tests(ui_weak, app_state, ui);
    }
}

fn handle_cpu_tests(ui_weak: Weak<AppWindow>, app_state: Arc<Mutex<AppState>>, ui: AppWindow) {
    let iterations_str = ui.get_cpu_iterations().to_string();
    let features_str = ui.get_cpu_features().to_string();
    let test_functions_str = ui.get_cpu_test_functions().to_string();
    let skip_tests_str = ui.get_cpu_skip_tests().to_string();
    let list_modes = ui.get_cpu_list_modes();
    let list_functions = ui.get_cpu_list_functions();

    thread::spawn(move || {
        if let Ok(iterations) = iterations_str.parse::<usize>() {
            set_iterations(iterations);
        }

        if !features_str.is_empty() {
            let features: Vec<String> = features_str.split(',').map(|s| s.trim().to_string()).collect();
            set_only_features(features);
        }

        if !test_functions_str.is_empty() {
            let functions: Vec<String> = test_functions_str.split(',').map(|s| s.trim().to_string()).collect();
            set_only_tests(functions);
        }

        if !skip_tests_str.is_empty() {
            let skip: Vec<String> = skip_tests_str.split(',').map(|s| s.trim().to_string()).collect();
            set_skip_tests(skip);
        }

        if list_modes {
            let modes = available_modes();
            let modes_list = modes.join("\n  ");
            let msg = format!("Available CPU modes ({} total):\n\n  {}", modes.len(), modes_list);
            info!("Available modes: {:?}", modes);
            update_ui_results(&ui_weak, msg);
            update_ui_status(&ui_weak, "Listed available modes".to_string());
            finish_tests(ui_weak, app_state);
            return;
        }

        if list_functions {
            let functions = list_all_functions();
            let msg = format!("Available test functions ({} total)", functions.len());
            info!("{}", msg);
            for func in &functions {
                info!("  {}", func);
            }
            let all_funcs = functions.join("\n");
            let full_msg = format!("{}\n\n{}", msg, all_funcs);
            update_ui_results(&ui_weak, full_msg);
            finish_tests(ui_weak, app_state);
            return;
        }

        let (tx, mut rx) = mpsc::unbounded_channel();

        let tx_clone = tx.clone();
        let progress_callback = move |progress: &TestProgress| {
            let _ = tx_clone.send(ProgressUpdate::TestProgress(progress.clone()));
        };

        let ui_weak_clone = ui_weak.clone();
        thread::spawn(move || {
            while let Some(update) = rx.blocking_recv() {
                match update {
                    ProgressUpdate::TestProgress(progress) => {
                        let ui_weak_inner = ui_weak_clone.clone();
                        slint::invoke_from_event_loop(move || {
                            let ui = match ui_weak_inner.upgrade() {
                                Some(ui) => ui,
                                None => return,
                            };

                            ui.set_overall_progress_current(progress.completed_features as i32);
                            ui.set_overall_progress_total(progress.total_features as i32);
                            ui.set_feature_progress_current(progress.completed_tests_in_feature as i32);
                            ui.set_feature_progress_total(progress.total_tests_in_feature as i32);
                            ui.set_current_feature_name(progress.current_feature.into());

                            let test_msg = if progress.total_fuzzing_iterations > 0 {
                                format!("{} (fuzzing {}/{})", progress.current_test, progress.fuzzing_iteration, progress.total_fuzzing_iterations)
                            } else {
                                progress.current_test.to_string()
                            };
                            ui.set_current_test_name(test_msg.into());

                            ui.set_status_message(format!("Testing {} feature...", progress.current_feature).into());
                        })
                        .ok();
                    }
                    ProgressUpdate::Completed(stats) => {
                        display_cpu_statistics(&ui_weak_clone, stats);
                        break;
                    }
                    ProgressUpdate::Error(err) => {
                        update_ui_error(&ui_weak_clone, err);
                        break;
                    }
                }
            }
        });

        match test_all_extensions(Some(&progress_callback)) {
            Ok(stats) => {
                let _ = tx.send(ProgressUpdate::Completed(stats));
            }
            Err(e) => {
                let _ = tx.send(ProgressUpdate::Error(e));
            }
        }

        finish_tests(ui_weak, app_state);
    });
}

fn handle_gpu_tests(ui_weak: Weak<AppWindow>, app_state: Arc<Mutex<AppState>>, ui: AppWindow) {
    #[cfg(feature = "gpu")]
    {
        // IMPORTANT: GPU tests in GUI must run in headless mode because Slint already owns the EventLoop.
        // glutin's EventLoop::new() can only be called once per process, and attempting to create
        // a second EventLoop will fail with "EventLoop can't be recreated".
        let no_window = true; // Force headless mode in GUI
        let time_limit_str = ui.get_gpu_time_limit().to_string();
        let frame_limit_str = ui.get_gpu_frame_limit().to_string();
        let display_api_index = ui.get_gpu_display_api_index();
        let gl_api_str = ui.get_gpu_gl_api().to_string();
        let force_software = ui.get_gpu_force_software();

        thread::spawn(move || {
            let time_limit_ms = time_limit_str.parse::<u64>().ok();
            let frame_limit = if frame_limit_str.is_empty() {
                None
            } else {
                frame_limit_str.parse::<u64>().ok()
            };

            let display_api = match display_api_index {
                0 => DisplayApiHint::Egl,
                1 => DisplayApiHint::Glx,
                2 => DisplayApiHint::EglThenGlx,
                3 => DisplayApiHint::GlxThenEgl,
                _ => DisplayApiHint::Egl,
            };

            let gl_api = gl_api_str.parse::<GlApiHint>().unwrap_or(GlApiHint::Auto);

            let opts = GpuOptions { no_window, time_limit_ms, frame_limit, display_api, gl_api, force_software };

            update_ui_status(&ui_weak, "Running GPU tests...".to_string());

            match test_all_opengl(&opts) {
                Ok((run, skipped, errors)) => {
                    let results = format!("GPU Tests Completed\n\nRun: {}\nSkipped: {}\nErrors: {}", run, skipped, errors);
                    update_ui_results(&ui_weak, results);

                    if errors > 0 {
                        update_ui_status(&ui_weak, format!("GPU tests completed with {} error(s)", errors));
                    } else {
                        update_ui_status(&ui_weak, format!("GPU tests completed successfully - {} tests passed", run));
                    }
                    clear_progress_display(&ui_weak);
                }
                Err(e) => {
                    update_ui_error(&ui_weak, e);
                }
            }

            finish_tests(ui_weak, app_state);
        });
    }

    #[cfg(not(feature = "gpu"))]
    {
        let _ = (ui_weak, app_state, ui);
        error!("GPU feature not compiled in");
    }
}

fn display_cpu_statistics(ui_weak: &Weak<AppWindow>, mut stats: TestStatistics) {
    use std::fmt::Write;

    stats.features.sort_by_key(|f| std::cmp::Reverse(f.tests_run));

    let mut text = String::new();
    writeln!(&mut text, "TEST STATISTICS").ok();
    writeln!(&mut text, "{}", "=".repeat(80)).ok();
    writeln!(&mut text).ok();
    writeln!(&mut text, "{:<30} {:>10} {:>10} {:>10} {:>10}", "Feature", "Run", "Skipped", "Errors", "Total").ok();
    writeln!(&mut text, "{}", "-".repeat(80)).ok();

    for feature in &stats.features {
        let total = feature.tests_run + feature.tests_skipped + feature.tests_errored;
        writeln!(&mut text, "{:<30} {:>10} {:>10} {:>10} {:>10}", feature.feature_name, feature.tests_run, feature.tests_skipped, feature.tests_errored, total).ok();
    }

    writeln!(&mut text, "{}", "-".repeat(80)).ok();
    let grand_total = stats.total_run() + stats.total_skipped() + stats.total_errors();
    writeln!(
        &mut text,
        "{:<30} {:>10} {:>10} {:>10} {:>10}",
        "TOTAL",
        stats.total_run(),
        stats.total_skipped(),
        stats.total_errors(),
        grand_total
    )
    .ok();
    writeln!(&mut text, "{}", "=".repeat(80)).ok();

    if stats.was_cancelled {
        writeln!(&mut text).ok();
        writeln!(&mut text, "Note: Testing was cancelled by user").ok();
    }

    let status_msg = if stats.total_errors() > 0 {
        format!("Tests completed with {} error(s)", stats.total_errors())
    } else if stats.was_cancelled {
        "Tests cancelled".to_string()
    } else {
        format!("All tests passed! ({} tests run)", stats.total_run())
    };

    update_ui_results(ui_weak, text);
    update_ui_status(ui_weak, status_msg);
    clear_progress_display(ui_weak);
}

fn update_ui_status(ui_weak: &Weak<AppWindow>, message: String) {
    let ui_weak = ui_weak.clone();
    slint::invoke_from_event_loop(move || {
        if let Some(ui) = ui_weak.upgrade() {
            ui.set_status_message(message.into());
        }
    })
    .ok();
}

fn update_ui_results(ui_weak: &Weak<AppWindow>, results: String) {
    let ui_weak = ui_weak.clone();
    slint::invoke_from_event_loop(move || {
        if let Some(ui) = ui_weak.upgrade() {
            ui.set_results_text(results.into());
        }
    })
    .ok();
}

fn update_ui_error(ui_weak: &Weak<AppWindow>, error: String) {
    update_ui_results(ui_weak, format!("ERROR:\n\n{}", error));
    update_ui_status(ui_weak, "Tests failed with error".to_string());
    clear_progress_display(ui_weak);
}

fn clear_progress_display(ui_weak: &Weak<AppWindow>) {
    let ui_weak = ui_weak.clone();
    slint::invoke_from_event_loop(move || {
        if let Some(ui) = ui_weak.upgrade() {
            ui.set_current_test_name("".into());
            ui.set_current_feature_name("".into());
        }
    })
    .ok();
}

fn finish_tests(ui_weak: Weak<AppWindow>, app_state: Arc<Mutex<AppState>>) {
    {
        let mut state = app_state.lock().unwrap();
        state.tests_running = false;
    }

    slint::invoke_from_event_loop(move || {
        if let Some(ui) = ui_weak.upgrade() {
            ui.set_tests_running(false);
        }
    })
    .ok();
}

pub fn handle_stop_tests(app_state: Arc<Mutex<AppState>>) {
    let state = app_state.lock().unwrap();
    if state.tests_running {
        info!("Stop button clicked, requesting test cancellation");
        hodow_core::request_stop();
    }
}
