use crate::spec::Target;

pub fn target() -> Target {
    let mut base = super::hermit_kernel_base::opts();
    base.max_atomic_width = Some(128);
    base.abi = "softfloat".to_string();
    base.features = "+strict-align,-neon,-fp-armv8".to_string();

    Target {
        llvm_target: "aarch64-unknown-hermit".to_string(),
        pointer_width: 64,
        data_layout: "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128".to_string(),
        arch: "aarch64".to_string(),
        options: base,
    }
}
