/* 
   NSError.m

   Copyright (C) 2003 SKYRIX Software AG, Helge Hess.
   All rights reserved.
   
   Author: Helge Hess <helge.hess@opengroupware.org>
   
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
   First edited by rplacd 4/24/11.
*/

#include <Foundation/NSError.h>
#include <common.h>
#import <Foundation/NSCoder.h>
#import <Foundation/NSZone.h>

@implementation NSError

// Creating Error Objects and lifecycle.
+ (id)errorWithDomain:(NSString*)aDomain code:(NSString*)aCode userInfo:(NSDictionary*)aDict
{
    return [[[NSError alloc] initWithDomain:aDomain code:aCode userInfo:aDict] autorelease];
}
- (id)initWithDomain:(NSString*)aDomain code:(NSString*)aCode userInfo:(NSDictionary*)aDict
{
    if(self = [super init]) {
        domain = [aDomain retain];
        code = [aCode retain];
        userInfo = [aDict retain];
    }
    return self;
}

- (void)dealloc
{
    [domain release];
    [code release];
    [userInfo release];
    [super dealloc];
}

//NSCoding implementation.
- (id)initWithCoder:(NSCoder *)coder
{
    if(self = [super init]){ //super is NSObject, after all
        domain = [[coder decodeObject] retain];
        code = [[coder decodeObject] retain];
        code = [[coder decodeObject] retain];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:code];
    [coder encodeObject:domain];
    [coder encodeObject:userInfo];
}

// NSCopying implementation.
- (id)copyWithZone:(NSZone *)zone
// Does a shallow copy - NSErrors are immutable.
{
    return [self retain];
}

// Getting Error Properties
- (NSString*)code
{
    return code;
}
- (NSString*)domain
{
    return domain;
}
- (NSDictionary*)userInfo
{
    return userInfo;
}

// Localized Properties
- (NSString*)localizedDescription
{
    NSString *desc = [userInfo objectForKey:NSLocalizedDescriptionKey];
    if(desc != nil) {
        return desc;
    } else {
        return [NSString stringWithFormat:@"%@ error - %@", domain, code];
    }
}
- (NSString*)localizedFailureReason
{
    NSString *reason = [userInfo objectForKey:NSLocalizedFailureReasonErrorKey];
    if(reason != nil) {
        return reason;
    } else {
        return nil;
    }
}
- (NSArray*)localizedRecoveryOptions
{
    return [userInfo objectForKey:NSLocalizedRecoveryOptionsErrorKey];
}
- (NSArray*)localizedRecoverySuggestion
{
    return [userInfo objectForKey:NSLocalizedRecoverySuggestionErrorKey];
}

// Miscellaneous Properties
- (id)recoveryAttempter
{
    id obj = [userInfo objectForKey:NSRecoveryAttempterErrorKey];
    if(obj != nil && 
       ([obj respondsToSelector:@selector(attemptRecoveryFromError:optionIndex:delegate:didRecoverSelector:contextInfo:)] 
        || [obj respondsToSelector:@selector(attemptRecoveryFromError:optionIndex:)])) {
        return obj;
    } else {
        return nil;
    }
}
- (NSString*)helpAnchor
{
    return [userInfo objectForKey:NSHelpAnchorErrorKey];
}

@end /* NSError */

/*
  Local Variables:
  c-basic-offset: 4
  tab-width: 8
  End:
*/
