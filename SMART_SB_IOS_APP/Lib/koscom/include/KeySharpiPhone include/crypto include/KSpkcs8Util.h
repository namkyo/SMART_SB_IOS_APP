/*
 *  pkcs8Util.h
 *  SecurityLibraryTest
 *
 *  Created by leopard on 09. 08. 10.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

#ifndef __KSW_PKCS8Util_H__
#define __KSW_PKCS8Util_H__

#include "KSpkcs8.h"
#include "KSdefine.h"

int changePassword(ks_uint8 *out, int *outLen, ks_uint8 *in, int inLen, ks_uint8 *oldPasswd, int oldPasswdLen, ks_uint8 *newPasswd, int newPasswdLen);
int checkPassword(ks_uint8 *in, int inLen, ks_uint8 *currentPasswd, int currentPasswdLen);

#endif