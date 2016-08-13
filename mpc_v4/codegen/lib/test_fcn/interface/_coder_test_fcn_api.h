/*
 * File: _coder_test_fcn_api.h
 *
 * MATLAB Coder version            : 2.8
 * C/C++ source code generated on  : 08-Nov-2015 20:53:23
 */

#ifndef ___CODER_TEST_FCN_API_H__
#define ___CODER_TEST_FCN_API_H__

/* Include Files */
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include <stddef.h>
#include <stdlib.h>
#include "_coder_test_fcn_api.h"

/* Variable Declarations */
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

/* Function Declarations */
extern void test_fcn(int64_T a, int64_T b, int64_T *c, int64_T *d);
extern void test_fcn_api(const mxArray * const prhs[2], const mxArray *plhs[2]);
extern void test_fcn_atexit(void);
extern void test_fcn_initialize(void);
extern void test_fcn_terminate(void);
extern void test_fcn_xil_terminate(void);

#endif

/*
 * File trailer for _coder_test_fcn_api.h
 *
 * [EOF]
 */
