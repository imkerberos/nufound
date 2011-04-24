#import <NSTask.h>
#import <NSArray.h>
/* Checks -terminationReason
   Fails everywhere ls isn't in /usr/bin.
*/

void NSTaskExitedJustFine(CuTest *test)
// Starts a task which should end successfully.
{
    NSTask *task = [NSTask launchedTaskWithLaunchPath:@"/usr/bin/ls" arguments:[NSArray array]];
    [task waitUntilExit];
    CuAssertIntEquals(test, NSTaskTerminationReasonExit, [task terminationReason]);
}

CuSuite *NSTaskSuite()
{
    CuSuite *suite = CuSuiteNew();
    SUITE_ADD_TEST(suite, NSTaskExitedJustFine);
    return suite;
}
