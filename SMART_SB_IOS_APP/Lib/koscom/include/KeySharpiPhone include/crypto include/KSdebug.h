#ifndef	__KS_DEBUG_H__
#define	__KS_DEBUG_H__

extern int		debug_flag;
extern char 	debug_buf[512];

void
print_bin(char *title, unsigned char *data, int len);

#endif

