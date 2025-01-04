use std::fs::File;
use std::io::{self, BufRead, BufReader};
use std::path::Path;

use flate2::read::GzDecoder;

use super::{EVENTS_FILE, EVENTS_GZ_FILE, Record};

/// The records of one run, oldest first. A line that does not parse (the last one of a run cut off by a power loss)
/// is skipped and counted, not an error.
pub struct Events {
    lines: io::Lines<Box<dyn BufRead + Send>>,
    skipped: usize,
}

impl Events {
    pub(super) fn open(dir: &Path) -> io::Result<Self> {
        let gz = dir.join(EVENTS_GZ_FILE);
        let reader: Box<dyn BufRead + Send> = if gz.is_file() {
            Box::new(BufReader::new(GzDecoder::new(File::open(gz)?)))
        } else {
            Box::new(BufReader::new(File::open(dir.join(EVENTS_FILE))?))
        };
        Ok(Self {
            lines: reader.lines(),
            skipped: 0,
        })
    }

    pub fn skipped(&self) -> usize {
        self.skipped
    }
}

impl Iterator for Events {
    type Item = io::Result<Record>;

    fn next(&mut self) -> Option<Self::Item> {
        loop {
            let line = match self.lines.next()? {
                Ok(line) => line,
                Err(e) => return Some(Err(e)),
            };
            match serde_json::from_str(&line) {
                Ok(record) => return Some(Ok(record)),
                Err(_) => self.skipped += 1,
            }
        }
    }
}
