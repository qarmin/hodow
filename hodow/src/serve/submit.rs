//! `--submit-to URL`: queue this command line on a running `hodow serve` instead of running it here.

use log::{error, info};

/// Flags about this process (where its log and results go, how it talks), with the number of values each takes. They say
/// nothing about what to run, and the server decides those for itself.
const LOCAL_ONLY: &[(&str, usize)] = &[
    ("--submit-to", 1),
    ("--log-file", 1),
    ("--data-dir", 1),
    ("--no-log-file", 0),
    ("--no-results", 0),
    ("--events", 0),
];

/// The invocation's own arguments, without the flags that only concern this process.
fn forwarded(args: impl Iterator<Item = String>) -> Vec<String> {
    let mut out = Vec::new();
    let mut args = args;
    while let Some(arg) = args.next() {
        let flag = arg.split('=').next().unwrap_or(&arg);
        match LOCAL_ONLY.iter().find(|(name, _)| *name == flag) {
            Some((_, values)) if !arg.contains('=') => {
                for _ in 0..*values {
                    args.next();
                }
            }
            Some(_) => {}
            None => out.push(arg),
        }
    }
    out
}

pub fn submit(base_url: &str) -> i32 {
    let args = forwarded(std::env::args().skip(1));
    let url = format!("{}/api/jobs", base_url.trim_end_matches('/'));
    match ureq::post(&url).send_json(serde_json::json!({ "args": args })) {
        Ok(mut response) => {
            match response.body_mut().read_to_string() {
                Ok(text) => info!("Submitted to {url}: {text}"),
                Err(e) => error!("Submitted, but could not read the answer: {e}"),
            }
            0
        }
        Err(ureq::Error::StatusCode(code)) => {
            error!(
                "The server at {url} refused the job (HTTP {code}): run it with the same arguments locally to see why"
            );
            1
        }
        Err(e) => {
            error!("Failed to submit to {url}: {e}");
            1
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn args(list: &[&str]) -> Vec<String> {
        forwarded(list.iter().map(|s| s.to_string()))
    }

    #[test]
    fn the_flag_and_its_value_are_dropped_wherever_they_stand() {
        assert_eq!(
            args(&["-d", "test", "cpu", "--submit-to", "http://h:1", "--isolate"]),
            ["-d", "test", "cpu", "--isolate"]
        );
        assert_eq!(args(&["--submit-to=http://h:1", "cpu"]), ["cpu"]);
        assert_eq!(args(&["cpu"]), ["cpu"]);
    }

    #[test]
    fn flags_about_this_process_are_not_sent() {
        assert_eq!(
            args(&[
                "--no-log-file",
                "--data-dir",
                "/tmp/x",
                "--log-file=/tmp/l",
                "--no-results",
                "--events",
                "test",
                "cpu"
            ]),
            ["test", "cpu"]
        );
    }
}
