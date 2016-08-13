//
// File: main.cpp
//
// MATLAB Coder version            : 2.8
// C/C++ source code generated on  : 08-Nov-2015 20:53:23
//

//***********************************************************************
// This automatically generated example C main file shows how to call
// entry-point functions that MATLAB Coder generated. You must customize
// this file for your application. Do not modify this file directly.
// Instead, make a copy of this file, modify it, and integrate it into
// your development environment.
//
// This file initializes entry-point function arguments to a default
// size and value before calling the entry-point functions. It does
// not store or use any values returned from the entry-point functions.
// If necessary, it does pre-allocate memory for returned values.
// You can use this file as a starting point for a main function that
// you can deploy in your application.
//
// After you copy the file, and before you deploy it, you must make the
// following changes:
// * For variable-size function arguments, change the example sizes to
// the sizes that your application requires.
// * Change the example values of function arguments to the values that
// your application requires.
// * If the entry-point functions return values, store these values or
// otherwise use them as required by your application.
//
//***********************************************************************
// Include Files
#include "rt_nonfinite.h"
#include "test_fcn.h"
#include "main.h"
#include "test_fcn_terminate.h"
#include "test_fcn_initialize.h"

// Function Declarations
static long long argInit_int64_T();
static void main_test_fcn();

// Function Definitions

//
// Arguments    : void
// Return Type  : long long
//
static long long argInit_int64_T()
{
  return 0LL;
}

//
// Arguments    : void
// Return Type  : void
//
static void main_test_fcn()
{
  long long d;
  long long c;

  // Initialize function 'test_fcn' input arguments.
  // Call the entry-point 'test_fcn'.
  test_fcn(argInit_int64_T(), argInit_int64_T(), &c, &d);
}

//
// Arguments    : int argc
//                const char * const argv[]
// Return Type  : int
//
int main(int, const char * const [])
{
  // Initialize the application.
  // You do not need to do this more than one time.
  test_fcn_initialize();

  // Invoke the entry-point functions.
  // You can call entry-point functions multiple times.
  main_test_fcn();

  // Terminate the application.
  // You do not need to do this more than one time.
  test_fcn_terminate();
  return 0;
}

//
// File trailer for main.cpp
//
// [EOF]
//
