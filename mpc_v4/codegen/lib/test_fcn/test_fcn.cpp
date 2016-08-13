//
// File: test_fcn.cpp
//
// MATLAB Coder version            : 2.8
// C/C++ source code generated on  : 08-Nov-2015 20:53:23
//

// Include Files
#include "rt_nonfinite.h"
#include "test_fcn.h"

// Function Declarations
static long long mul_s64_s64_s64_sat(long long a, long long b);
static void mul_wide_s64(long long in0, long long in1, unsigned long long
  *ptrOutBitsHi, unsigned long long *ptrOutBitsLo);

// Function Definitions

//
// Arguments    : long long a
//                long long b
// Return Type  : long long
//
static long long mul_s64_s64_s64_sat(long long a, long long b)
{
  long long result;
  unsigned long long u64_clo;
  unsigned long long u64_chi;
  mul_wide_s64(a, b, &u64_chi, &u64_clo);
  if (((long long)u64_chi > 0LL) || ((u64_chi == 0ULL) && (u64_clo >=
        9223372036854775808ULL))) {
    result = MAX_int64_T;
  } else if (((long long)u64_chi < -1LL) || (((long long)u64_chi == -1LL) &&
              (u64_clo < 9223372036854775808ULL))) {
    result = MIN_int64_T;
  } else {
    result = (long long)u64_clo;
  }

  return result;
}

//
// Arguments    : long long in0
//                long long in1
//                unsigned long long *ptrOutBitsHi
//                unsigned long long *ptrOutBitsLo
// Return Type  : void
//
static void mul_wide_s64(long long in0, long long in1, unsigned long long
  *ptrOutBitsHi, unsigned long long *ptrOutBitsLo)
{
  unsigned long long absIn0;
  unsigned long long absIn1;
  int negativeProduct;
  unsigned long long in0Hi;
  unsigned long long in0Lo;
  unsigned long long productHiHi;
  unsigned long long productHiLo;
  unsigned long long productLoHi;
  if (in0 < 0LL) {
    absIn0 = (unsigned long long)-in0;
  } else {
    absIn0 = (unsigned long long)in0;
  }

  if (in1 < 0LL) {
    absIn1 = (unsigned long long)-in1;
  } else {
    absIn1 = (unsigned long long)in1;
  }

  negativeProduct = !((in0 == 0LL) || ((in1 == 0LL) || ((in0 > 0LL) == (in1 >
    0LL))));
  in0Hi = absIn0 >> 32ULL;
  in0Lo = absIn0 & 4294967295ULL;
  absIn0 = absIn1 >> 32ULL;
  absIn1 &= 4294967295ULL;
  productHiHi = in0Hi * absIn0;
  productHiLo = in0Hi * absIn1;
  productLoHi = in0Lo * absIn0;
  absIn0 = in0Lo * absIn1;
  absIn1 = 0ULL;
  in0Hi = absIn0 + (productLoHi << 32ULL);
  if (in0Hi < absIn0) {
    absIn1 = 1ULL;
  }

  absIn0 = in0Hi;
  in0Hi += productHiLo << 32ULL;
  if (in0Hi < absIn0) {
    absIn1++;
  }

  absIn0 = ((absIn1 + productHiHi) + (productLoHi >> 32ULL)) + (productHiLo >>
    32ULL);
  if (negativeProduct) {
    absIn0 = ~absIn0;
    in0Hi = ~in0Hi;
    in0Hi++;
    if (in0Hi == 0ULL) {
      absIn0++;
    }
  }

  *ptrOutBitsHi = absIn0;
  *ptrOutBitsLo = in0Hi;
}

//
// Arguments    : long long a
//                long long b
//                long long *c
//                long long *d
// Return Type  : void
//
void test_fcn(long long a, long long b, long long *c, long long *d)
{
  long long q0;
  long long q1;
  long long qY;
  q0 = a;
  q1 = b;
  qY = q0 + q1;
  if ((q0 < 0LL) && ((q1 < 0LL) && (qY >= 0LL))) {
    qY = MIN_int64_T;
  } else {
    if ((q0 > 0LL) && ((q1 > 0LL) && (qY <= 0LL))) {
      qY = MAX_int64_T;
    }
  }

  *c = qY;
  *d = mul_s64_s64_s64_sat(a, b);
}

//
// File trailer for test_fcn.cpp
//
// [EOF]
//
