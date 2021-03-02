//
//	KS_bin.h
//

#ifndef __KSW_BIN_H__
#define __KSW_BIN_H__

#include "KSdefine.h"

#ifdef  __cplusplus
extern "C" {
#endif

//
//
//
typedef struct _BIN {
    int     length;
    ks_uint8   *value;
} BIN;

BIN		*BIN_New				(int len, unsigned char *data);
BIN		*BIN_Copy				(BIN *bin);
BIN		*BIN_Merge				(BIN *bin1, BIN *bin2);
void	 BIN_Free				(BIN *bin);

//
//
//
typedef struct _BLIST {
	BIN 			*bin;
	struct _BLIST	*next;
} BLIST;

BLIST	*BLIST_New				();
BLIST	*BLIST_Copy				(BLIST *blist);
void	 BLIST_Free				(BLIST *blist);

#ifdef  __cplusplus
}
#endif

#endif
