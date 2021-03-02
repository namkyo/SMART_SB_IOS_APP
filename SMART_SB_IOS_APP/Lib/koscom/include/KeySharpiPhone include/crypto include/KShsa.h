#ifndef __KSW_HSA_H__
#define __KSW_HSA_H__

#include "KSclient.h"
#include "KSdefine.h"
#include "KSdh.h"
#include "KSsha.h"
#include "KSbin.h"
#include "KSx509.h"
//#include "Util.h"


int encode101Hsa(char* encoded101Message, char* SN);
void decode101Hsa(char* buf, char* cnum);
int encode103Hsa(char* encoded103Message, char* SN);
int decode103Hsa(char* buf, char* SN);
int decode105Hsa(char* buf, ks_uint8* relayCert, int* relayCertLen, ks_uint8* relayKey, int* relayKeyLen);

#endif

