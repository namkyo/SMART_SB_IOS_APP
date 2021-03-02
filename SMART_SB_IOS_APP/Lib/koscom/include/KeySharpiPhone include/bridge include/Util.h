/*
 *  testModule.h
 *  SecurityLibraryTest
 *
 *  Created by leopard on 09. 07. 17.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

//include headers
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <errno.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <sys/time.h>
#include <netdb.h> //<--added 20100218
#include "KSsock.h"


//defines
#define NUM_THREAD  10

extern char* relay_server_ip;
extern unsigned short relay_server_port;

extern char* test_server_ip;
extern unsigned short test_server_port;

#define PLAIN_MSG			"Long Time No See!"

#define MSGTYPE_SESSION_KEY	0x03
#define MSGTYPE_CIPHER	0x04
#define MSGTYPE_SIGNED	0x10

void getProtocolHeader(char* header);
void getProtocolHeaderWithSN(char* header, char* SN);
void getPhoneNumber(char* phoneNum);
int msg_read(SOCKET sock, char *out, unsigned char type);
int msg_write(SOCKET sock, char *_in, int len, unsigned char type);
int encryptAndWrite(SOCKET sock, char* sendBuf, int sendBufLen, char type);
int readAndDecrypt(SOCKET sock, char* out, char* readBuf, char type);
int makeHandshake(char* serverIP, int serverPort);
int HANDSHAKE(SOCKET sock, char type);
int test_encdec(char* signSource, int signSourceLen, char* decodeMessage);
int isThisURL(char* addr);
int getIPAddressFromURL(char* ipAddr, char* url);
int makeHandshakeWithTimeout(char* serverIP, int serverPort, int timeout);

int getPasswdFromTranskeyEncData(unsigned char* output, int* outputLen, unsigned char* random, int randomLen, unsigned char* encData, int encDataLen);
int getSeedKeyForTransKey(unsigned char* output, int* outLen, unsigned char* random, int randomLen);