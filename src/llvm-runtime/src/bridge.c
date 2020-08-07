//===-- bridge.c - Implement missing functionalities ----------------------===//
//
// Part of the msp430-elf-adac Project, based on LLVM Project
// under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// Custom bridge functions implementing functionality missing from
// base LLVM runtime
//
//===----------------------------------------------------------------------===//

#include "int_lib.h"

si_int __mspabi_cmpf (float, float);
si_int __mspabi_cmpd (double, double);
su_int __mspabi_fixful(float a);

su_int __mspabi_fixful(float a)
{
    return (su_int)a;
}

si_int __mspabi_cmpf (float x, float y)
{
  if (x < y)
    return -1;
  if (x > y)
    return 1;
  return 0;
}

si_int __mspabi_cmpd (double x, double y)
{
  if (x < y)
    return -1;
  if (x > y)
    return 1;
  return 0;
}
