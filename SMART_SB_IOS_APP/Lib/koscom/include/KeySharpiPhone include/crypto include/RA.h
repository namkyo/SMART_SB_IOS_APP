/*
 *  RA.h
 *  SecurityLibraryTest
 *
 *  Created by leopard on 09. 07. 20.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

#include <time.h>

struct tm* getCurrentTime();
char* makeMessageIssue(int* length);
void sendRAMessage(char* raMsg, int raMsgLen, char* raIP, int raPort, char* refNum, char* authCode);
