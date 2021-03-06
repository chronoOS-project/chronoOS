; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve -verify-machineinstrs < %s | FileCheck %s

; Test that the select returns %true, because the predicate is all active.
define <vscale x 4 x i32> @select_ptrue_fold_all_active(<vscale x 4 x i32> %false, <vscale x 4 x i32> %true) {
; CHECK-LABEL: select_ptrue_fold_all_active:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.d, z1.d
; CHECK-NEXT:    ret
  %p = call <vscale x 4 x i1> @llvm.aarch64.sve.ptrue.nxv4i1(i32 31)
  %res = select <vscale x 4 x i1> %p, <vscale x 4 x i32> %true, <vscale x 4 x i32> %false
  ret <vscale x 4 x i32> %res
}

; Test that the select returns %true, because the predicate is all active for vscale_range(2, 2)
define <vscale x 4 x i32> @select_ptrue_fold_vl8(<vscale x 4 x i32> %false, <vscale x 4 x i32> %true) vscale_range(2, 2) {
; CHECK-LABEL: select_ptrue_fold_vl8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.d, z1.d
; CHECK-NEXT:    ret
  %p = call <vscale x 4 x i1> @llvm.aarch64.sve.ptrue.nxv4i1(i32 8)
  %res = select <vscale x 4 x i1> %p, <vscale x 4 x i32> %true, <vscale x 4 x i32> %false
  ret <vscale x 4 x i32> %res
}

define <vscale x 16 x i8> @select_ptrue_fold_all_inactive(<vscale x 16 x i8> %true, <vscale x 16 x i8> %false) {
; CHECK-LABEL: select_ptrue_fold_all_inactive:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.d, z1.d
; CHECK-NEXT:    ret
  %p = call <vscale x 16 x  i1> @llvm.aarch64.sve.convert.from.svbool.nxv16i1(<vscale x 16 x i1> zeroinitializer)
  %res = select <vscale x 16 x  i1> %p, <vscale x 16 x i8> %true, <vscale x 16 x i8> %false
  ret <vscale x 16 x i8> %res
}

define <vscale x 4 x i32> @select_ptrue_fold_all_inactive_reinterpret(<vscale x 4 x i32> %true, <vscale x 4 x i32> %false) {
; CHECK-LABEL: select_ptrue_fold_all_inactive_reinterpret:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.d, z1.d
; CHECK-NEXT:    ret
  %p = call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> zeroinitializer)
  %res = select <vscale x 4 x i1> %p, <vscale x 4 x i32> %true, <vscale x 4 x i32> %false
  ret <vscale x 4 x i32> %res
}

; Test that the select remains, because predicate is not all active (only half lanes are set for vscale_range(2, 2))
define <vscale x 4 x i32> @select_ptrue_no_fold_vl4(<vscale x 4 x i32> %true, <vscale x 4 x i32> %false) vscale_range(2, 2) {
; CHECK-LABEL: select_ptrue_no_fold_vl4:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl4
; CHECK-NEXT:    sel z0.s, p0, z0.s, z1.s
; CHECK-NEXT:    ret
  %p = call <vscale x 4 x i1> @llvm.aarch64.sve.ptrue.nxv4i1(i32 4)
  %res = select <vscale x 4 x i1> %p, <vscale x 4 x i32> %true, <vscale x 4 x i32> %false
  ret <vscale x 4 x i32> %res
}

declare <vscale x 4 x i1> @llvm.aarch64.sve.ptrue.nxv4i1(i32)
declare <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1>)
declare <vscale x 16 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv16i1(<vscale x 16 x i1>)
