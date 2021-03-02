#ifndef __THREAD_H__
#define __THREAD_H__

#ifdef WIN32
#include <windows.h>
#include <process.h>
#define	THREAD_STACK_SIZE	15536
#define	BEGINTHREAD(func,arg)	    _beginthread((void (*) (void *))func,THREAD_STACK_SIZE,(void *)(arg))
#define	ENDTHREAD()		        	_endthread()
#define	CREATEMUTEX(mutex)	        ((mutex) = CreateMutex(NULL,FALSE,NULL))
#define	MUTEXLOCK(mutex)	        (WaitForSingleObject((mutex),INFINITE))
#define	MUTEXUNLOCK(mutex)          (ReleaseMutex((mutex)))
#define	SLEEP(period)	            Sleep((period)*1000)

#else
#include <pthread.h>
#include <unistd.h>
/*
pthread_t	tid;
*/
#define	HANDLE	pthread_mutex_t
#define	BEGINTHREAD(func,arg) 		pthread_create(&tid,NULL,(void*(*)(void*))func,(void*)(arg))
#define	ENDTHREAD()					pthread_exit(NULL)
#define CREATEMUTEX(mutex)			(!pthread_mutex_init(&(mutex),NULL))
#define	MUTEXLOCK(mutex)			(pthread_mutex_lock(&(mutex)))
#define MUTEXUNLOCK(mutex)  		(!pthread_mutex_unlock(&(mutex)))
#define MUTEXDISTROY(mutex)         (pthread_mutex_destroy(&(mutex)))
#define	SLEEP(period)	    		sleep((period))
#endif

#endif 

