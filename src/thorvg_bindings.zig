const std = @import("std");

// Import del header C del wrapper
const c = @cImport({
    @"#include \"src/bindings/thorvg_c_wrapper.h\"";
});

pub fn initThorvg() c_int {
    return c.thorvg_wrapper_init();
}

pub fn finishThorvg() void {
    c.thorvg_wrapper_finish();
}
