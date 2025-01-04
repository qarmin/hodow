use std::ffi::c_void;
use std::num::NonZeroIsize;

use raw_window_handle::{RawWindowHandle, Win32WindowHandle};

#[link(name = "user32")]
unsafe extern "system" {
    fn CreateWindowExW(
        ex_style: u32,
        class_name: *const u16,
        window_name: *const u16,
        style: u32,
        x: i32,
        y: i32,
        width: i32,
        height: i32,
        parent: *mut c_void,
        menu: *mut c_void,
        instance: *mut c_void,
        param: *mut c_void,
    ) -> *mut c_void;
    fn DestroyWindow(hwnd: *mut c_void) -> i32;
}

#[link(name = "kernel32")]
unsafe extern "system" {
    fn GetModuleHandleW(module_name: *const u16) -> *mut c_void;
}

/// Never shown: WGL needs some window's device context to load the extensions pbuffers and modern context creation come from.
pub struct HiddenWindow {
    hwnd: NonZeroIsize,
    instance: NonZeroIsize,
}

impl HiddenWindow {
    pub fn create() -> Option<Self> {
        let class: Vec<u16> = "STATIC\0".encode_utf16().collect();
        let name: Vec<u16> = "hodow\0".encode_utf16().collect();
        let (hwnd, instance) = unsafe {
            let instance = GetModuleHandleW(std::ptr::null());
            let hwnd = CreateWindowExW(
                0,
                class.as_ptr(),
                name.as_ptr(),
                0,
                0,
                0,
                16,
                16,
                std::ptr::null_mut(),
                std::ptr::null_mut(),
                instance,
                std::ptr::null_mut(),
            );
            (hwnd, instance)
        };
        Some(Self {
            hwnd: NonZeroIsize::new(hwnd as isize)?,
            instance: NonZeroIsize::new(instance as isize)?,
        })
    }

    pub fn raw_handle(&self) -> RawWindowHandle {
        let mut handle = Win32WindowHandle::new(self.hwnd);
        handle.hinstance = Some(self.instance);
        RawWindowHandle::Win32(handle)
    }
}

impl Drop for HiddenWindow {
    fn drop(&mut self) {
        unsafe { DestroyWindow(self.hwnd.get() as *mut c_void) };
    }
}
