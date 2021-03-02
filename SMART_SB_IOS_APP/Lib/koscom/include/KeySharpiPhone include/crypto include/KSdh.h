
#ifndef __KSDH_H__
#define __KSDH_H__

#include "KSpkcs1.h"
#include "KSbigint.h"
#include "KShmac.h"
#include "KSsha.h"
#include "KSseed.h"
#include "KSutil.h"
#include <string.h>

//extern M_Byte m128Key[128], m16Key[16], mIv[16], mMacKey[20];
//
//M_Int32 get_dh_V(M_Byte *);
//M_Int32 get_dh_Key(M_Byte*, M_Byte*);
//M_Int32 get_dh_U(M_Byte*);
//M_Int32 get_dh_Key1(M_Byte*, M_Byte*);
void getK(char *, int);
int dhSeedEncrypt(char *, char *, int);
int dhSeedDecrypt(char *, char *, int);
//void dhgetMac(M_Byte *, M_Byte *, M_Int32);

int get_dh_V(char* out);
void dhgetMac(char *out, char *src, int srcLen);

#endif


