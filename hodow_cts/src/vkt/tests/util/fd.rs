// SPDX-License-Identifier: Apache-2.0
//
// File descriptor types for the external memory, fence and semaphore code: `std::os::fd` where it exists, stand-ins where it does not.
// A Windows driver offers no opaque fd, sync fd or dma-buf handle types, so the cases that use these are reported NotSupported before they
// create anything; the stand-ins only let that code compile.

#[cfg(unix)]
pub use std::os::fd::{AsRawFd, FromRawFd, IntoRawFd, OwnedFd, RawFd};

#[cfg(not(unix))]
pub use stand_in::{AsRawFd, FromRawFd, IntoRawFd, OwnedFd, RawFd};

#[cfg(not(unix))]
mod stand_in {
    pub type RawFd = i32;

    pub trait AsRawFd {
        fn as_raw_fd(&self) -> RawFd;
    }

    pub trait FromRawFd {
        /// # Safety
        /// Mirrors `std::os::fd::FromRawFd`; there is nothing to own on this platform.
        unsafe fn from_raw_fd(fd: RawFd) -> Self;
    }

    pub trait IntoRawFd {
        fn into_raw_fd(self) -> RawFd;
    }

    pub struct OwnedFd(RawFd);

    impl OwnedFd {
        pub fn try_clone(&self) -> std::io::Result<Self> {
            Err(std::io::ErrorKind::Unsupported.into())
        }
    }

    impl AsRawFd for OwnedFd {
        fn as_raw_fd(&self) -> RawFd {
            self.0
        }
    }

    impl FromRawFd for OwnedFd {
        unsafe fn from_raw_fd(fd: RawFd) -> Self {
            Self(fd)
        }
    }

    impl IntoRawFd for OwnedFd {
        fn into_raw_fd(self) -> RawFd {
            self.0
        }
    }
}
