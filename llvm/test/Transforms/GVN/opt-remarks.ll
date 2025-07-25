; RUN: opt < %s -passes=gvn -disable-output -pass-remarks=gvn -pass-remarks-missed=gvn  \
; RUN:     2>&1 | FileCheck %s
; RUN: opt < %s -passes=gvn -disable-output -pass-remarks-output=%t -S
; RUN: cat %t | FileCheck -check-prefix=YAML %s

; RUN: opt < %s -aa-pipeline=basic-aa -passes=gvn -disable-output -pass-remarks=gvn -pass-remarks-missed=gvn \
; RUN:     2>&1 | FileCheck %s
; RUN: opt < %s -aa-pipeline=basic-aa -passes=gvn -disable-output -pass-remarks-output=%t -S
; RUN: cat %t | FileCheck -check-prefix=YAML %s

; CHECK:      remark: <unknown>:0:0: load of type i32 eliminated{{$}}
; CHECK-NEXT: remark: <unknown>:0:0: load of type i32 eliminated{{$}}
; CHECK-NEXT: remark: <unknown>:0:0: load of type i32 eliminated{{$}}
; CHECK-NEXT: remark: /tmp/s.c:3:3: load of type i32 not eliminated

; YAML:      --- !Passed
; YAML-NEXT: Pass:            gvn
; YAML-NEXT: Name:            LoadElim
; YAML-NEXT: Function:        arg
; YAML-NEXT: Args:
; YAML-NEXT:   - String:          'load of type '
; YAML-NEXT:   - Type:            i32
; YAML-NEXT:   - String:          ' eliminated'
; YAML-NEXT:   - String:          ' in favor of '
; YAML-NEXT:   - InfavorOfValue:  i
; YAML-NEXT: ...
; YAML-NEXT: --- !Passed
; YAML-NEXT: Pass:            gvn
; YAML-NEXT: Name:            LoadElim
; YAML-NEXT: Function:        const
; YAML-NEXT: Args:
; YAML-NEXT:   - String:          'load of type '
; YAML-NEXT:   - Type:            i32
; YAML-NEXT:   - String:          ' eliminated'
; YAML-NEXT:   - String:          ' in favor of '
; YAML-NEXT:   - InfavorOfValue:  '4'
; YAML-NEXT: ...
; YAML-NEXT: --- !Passed
; YAML-NEXT: Pass:            gvn
; YAML-NEXT: Name:            LoadElim
; YAML-NEXT: Function:        inst
; YAML-NEXT: Args:
; YAML-NEXT:   - String:          'load of type '
; YAML-NEXT:   - Type:            i32
; YAML-NEXT:   - String:          ' eliminated'
; YAML-NEXT:   - String:          ' in favor of '
; YAML-NEXT:   - InfavorOfValue:  load
; YAML-NEXT: ...
; YAML-NEXT: --- !Missed
; YAML-NEXT: Pass:            gvn
; YAML-NEXT: Name:            LoadClobbered
; YAML-NEXT: DebugLoc:        { File: '/tmp/s.c', Line: 3, Column: 3 }
; YAML-NEXT: Function:        may_alias
; YAML-NEXT: Args:
; YAML-NEXT:   - String:          'load of type '
; YAML-NEXT:   - Type:            i32
; YAML-NEXT:   - String:          ' not eliminated'
; YAML-NEXT:   - String:          ' in favor of '
; YAML-NEXT:   - OtherAccess:     load
; YAML-NEXT:     DebugLoc:        { File: '/tmp/s.c', Line: 1, Column: 13 }
; YAML-NEXT:   - String:          ' because it is clobbered by '
; YAML-NEXT:   - ClobberedBy:     store
; YAML-NEXT:     DebugLoc:        { File: '/tmp/s.c', Line: 2, Column: 10 }
; YAML-NEXT: ...
; YAML-NEXT: --- !Missed
; YAML-NEXT: Pass:            gvn
; YAML-NEXT: Name:            LoadClobbered
; YAML-NEXT: Function:        lifetime_end
; YAML-NEXT: Args:
; YAML-NEXT:   - String:          'load of type '
; YAML-NEXT:   - Type:            i8
; YAML-NEXT:   - String:          ' not eliminated'
; YAML-NEXT:   - String:          ' in favor of '
; YAML-NEXT:   - OtherAccess:     store
; YAML-NEXT:   - String:          ' because it is clobbered by '
; YAML-NEXT:   - ClobberedBy:     call llvm.lifetime.end.p0
; YAML-NEXT: ...

define i32 @arg(ptr %p, i32 %i) {
entry:
  store i32 %i, ptr %p
  %load = load i32, ptr %p
  ret i32 %load
}

define i32 @const(ptr %p) {
entry:
  store i32 4, ptr %p
  %load = load i32, ptr %p
  ret i32 %load
}

define i32 @inst(ptr %p) {
entry:
  %load1 = load i32, ptr %p
  %load = load i32, ptr %p
  %add = add i32 %load1, %load
  ret i32 %add
}

define i32 @may_alias(ptr %p, ptr %r) !dbg !7 {
entry:
  %load1 = load i32, ptr %p, !tbaa !13, !dbg !9
  store i32 4, ptr %r, !tbaa !13, !dbg !10
  %load = load i32, ptr %p, !tbaa !13, !dbg !11
  %add = add i32 %load1, %load
  ret i32 %add
}

define i8 @lifetime_end(i8 %val) {
  %p = alloca [32 x i8]
  call void @llvm.lifetime.start.p0(i64 32, ptr %p)
  store i8 %val, ptr %p
  call void @llvm.lifetime.end.p0(i64 32, ptr %p)
  %1 = load i8, ptr %p
  ret i8 %1
}

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 4.0.0 (trunk 282540) (llvm/trunk 282542)", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, enums: !2)
!1 = !DIFile(filename: "/tmp/s.c", directory: "/tmp")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"PIC Level", i32 2}
!6 = !{!"clang version 4.0.0 (trunk 282540) (llvm/trunk 282542)"}
!7 = distinct !DISubprogram(name: "may_alias", scope: !1, file: !1, line: 1, type: !8, isLocal: false, isDefinition: true, scopeLine: 1, isOptimized: true, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !2)
!9 = !DILocation(line: 1, column: 13, scope: !7)
!10 = !DILocation(line: 2, column: 10, scope: !7)
!11 = !DILocation(line: 3, column: 3, scope: !7)

!12 = !{ !"tbaa root" }
!13 = !{ !"int", !12 }
