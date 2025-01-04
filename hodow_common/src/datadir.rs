use std::ffi::OsString;
use std::path::{Path, PathBuf};

pub const ENV_VAR: &str = "HODOW_HOME";

#[derive(Clone, Debug, PartialEq, Eq)]
pub struct DataDir {
    root: PathBuf,
}

impl DataDir {
    pub fn at(root: impl Into<PathBuf>) -> Self {
        Self { root: root.into() }
    }

    /// Precedence: explicit path (the `--data-dir` flag), `$HODOW_HOME`, then the platform default.
    pub fn resolve(explicit: Option<&Path>) -> Self {
        let exe_dir = std::env::current_exe()
            .ok()
            .and_then(|p| p.parent().map(Path::to_path_buf));
        Self::resolve_with(
            explicit,
            |k| std::env::var_os(k),
            |p| std::fs::create_dir_all(p).is_ok(),
            exe_dir,
        )
    }

    pub fn resolve_with(
        explicit: Option<&Path>,
        env: impl Fn(&str) -> Option<OsString>,
        usable: impl Fn(&Path) -> bool,
        exe_dir: Option<PathBuf>,
    ) -> Self {
        let non_empty = |k: &str| env(k).filter(|v| !v.is_empty()).map(PathBuf::from);
        if let Some(p) = explicit {
            return Self::at(p);
        }
        if let Some(p) = non_empty(ENV_VAR) {
            return Self::at(p);
        }
        if let Some(p) = platform_default(&non_empty) {
            return Self::at(p);
        }
        let system = PathBuf::from("/var/lib/hodow");
        if cfg!(unix) && usable(&system) {
            return Self::at(system);
        }
        Self::at(exe_dir.unwrap_or_else(|| PathBuf::from(".")).join("hodow-data"))
    }

    pub fn root(&self) -> &Path {
        &self.root
    }

    pub fn results(&self) -> PathBuf {
        self.root.join("results")
    }

    pub fn logs(&self) -> PathBuf {
        self.root.join("logs")
    }

    pub fn serve(&self) -> PathBuf {
        self.root.join("serve")
    }

    pub fn ensure(&self) -> std::io::Result<()> {
        for dir in [self.results(), self.logs(), self.serve()] {
            std::fs::create_dir_all(dir)?;
        }
        Ok(())
    }
}

#[cfg(windows)]
fn platform_default(var: &dyn Fn(&str) -> Option<PathBuf>) -> Option<PathBuf> {
    var("LOCALAPPDATA").map(|p| p.join("hodow"))
}

#[cfg(not(windows))]
fn platform_default(var: &dyn Fn(&str) -> Option<PathBuf>) -> Option<PathBuf> {
    var("XDG_DATA_HOME")
        .or_else(|| var("HOME").map(|h| h.join(".local").join("share")))
        .map(|p| p.join("hodow"))
}

#[cfg(test)]
mod tests {
    use super::*;

    fn env_of(pairs: &'static [(&'static str, &'static str)]) -> impl Fn(&str) -> Option<OsString> {
        move |k| pairs.iter().find(|(n, _)| *n == k).map(|(_, v)| OsString::from(v))
    }

    #[test]
    fn flag_beats_variable_beats_default() {
        let env = env_of(&[("HODOW_HOME", "/from/env"), ("HOME", "/home/u")]);
        let flag = DataDir::resolve_with(Some(Path::new("/from/flag")), &env, |_| true, None);
        assert_eq!(flag.root(), Path::new("/from/flag"));
        let var = DataDir::resolve_with(None, &env, |_| true, None);
        assert_eq!(var.root(), Path::new("/from/env"));
    }

    #[cfg(unix)]
    #[test]
    fn xdg_then_home_then_system_then_next_to_the_binary() {
        let xdg = DataDir::resolve_with(None, env_of(&[("XDG_DATA_HOME", "/x"), ("HOME", "/h")]), |_| true, None);
        assert_eq!(xdg.root(), Path::new("/x/hodow"));
        let home = DataDir::resolve_with(None, env_of(&[("HOME", "/h")]), |_| true, None);
        assert_eq!(home.root(), Path::new("/h/.local/share/hodow"));
        let empty_home = DataDir::resolve_with(None, env_of(&[("HOME", "")]), |_| true, None);
        assert_eq!(empty_home.root(), Path::new("/var/lib/hodow"));
        let beside = DataDir::resolve_with(None, env_of(&[]), |_| false, Some(PathBuf::from("/opt/hodow")));
        assert_eq!(beside.root(), Path::new("/opt/hodow/hodow-data"));
    }

    #[test]
    fn ensure_creates_the_three_directories() {
        let tmp = tempfile::tempdir().unwrap();
        let dir = DataDir::at(tmp.path().join("h"));
        dir.ensure().unwrap();
        assert!(dir.results().is_dir() && dir.logs().is_dir() && dir.serve().is_dir());
    }
}
