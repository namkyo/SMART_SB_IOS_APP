
#ifndef __KSW_SOCK_H__
#define __KSW_SOCK_H__

#ifdef WIN32
#include <winsock.h>
#else
#include <errno.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h> /* for AIX */
#include <string.h>
/* #include <sys/time.h> */
#endif

#define ERR_SOCKET_TIMEOUT  -100
#define NONBLOCK_MILISEC    10

/*
   SOCKET definition :
   typedef u_int   SOCKET; (in WIN32)
   there is no definition of SOCKET in unix OS 
   it need to define SOCKET type to 'int' in unix OS...
*/
#ifndef WIN32
#define SOCKET int
#endif

#ifdef  __cplusplus
extern "C" {
#endif

int CLNTSOCK_INIT	(void);
//    int SRVSOCK_INIT (int port);
SOCKET CONNECT (char *IP, unsigned short port, int timeout);
int RECV			(SOCKET s, unsigned char *vbuf, int len);
int SEND			(SOCKET s, unsigned char *vbuf, int len);
void CLOSESOCK		(SOCKET sock);
int GETSOCKERR		(void);
//int ACCEPT (SOCKET master, int timeout);

#ifdef  __cplusplus
}
#endif

#endif
