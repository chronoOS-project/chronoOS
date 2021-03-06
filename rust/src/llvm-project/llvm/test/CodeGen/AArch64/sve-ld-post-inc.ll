; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

; These tests are here to ensure we don't get a selection error caused
; by performPostLD1Combine, which should bail out if the return
; type is not 128 or 64 bit vector.

define <vscale x 4 x i32> @test_post_ld1_insert(i32* %a, i32** %ptr, i64 %inc) {
; CHECK-LABEL: test_post_ld1_insert:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr w8, [x0]
; CHECK-NEXT:    fmov s0, w8
; CHECK-NEXT:    add x8, x0, x2, lsl #2
; CHECK-NEXT:    str x8, [x1]
; CHECK-NEXT:    ret
  %load = load i32, i32* %a
  %ins = insertelement <vscale x 4 x i32> undef, i32 %load, i32 0
  %gep = getelementptr i32, i32* %a, i64 %inc
  store i32* %gep, i32** %ptr
  ret <vscale x 4 x i32> %ins
}

define <vscale x 2 x double> @test_post_ld1_dup(double* %a, double** %ptr, i64 %inc) {
; CHECK-LABEL: test_post_ld1_dup:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    add x8, x0, x2, lsl #3
; CHECK-NEXT:    ld1rd { z0.d }, p0/z, [x0]
; CHECK-NEXT:    str x8, [x1]
; CHECK-NEXT:    ret
  %load = load double, double* %a
  %dup = call <vscale x 2 x double> @llvm.aarch64.sve.dup.x.nxv2f64(double %load)
  %gep = getelementptr double, double* %a, i64 %inc
  store double* %gep, double** %ptr
  ret <vscale x 2 x double> %dup
}

define <4 x i64> @test_post_ld1_int_fixed(i64* %data, i64 %idx, <4 x i64>* %addr)  #1 {
; CHECK-LABEL: test_post_ld1_int_fixed:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    mov w9, #2
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x2]
; CHECK-NEXT:    ldr x10, [x0, x1, lsl #3]
; CHECK-NEXT:    ldr x11, [x0]
; CHECK-NEXT:    index z3.d, #0, #1
; CHECK-NEXT:    mov z2.d, x9
; CHECK-NEXT:    ptrue p1.d, vl1
; CHECK-NEXT:    cmpeq p2.d, p0/z, z3.d, z2.d
; CHECK-NEXT:    mov z1.d, z0.d
; CHECK-NEXT:    mov z0.d, p2/m, x10
; CHECK-NEXT:    mov z1.d, p1/m, x11
; CHECK-NEXT:    add z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT:    st1d { z0.d }, p0, [x8]
; CHECK-NEXT:    ret
  %A = load <4 x i64>, <4 x i64>* %addr
  %ld1 = load i64, i64* %data
  %vec1 = insertelement <4 x i64> %A, i64 %ld1, i32 0
  %gep = getelementptr i64, i64* %data, i64 %idx
  %ld2 = load i64, i64* %gep
  %vec2 = insertelement <4 x i64> %A, i64 %ld2, i32 2
  %res = add <4 x i64> %vec1, %vec2
  ret <4 x i64> %res
}

define <4 x double> @test_post_ld1_double_fixed(double* %data, i64 %idx, <4 x double>* %addr)  #1 {
; CHECK-LABEL: test_post_ld1_double_fixed:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    mov w9, #2
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x2]
; CHECK-NEXT:    ldr d1, [x0, x1, lsl #3]
; CHECK-NEXT:    ldr d2, [x0]
; CHECK-NEXT:    index z4.d, #0, #1
; CHECK-NEXT:    mov z3.d, x9
; CHECK-NEXT:    ptrue p1.d, vl1
; CHECK-NEXT:    cmpeq p2.d, p0/z, z4.d, z3.d
; CHECK-NEXT:    sel z2.d, p1, z2.d, z0.d
; CHECK-NEXT:    mov z0.d, p2/m, d1
; CHECK-NEXT:    fadd z0.d, z2.d, z0.d
; CHECK-NEXT:    st1d { z0.d }, p0, [x8]
; CHECK-NEXT:    ret
  %A = load <4 x double>, <4 x double>* %addr
  %ld1 = load double, double* %data
  %vec1 = insertelement <4 x double> %A, double %ld1, i32 0
  %gep = getelementptr double, double* %data, i64 %idx
  %ld2 = load double, double* %gep
  %vec2 = insertelement <4 x double> %A, double %ld2, i32 2
  %res = fadd <4 x double> %vec1, %vec2
  ret <4 x double> %res
}
attributes #1 = { vscale_range(2,2) "target-features"="+neon,+sve" }

declare <vscale x 2 x double> @llvm.aarch64.sve.dup.x.nxv2f64(double)
