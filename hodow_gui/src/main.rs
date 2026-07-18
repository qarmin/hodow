#![allow(incomplete_features)]

use std::sync::{Arc, Mutex};

use handsome_logger::ConfigBuilder;
use log::info;

mod app_logic;

slint::include_modules!();

fn main() {
    let config = ConfigBuilder::new().set_format_text(handsome_logger::FormatText::DefaultWithFileNameC.get(), None).build();
    handsome_logger::TermLogger::init(config, Default::default(), Default::default()).expect("Failed to initialize logger");

    info!("Starting Hodow GUI");

    let ui = AppWindow::new().expect("Failed to create UI");
    let ui_weak = ui.as_weak();

    let app_state = Arc::new(Mutex::new(app_logic::AppState::new()));

    {
        let ui_weak = ui_weak.clone();
        let app_state = app_state.clone();
        ui.on_start_tests(move || {
            app_logic::handle_start_tests(ui_weak.clone(), app_state.clone());
        });
    }

    {
        let app_state = app_state.clone();
        ui.on_stop_tests(move || {
            app_logic::handle_stop_tests(app_state.clone());
        });
    }

    {
        ui.on_mode_changed(move |is_cpu| {
            info!("Mode changed to: {}", if is_cpu { "CPU" } else { "GPU" });
        });
    }

    ui.set_status_message("Ready to start tests".into());

    ui.run().expect("Failed to run UI");
}
