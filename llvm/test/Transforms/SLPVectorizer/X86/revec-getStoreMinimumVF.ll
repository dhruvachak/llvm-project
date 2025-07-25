; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -mtriple=x86_64-unknown-linux-gnu -passes=slp-vectorizer -S -slp-revec %s | FileCheck %s

define void @test() {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    store <8 x i8> zeroinitializer, ptr null, align 1
; CHECK-NEXT:    ret void
;
entry:
  %0 = getelementptr i8, ptr null, i64 4
  store <4 x i8> zeroinitializer, ptr null, align 1
  store <4 x i8> zeroinitializer, ptr %0, align 1
  ret void
}
