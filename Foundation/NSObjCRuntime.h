/* 
   NSObjCRuntime.h

   Copyright (C) 1995, 1996 Ovidiu Predescu and Mircea Oancea.
   All rights reserved.

   Author: Mircea Oancea <mircea@jupiter.elcom.pub.ro>

   This file is part of libFoundation.

   Permission to use, copy, modify, and distribute this software and its
   documentation for any purpose and without fee is hereby granted, provided
   that the above copyright notice appear in all copies and that both that
   copyright notice and this permission notice appear in supporting
   documentation.

   We disclaim all warranties with regard to this software, including all
   implied warranties of merchantability and fitness, in no event shall
   we be liable for any special, indirect or consequential damages or any
   damages whatsoever resulting from loss of use, data or profits, whether in
   an action of contract, negligence or other tortious action, arising out of
   or in connection with the use or performance of this software.
*/

/*
   First edited by rplacd 4/26/11.
*/

#ifndef __NSObjCRuntime_h__
#define __NSObjCRuntime_h__

#include <Foundation/NSObject.h>

@class NSString;

#if defined(WIN32)
    #undef FOUNDATION_EXPORT
    #if defined(NSBUILDINGFOUNDATION)
	#define FOUNDATION_EXPORT __declspec(dllexport) extern
    #else
	#define FOUNDATION_EXPORT __declspec(dllimport) extern
    #endif
    #if !defined(FOUNDATION_IMPORT)
	#define FOUNDATION_IMPORT __declspec(dllimport) extern
    #endif
#endif

#if !defined(FOUNDATION_EXPORT)
    #define FOUNDATION_EXPORT extern
#endif

#if !defined(FOUNDATION_IMPORT)
    #define FOUNDATION_IMPORT extern
#endif

/* Convert to and from a String */
LF_EXPORT Class    NSClassFromString(NSString *aClassName);
LF_EXPORT SEL      NSSelectorFromString(NSString *aSelectorName);
LF_EXPORT NSString *NSStringFromClass(Class aClass);
LF_EXPORT NSString *NSStringFromSelector(SEL aSelector);

#endif /* __NSObjCRuntime_h__ */

/*
  Local Variables:
  c-basic-offset: 4
  tab-width: 8
  End:
*/
