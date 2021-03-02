
#ifndef	__KSW_CMPERR_H__
#define	__KSW_CMPERR_H__

#define SETERR(ret)	__set_err__(__FILE__, __LINE__, (ret))

#ifdef  __cplusplus
extern "C" {
#endif

void print_bin(char *title, unsigned char *data, int len);
int __set_err__(char *file, int line, int code);
void __set_pki_error(char *in);
	void __set_pki_error_zero();

#ifdef  __cplusplus
}
#endif
#endif
