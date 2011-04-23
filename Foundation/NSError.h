/* 
   NSError.h

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

#ifndef __NSError_H__
#define __NSError_H__

#include <Foundation/NSObject.h>
#import <Foundation/NSString.h>
#import <Foundation/NSDictionary.h>

@interface NSError : NSObject <NSCoding, NSCopying>
{
    NSString *domain;
    NSString *code;
    NSDictionary *userInfo;
}

// Creating Error Objects
+ (id)errorWithDomain:(NSString*)aDomain code:(NSString*)aCode userInfo:(NSDictionary*)aDict;
- (id)initWithDomain:(NSString*)aDomain code:(NSString*)aCode userInfo:(NSDictionary*)aDict;

// Getting Error Properties
- (NSString*)code;
- (NSString*)domain;
- (NSDictionary*)userInfo;

// Localized Properties
- (NSString*)localizedDescription;
- (NSString*)localizedFailureReason;
- (NSArray*)localizedRecoveryOptions;
- (NSArray*)localizedRecoverySuggestion;

// Miscellaneous Properties
- (id)recoveryAttempter;
- (NSString*)helpAnchor;

@end

// Predefined userInfo keys.
NSString *const NSLocalizedDescriptionKey = @"Localized description";
NSString *const NSErrorFailingURLStringKey = @"NSURL erroring URL string";
NSString *const NSFilePathErrorKey = @"Erroring path";
NSString *const NSStringEncodingErrorKey = @"String encoding";
NSString *const NSUnderlyingErrorKey = @"Underlying implementation error";
NSString *const NSURLErrorKey = @"Erroring NSURL";
NSString *const NSLocalizedFailureReasonErrorKey = @"Localized reason";
NSString *const NSLocalizedRecoverySuggestionErrorKey = @"Localized recovery suggestion";
NSString *const NSLocalizedRecoveryOptionsErrorKey = @"Localized recovery options";
NSString *const NSRecoveryAttempterErrorKey = @"Recovery attempter";
NSString *const NSHelpAnchorErrorKey = @"Localized help";
NSString *const NSURLErrorFailingURLErrorKey = @"NSURL erroring NSURL";
//this must match NSErrorFailingURLStringKey.
NSString *const NSURLErrorFailingURLStringErrorKey = @"NSURL erroring URL string";
NSString *const NSURLErrorFailingURLPeerTrustErrorKey = @"Failed SSL handshake state";

// Predefined error domains.
const NSString *NSPOSIXErrorDomain = @"POSIX/BSD";
const NSString *NSOSStatusErrorDomain = @"Classic/Carbon";
const NSString *NSMachErrorDomain = @"Mach";


#endif /* __NSError_H__ */

/*
  Local Variables:
  c-basic-offset: 4
  tab-width: 8
  End:
*/
