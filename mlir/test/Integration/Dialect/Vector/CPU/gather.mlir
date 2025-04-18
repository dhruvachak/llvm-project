// RUN: mlir-opt %s -test-lower-to-llvm  | \
// RUN: mlir-runner -e entry -entry-point-result=void \
// RUN:   -shared-libs=%mlir_c_runner_utils | \
// RUN: FileCheck %s

func.func @gather8(%base: memref<?xf32>, %indices: vector<8xi32>,
              %mask: vector<8xi1>, %pass_thru: vector<8xf32>) -> vector<8xf32> {
  %c0 = arith.constant 0: index
  %g = vector.gather %base[%c0][%indices], %mask, %pass_thru
    : memref<?xf32>, vector<8xi32>, vector<8xi1>, vector<8xf32> into vector<8xf32>
  return %g : vector<8xf32>
}

func.func @entry() {
  // Set up memory.
  %c0 = arith.constant 0: index
  %c1 = arith.constant 1: index
  %c10 = arith.constant 10: index
  %A = memref.alloc(%c10) : memref<?xf32>
  scf.for %i = %c0 to %c10 step %c1 {
    %i32 = arith.index_cast %i : index to i32
    %fi = arith.sitofp %i32 : i32 to f32
    memref.store %fi, %A[%i] : memref<?xf32>
  }

  // Set up idx vector.
  %i0 = arith.constant 0: i32
  %i1 = arith.constant 1: i32
  %i2 = arith.constant 2: i32
  %i3 = arith.constant 3: i32
  %i4 = arith.constant 4: i32
  %i5 = arith.constant 5: i32
  %i6 = arith.constant 6: i32
  %i9 = arith.constant 9: i32
  %0 = vector.broadcast %i0 : i32 to vector<8xi32>
  %1 = vector.insert %i6, %0[1] : i32 into vector<8xi32>
  %2 = vector.insert %i1, %1[2] : i32 into vector<8xi32>
  %3 = vector.insert %i3, %2[3] : i32 into vector<8xi32>
  %4 = vector.insert %i5, %3[4] : i32 into vector<8xi32>
  %5 = vector.insert %i4, %4[5] : i32 into vector<8xi32>
  %6 = vector.insert %i9, %5[6] : i32 into vector<8xi32>
  %idx = vector.insert %i2, %6[7] : i32 into vector<8xi32>

  // Set up pass thru vector.
  %u = arith.constant -7.0: f32
  %pass = vector.broadcast %u : f32 to vector<8xf32>

  // Set up masks.
  %t = arith.constant 1: i1
  %none = vector.constant_mask [0] : vector<8xi1>
  %all = vector.constant_mask [8] : vector<8xi1>
  %some = vector.constant_mask [4] : vector<8xi1>
  %more = vector.insert %t, %some[7] : i1 into vector<8xi1>

  //
  // Gather tests.
  //

  %g1 = call @gather8(%A, %idx, %all, %pass)
    : (memref<?xf32>, vector<8xi32>, vector<8xi1>, vector<8xf32>)
    -> (vector<8xf32>)
  vector.print %g1 : vector<8xf32>
  // CHECK: ( 0, 6, 1, 3, 5, 4, 9, 2 )

  %g2 = call @gather8(%A, %idx, %none, %pass)
    : (memref<?xf32>, vector<8xi32>, vector<8xi1>, vector<8xf32>)
    -> (vector<8xf32>)
  vector.print %g2 : vector<8xf32>
  // CHECK: ( -7, -7, -7, -7, -7, -7, -7, -7 )

  %g3 = call @gather8(%A, %idx, %some, %pass)
    : (memref<?xf32>, vector<8xi32>, vector<8xi1>, vector<8xf32>)
    -> (vector<8xf32>)
  vector.print %g3 : vector<8xf32>
  // CHECK: ( 0, 6, 1, 3, -7, -7, -7, -7 )

  %g4 = call @gather8(%A, %idx, %more, %pass)
    : (memref<?xf32>, vector<8xi32>, vector<8xi1>, vector<8xf32>)
    -> (vector<8xf32>)
  vector.print %g4 : vector<8xf32>
  // CHECK: ( 0, 6, 1, 3, -7, -7, -7, 2 )

  %g5 = call @gather8(%A, %idx, %all, %pass)
    : (memref<?xf32>, vector<8xi32>, vector<8xi1>, vector<8xf32>)
    -> (vector<8xf32>)
  vector.print %g5 : vector<8xf32>
  // CHECK: ( 0, 6, 1, 3, 5, 4, 9, 2 )

  memref.dealloc %A : memref<?xf32>
  return
}
