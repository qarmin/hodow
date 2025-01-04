//! What every hodow module shares: the event protocol a run speaks, the progress state built from it,
//! and the on-disk store results are kept in. Depends on nothing else in the workspace.

pub mod datadir;
pub mod event;
pub mod report;
pub mod sink;
pub mod state;
pub mod store;
pub mod time;
pub mod tree;

pub use datadir::DataDir;
pub use event::{Event, Finding, Level, RunStatus, StepId, StepOutcome, Summary, Verdict};
pub use report::{Reporter, Step};
pub use sink::Sink;
pub use state::RunState;
pub use store::{RunMeta, RunWriter, Store};
