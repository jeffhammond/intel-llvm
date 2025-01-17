; update_test_checks.py will hardcode the block names.
; Used flexible names to align with the our version of the inliner.
; If this needs an update in the future, it should just be copied to a new file.

; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S < %s -instcombine -inline -jump-threading -loop-unroll -unroll-count=4 | FileCheck %s
;
; This is a test case that required a number of setup passes because
; it depends on block order.

target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-macosx10.6.8"

declare i1 @check() nounwind
declare i32 @getval() nounwind

; Check that the loop exit merges values from all the iterations. This
; could be a tad fragile, but it's a good test.
;
define i32 @foo() uwtable ssp align 2 {
;
; CHECK-LABEL: @foo(
; CHECK-NEXT:  if.end:
; CHECK-NEXT:    [[CALL2:%.*]] = call i32 @getval()
; CHECK-NEXT:    br label %[[LAND_LHS_TRUE_I:.*]]
; CHECK: [[LAND_LHS_TRUE_I]]
; CHECK-NEXT:    [[CMP4_I:%.*]] = call zeroext i1 @check() #[[ATTR0:[0-9]+]]
; CHECK-NEXT:    br i1 [[CMP4_I]], label [[BAR_EXIT:%.*]], label [[DO_COND:%.*]]
; CHECK:       bar.exit:
; CHECK-NEXT:    [[TMP7_I:%.*]] = call i32 @getval() #[[ATTR0]]
; CHECK-NEXT:    [[CMP_NOT:%.*]] = icmp eq i32 [[TMP7_I]], 0

; CHECK-NEXT:    br i1 [[CMP_NOT]], label [[DO_COND]], label %[[LAND_LHS_TRUE:.*]]
; CHECK: [[LAND_LHS_TRUE]]
; CHECK-NEXT:    [[CALL10:%.*]] = call i32 @getval()
; CHECK-NEXT:    [[CMP11:%.*]] = icmp eq i32 [[CALL10]], 0
; CHECK-NEXT:    br i1 [[CMP11]], label [[RETURN:%.*]], label [[DO_COND]]
; CHECK:       do.cond:
; CHECK-NEXT:    [[CMP18:%.*]] = icmp sgt i32 [[CALL2]], -1
; CHECK-NEXT:    br i1 [[CMP18]], label %[[LAND_LHS_TRUE_I_1:.*]], label [[RETURN]]
; CHECK: [[LAND_LHS_TRUE_I_1]]
; CHECK-NEXT:    [[CMP4_I_1:%.*]] = call zeroext i1 @check() #[[ATTR0]]
; CHECK-NEXT:    br i1 [[CMP4_I_1]], label [[BAR_EXIT_1:%.*]], label [[DO_COND_1:%.*]]
; CHECK:       bar.exit.1:
; CHECK-NEXT:    [[TMP7_I_1:%.*]] = call i32 @getval() #[[ATTR0]]
; CHECK-NEXT:    [[CMP_NOT_1:%.*]] = icmp eq i32 [[TMP7_I_1]], 0
; CHECK-NEXT:    br i1 [[CMP_NOT_1]], label [[DO_COND_1]], label [[LAND_LHS_TRUE_1:%.*]]
; CHECK:       land.lhs.true.1:
; CHECK-NEXT:    [[CALL10_1:%.*]] = call i32 @getval()
; CHECK-NEXT:    [[CMP11_1:%.*]] = icmp eq i32 [[CALL10_1]], 0
; CHECK-NEXT:    br i1 [[CMP11_1]], label [[RETURN]], label [[DO_COND_1]]
; CHECK:       do.cond.1:
; CHECK-NEXT:    [[CMP18_1:%.*]] = icmp sgt i32 [[CALL2]], -1
; CHECK-NEXT:    br i1 [[CMP18_1]], label %[[LAND_LHS_TRUE_I_2:.*]], label [[RETURN]]
; CHECK: [[LAND_LHS_TRUE_I_2]]
; CHECK-NEXT:    [[CMP4_I_2:%.*]] = call zeroext i1 @check() #[[ATTR0]]
; CHECK-NEXT:    br i1 [[CMP4_I_2]], label [[BAR_EXIT_2:%.*]], label [[DO_COND_2:%.*]]
; CHECK:       bar.exit.2:
; CHECK-NEXT:    [[TMP7_I_2:%.*]] = call i32 @getval() #[[ATTR0]]
; CHECK-NEXT:    [[CMP_NOT_2:%.*]] = icmp eq i32 [[TMP7_I_2]], 0
; CHECK-NEXT:    br i1 [[CMP_NOT_2]], label [[DO_COND_2]], label [[LAND_LHS_TRUE_2:%.*]]
; CHECK:       land.lhs.true.2:
; CHECK-NEXT:    [[CALL10_2:%.*]] = call i32 @getval()
; CHECK-NEXT:    [[CMP11_2:%.*]] = icmp eq i32 [[CALL10_2]], 0
; CHECK-NEXT:    br i1 [[CMP11_2]], label [[RETURN]], label [[DO_COND_2]]
; CHECK:       do.cond.2:
; CHECK-NEXT:    [[CMP18_2:%.*]] = icmp sgt i32 [[CALL2]], -1
; CHECK-NEXT:    br i1 [[CMP18_2]], label %[[LAND_LHS_TRUE_I_3:.*]], label [[RETURN]]
; CHECK: [[LAND_LHS_TRUE_I_3]]
; CHECK-NEXT:    [[CMP4_I_3:%.*]] = call zeroext i1 @check() #[[ATTR0]]
; CHECK-NEXT:    br i1 [[CMP4_I_3]], label [[BAR_EXIT_3:%.*]], label [[DO_COND_3:%.*]]
; CHECK:       bar.exit.3:
; CHECK-NEXT:    [[TMP7_I_3:%.*]] = call i32 @getval() #[[ATTR0]]
; CHECK-NEXT:    [[CMP_NOT_3:%.*]] = icmp eq i32 [[TMP7_I_3]], 0
; CHECK-NEXT:    br i1 [[CMP_NOT_3]], label [[DO_COND_3]], label [[LAND_LHS_TRUE_3:%.*]]
; CHECK:       land.lhs.true.3:
; CHECK-NEXT:    [[CALL10_3:%.*]] = call i32 @getval()
; CHECK-NEXT:    [[CMP11_3:%.*]] = icmp eq i32 [[CALL10_3]], 0
; CHECK-NEXT:    br i1 [[CMP11_3]], label [[RETURN]], label [[DO_COND_3]]
; CHECK:       do.cond.3:
; CHECK-NEXT:    [[CMP18_3:%.*]] = icmp sgt i32 [[CALL2]], -1
; CHECK-NEXT:    br i1 [[CMP18_3]], label %[[LAND_LHS_TRUE_I]], label [[RETURN]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       return:
; CHECK-NEXT:    [[RETVAL_0:%.*]] = phi i32 [ [[TMP7_I]], %[[LAND_LHS_TRUE]] ], [ 0, [[DO_COND]] ], [ [[TMP7_I_1]], [[LAND_LHS_TRUE_1]] ], [ 0, [[DO_COND_1]] ], [ [[TMP7_I_2]], [[LAND_LHS_TRUE_2]] ], [ 0, [[DO_COND_2]] ], [ [[TMP7_I_3]], [[LAND_LHS_TRUE_3]] ], [ 0, [[DO_COND_3]] ]
; CHECK-NEXT:    ret i32 [[RETVAL_0]]
;
entry:
  br i1 undef, label %return, label %if.end

if.end:                                           ; preds = %entry
  %call2 = call i32 @getval()
  br label %do.body

do.body:                                          ; preds = %do.cond, %if.end
  %call6 = call i32 @bar()
  %cmp = icmp ne i32 %call6, 0
  br i1 %cmp, label %land.lhs.true, label %do.cond

land.lhs.true:                                    ; preds = %do.body
  %call10 = call i32 @getval()
  %cmp11 = icmp eq i32 0, %call10
  br i1 %cmp11, label %return, label %do.cond

do.cond:                                          ; preds = %land.lhs.true, %do.body
  %cmp18 = icmp sle i32 0, %call2
  br i1 %cmp18, label %do.body, label %return

return:                                           ; preds = %do.cond, %land.lhs.true, %entry
  %retval.0 = phi i32 [ 0, %entry ], [ %call6, %land.lhs.true ], [ 0, %do.cond ]
  ret i32 %retval.0
}

define linkonce_odr i32 @bar() nounwind uwtable ssp align 2 {
; This function is dead and should not be checked.
entry:
  br i1 undef, label %land.lhs.true, label %cond.end

land.lhs.true:                                    ; preds = %entry
  %cmp4 = call zeroext i1 @check()
  br i1 %cmp4, label %cond.true, label %cond.end

cond.true:                                        ; preds = %land.lhs.true
  %tmp7 = call i32 @getval()
  br label %cond.end

cond.end:                                         ; preds = %cond.true, %land.lhs.true, %entry
  %cond = phi i32 [ %tmp7, %cond.true ], [ 0, %land.lhs.true ], [ 0, %entry ]
  ret i32 %cond
}
