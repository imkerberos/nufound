/* 
   NSTask.h

   Copyright (C) 1995, 1996, 1997 Ovidiu Predescu and Mircea Oancea.
   All rights reserved.

   Author: Ovidiu Predescu <ovidiu@net-community.com>

   Based on the code written by Aleksandr Savostyanov <sav@conextions.com>.

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

#ifndef __NSTask_h__
#define __NSTask_h__

#include <Foundation/NSObject.h>

enum {
    NSTaskTerminationReasonExit = 1,
    NSTaskTerminationReasonUncaughtSignal = 2
};
typedef NSInteger NSTaskTerminationReason;

@class NSString, NSArray, NSDictionary, NSFileHandle;

LF_EXPORT NSString *NSTaskDidTerminateNotification;

@interface NSTask : NSObject
{
  //by default indicates an "okay" - modified when an unhandled signal is encountered.
  //terminationReason is the equivalent of a dumb terminal.
    NSTaskTerminationReason terminationReason;
}

+ (NSTask *)launchedTaskWithLaunchPath:(NSString *)path
  arguments:(NSArray *)arguments;

- (void)setLaunchPath:(NSString *)path;
- (void)setArguments:(NSArray *)arguments;
- (void)setEnvironment:(NSDictionary *)dict;
- (void)setCurrentDirectoryPath:(NSString *)path;

- (void)setStandardInput:(id)input;
- (void)setStandardOutput:(id)output;
- (void)setStandardError:(id)error;

- (NSString *)launchPath;
- (NSArray *)arguments;
- (NSDictionary *)environment;
- (NSString *)currentDirectoryPath;
- (int)processIdentifier;

- (id)standardInput;
- (id)standardOutput;
- (id)standardError;

- (void)launch;
- (void)terminate;
- (void)interrupt;
- (BOOL)isRunning;
- (int)terminationStatus;
- (NSTaskTerminationReason)terminationReason;
- (void)waitUntilExit;

- (unsigned int)processId;

@end

@interface NSTask (privates)
//much safer to go through the method dispatch mechanism, especially when the initializer is as hairy as this.
- (void)_setTerminationReason:(NSTaskTerminationReason)aReason;
@end

#endif /* __NSTask_h__ */

/*
  Local Variables:
  c-basic-offset: 4
  tab-width: 8
  End:
*/
