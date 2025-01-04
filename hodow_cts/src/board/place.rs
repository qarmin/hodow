// SPDX-License-Identifier: Apache-2.0
//
// Copyright 2026 Rafal Mikrut
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Which directory a board's results belong in. The address changes with the network and a
// MAC with the interface, so the key is the SoC's fused serial number, then the device
// tree's, and only then `/etc/machine-id`, which a reflash replaces.

use std::collections::BTreeMap;
use std::fmt::Write as _;
use std::path::Path;

use crate::fuzz::store::write_atomic;

pub struct Identity {
    pub soc: String,
    pub serial: String,
    pub source: &'static str,
    pub fields: BTreeMap<String, String>,
}

impl Identity {
    pub fn from_fields(fields: &BTreeMap<String, String>) -> Self {
        let get = |k: &str| {
            fields
                .get(k)
                .map(|v| v.trim().to_string())
                .filter(|v| !v.is_empty() && v != "unknown")
        };
        let soc = get("soc_id")
            .or_else(|| get("model"))
            .unwrap_or_else(|| get("arch").unwrap_or_else(|| "board".to_string()));
        let (serial, source) = match (get("serial"), get("dt_serial"), get("machine_id")) {
            (Some(s), _, _) if s.trim_start_matches("0x").chars().any(|c| c != '0') => (s, "soc0 serial_number"),
            (_, Some(s), _) => (s, "device-tree serial-number"),
            (_, _, Some(s)) => (s, "machine-id"),
            _ => ("unknown".to_string(), "nothing"),
        };
        Self {
            soc,
            serial,
            source,
            fields: fields.clone(),
        }
    }

    pub fn dir_name(&self) -> String {
        sanitize(&format!("{}-{}", self.soc, self.serial))
    }

    pub fn describe(&self) -> String {
        let machine = self
            .fields
            .get("machine")
            .or(self.fields.get("model"))
            .map(String::as_str)
            .unwrap_or("");
        format!("{machine}, identified by {}", self.source)
    }
}

pub fn sanitize(text: &str) -> String {
    let mut out: String = text
        .chars()
        .map(|c| {
            if c.is_ascii_alphanumeric() || matches!(c, '.' | '-' | '_') {
                c
            } else {
                '_'
            }
        })
        .collect();
    while out.contains("__") {
        out = out.replace("__", "_");
    }
    out.trim_matches('_').to_string()
}

/// `board.toml` with what the board says about itself, and `IPS.md` with every address it
/// has had and when.
pub fn record_board(dir: &Path, identity: &Identity, ip: &str) -> std::io::Result<()> {
    std::fs::create_dir_all(dir)?;
    let now = local_time();

    let mut toml = String::new();
    let _ = writeln!(toml, "id_source = {:?}", identity.source);
    let _ = writeln!(toml, "last_ip = {ip:?}");
    let _ = writeln!(toml, "last_seen = {now:?}");
    for (key, value) in &identity.fields {
        let _ = writeln!(toml, "{key} = {value:?}");
    }
    write_atomic(&dir.join("board.toml"), &toml)?;

    let path = dir.join("IPS.md");
    let mut rows: Vec<[String; 3]> = std::fs::read_to_string(&path)
        .unwrap_or_default()
        .lines()
        .filter_map(|line| {
            let cells: Vec<String> = line
                .trim()
                .trim_matches('|')
                .split('|')
                .map(|c| c.trim().to_string())
                .collect();
            (cells.len() == 3 && cells[2].chars().next().is_some_and(|c| c.is_ascii_digit()))
                .then(|| [cells[0].clone(), cells[1].clone(), cells[2].clone()])
        })
        .collect();
    match rows.last_mut() {
        Some(last) if last[2] == ip => last[1] = now.clone(),
        _ => rows.push([now.clone(), now.clone(), ip.to_string()]),
    }
    let mut md = format!(
        "# Addresses of {}\n\n| first seen | last seen | address |\n|---|---|---|\n",
        identity.dir_name()
    );
    for [first, last, addr] in rows {
        let _ = writeln!(md, "| {first} | {last} | {addr} |");
    }
    write_atomic(&path, &md)
}

fn local_time() -> String {
    std::process::Command::new("date")
        .arg("+%Y-%m-%d %H:%M")
        .output()
        .ok()
        .map(|o| String::from_utf8_lossy(&o.stdout).trim().to_string())
        .filter(|t| !t.is_empty())
        .unwrap_or_else(|| format!("epoch {}", crate::fuzz::store::now_epoch()))
}

/// Finds the board last seen at `ip` and prints where each driver's testing stands.
pub fn print_status(base: &Path, ip: &str) -> u8 {
    let Ok(entries) = std::fs::read_dir(base) else {
        println!("nothing under {}", base.display());
        return 1;
    };
    let wanted = format!("last_ip = {ip:?}");
    let Some(board) = entries
        .flatten()
        .map(|e| e.path())
        .find(|p| std::fs::read_to_string(p.join("board.toml")).is_ok_and(|t| t.lines().any(|l| l == wanted)))
    else {
        println!("no board under {} was last seen at {ip}", base.display());
        return 1;
    };
    println!("{}", board.display());
    let Ok(drivers) = std::fs::read_dir(&board) else {
        return 1;
    };
    for driver in drivers
        .flatten()
        .map(|e| e.path())
        .filter(|p| p.join("state.json").exists())
    {
        println!(
            "\n== {}",
            driver
                .file_name()
                .map(|n| n.to_string_lossy().to_string())
                .unwrap_or_default()
        );
        if let Ok(Some(state)) = super::findings::read_json::<super::plan::State>(&driver.join("state.json")) {
            let at = state
                .active
                .as_ref()
                .map(|u| format!("{} (from case {})", u.label, u.from + 1))
                .unwrap_or_else(|| format!("{:?}", state.stage));
            println!("at:        {at}");
            println!("cycle:     {}", state.cycle);
            for (api, stats) in &state.apis {
                println!(
                    "{:<10} {} shuffled epochs, dry {}",
                    super::plan::short_api(api),
                    stats.epochs,
                    stats.dry
                );
            }
        }
        if let Ok(text) = std::fs::read_to_string(driver.join("FINDINGS.md")) {
            println!("\n{text}");
        }
    }
    0
}
