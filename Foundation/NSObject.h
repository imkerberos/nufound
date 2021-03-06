/* Foundation/NSObject.h.  Generated automatically by configure.  */
/* 
   NSObject.h

   Copyright (C) 1995, 1996 Ovidiu Predescu and Mircea Oancea.
   All rights reserved.

   Author: Ovidiu Predescu <ovidiu@bx.logicnet.ro>

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
   First edited by rplacd 4/23/11.
*/

#ifndef __NSObject_h__
#define __NSObject_h__

#include <objc/objc.h>

#if BUILD_libFoundation_DLL
#  define LF_EXPORT  __declspec(dllexport)
#  define LF_DECLARE __declspec(dllexport)
#elif libFoundation_ISDLL
#  define LF_EXPORT  extern __declspec(dllimport)
#  define LF_DECLARE extern __declspec(dllimport)
#else
#  define LF_EXPORT  extern
#  define LF_DECLARE 
#endif

#define LIB_FOUNDATION_LIBRARY 1

#define LIB_FOUNDATION_MAJOR_VERSION    1
#define LIB_FOUNDATION_MINOR_VERSION    1
#define LIB_FOUNDATION_SUBMINOR_VERSION 3

#ifndef NSTimeInterval__defined
#define NSTimeInterval__defined
typedef double NSTimeInterval;
#endif

#if __LP64__ || _LP64 || NS_BUILD_32_LIKE_64
typedef long NSInteger;
#else
typedef int NSInteger;
#endif

#if __LP64__ || _LP64 ||  NS_BUILD_32_LIKE_64
typedef unsigned long NSUInteger;
#else
typedef unsigned int NSUInteger;
#endif


@class Protocol;
@class NSZone;
@class NSString;
@class NSCoder;
@class NSArchiver;
@class NSMethodSignature;
@class NSInvocation;

/*
 * NSObject protocol
 */

@protocol NSObject

/* Identifying Class and Superclass */
- (Class)class;
- (Class)superclass;

/* Determining Allocation Zones */
- (NSZone*)zone;

/* Identifying Proxies */
- (BOOL)isProxy;

/* Testing Inheritance Relationships */
- (BOOL)isKindOfClass:(Class)aClass;
- (BOOL)isMemberOfClass:(Class)aClass;

/* Testing for Protocol Conformance */
- (BOOL)conformsToProtocol:(Protocol*)aProtocol;

/* Testing Class Functionality */
- (BOOL)respondsToSelector:(SEL)aSelector;

/* Managing Reference Counts */
- (id)autorelease;
- (oneway void)release;
- (id)retain;
- (unsigned int)retainCount;

/* Identifying and Comparing Instances */
- (unsigned)hash;
- (BOOL)isEqual:(id)anObject;
- (id)self;

/* Sending Messages Determined at Run Time */
- (id)performSelector:(SEL)aSelector;
- (id)performSelector:(SEL)aSelector withObject:(id)anObject;
- (id)performSelector:(SEL)aSelector withObject:(id)anObject
  withObject:(id)anotherObject;

/* Describing the Object */
- (NSString*)description;

@end /* NSObject */

/* 
 * Copying Objects (deep immutable copy)
 */

@protocol NSCopying
- (id)copyWithZone:(NSZone*)zone;
@end /* NSCopying */

/* 
 * Copying Objects (shallow mutable copy)
 */

@protocol NSMutableCopying
- (id)mutableCopyWithZone:(NSZone*)zone;
@end /* NSCopying */

/* 
 * Coding/Decoding Objects through NSCoder
 */

@protocol NSCoding
- (void)encodeWithCoder:(NSCoder*)aCoder;
- (id)initWithCoder:(NSCoder*)aDecoder;
@end /* NSCoding */

/*
 * NSObject Class - base class for OpenStep Hierarchy
 */

@interface NSObject <NSObject>
{
    Class isa;
}

/* Initializing the Class */
+ (void)initialize;

/* Creating and Destroying Instances */
+ (id)alloc;
+ (id)allocWithZone:(NSZone*)zone;
+ (id)new;
- (void)dealloc;
- (id)init;

/* Testing Class Functionality */
+ (BOOL)instancesRespondToSelector:(SEL)aSelector;

/* Testing Protocol Conformance */
+ (BOOL)conformsToProtocol:(Protocol*)aProtocol;

/* Obtaining Method Information */
+ (IMP)instanceMethodForSelector:(SEL)aSelector;
- (IMP)methodForSelector:(SEL)aSelector;
+ (NSMethodSignature *)instanceMethodSignatureForSelector:(SEL)aSelector;
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector;

/* Posing */
+ (void)poseAsClass:(Class)aClass;

/* Error Handling */
- (void)doesNotRecognizeSelector:(SEL)aSelector;

/* Sending Deferred Messages */
+ (void)cancelPreviousPerformRequestsWithTarget:(id)aTarget
	selector:(SEL)aSelector
	object:(id)anObject;
- (void)performSelector:(SEL)aSelector
	withObject:(id)anObject
	afterDelay:(NSTimeInterval)delay;

/* Forwarding Messages */
- (void)forwardInvocation:(NSInvocation*)anInvocation;

/* Archiving */
- (id)awakeAfterUsingCoder:(NSCoder*)aDecoder;
- (Class)classForArchiver;
- (Class)classForCoder;
- (id)replacementObjectForArchiver:(NSArchiver*)anArchiver;
- (id)replacementObjectForCoder:(NSCoder*)anEncoder;
+ (void)setVersion:(int)version;
+ (int)version;

/* NSCopying/NSMutableCopying shortcuts */
- (id)copy;
- (id)mutableCopy;

/* Obtaining a string representation */
- (NSString*)stringRepresentation;

@end /* NSObject */

@interface NSObject (GNU)
- (Class)transmuteClassTo:(Class)aClassObject;
- subclassResponsibility:(SEL)aSel;
- shouldNotImplement:(SEL)aSel;
- notImplemented:(SEL)aSel;
@end

typedef enum _NSComparisonResult {
    NSOrderedAscending = -1,
    NSOrderedSame = 0,
    NSOrderedDescending = 1
} NSComparisonResult;

enum {NSNotFound = 0x7fffffff};


/* The following makes sense only when libFoundation is compiled to work with
   Boehm's garbage collector. */

/* An object can clean up the resources it's using right before it ends the
   life. You should implement -gcFinalize in all the classes whose instances
   can hold limited resources like file descriptors. NSObject does not
   implement this method so there is no default implementation of it.

   Other objects can observe an object's end of life by registering as
   observers of that object. See the GarbageCollector class for more
   information about this. */

@protocol GCFinalization
- (void)gcFinalize;
@end

@interface NSObject(BoehmTypedMemory)
+ (BOOL)requiresTypedMemory;
@end

/* This variable identifies how the library was compiled and how the
   program will run. You can compile the library with support for
   Boehm's garbage collector or not. If the library is compiled with
   Boehm's GC the program runs using the automatic garbage collection
   mechanis, otherwise it uses the normal retain/release mechanism. */

extern BOOL _usesBoehmGC;	/* YES if the program is running using the
				   Boehm's garbage collector */

#include <Foundation/lfmemory.h>

#endif /* __NSObject_h__ */

#include <Foundation/NSZone.h>
#include <Foundation/NSObjCRuntime.h>
#include <Foundation/NSUtilities.h>

/*
  Local Variables:
  mode: ObjC
  c-basic-offset: 4
  tab-width: 8
  End:
*/
