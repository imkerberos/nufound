#import <NSError.h>
#import <NSDictionary.h>
/* Checks NSError's methods return nil and don't, when they should, correctly.
*/

void NSErrorUInfoAccess(CuTest *test)
// Tests the -localized.. methods.
{
    NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:
                                       @"desc", NSLocalizedDescriptionKey,
                                       @"reas", NSLocalizedFailureReasonErrorKey,
                                       @"optn", NSLocalizedRecoveryOptionsErrorKey,
                                       @"sugg", NSLocalizedRecoverySuggestionErrorKey,
                                       nil];
    NSError *error = [NSError errorWithDomain:@"foo" code:@"foo" userInfo:info];
    CuAssertTrue(test, [[error localizedDescription] isEqualToString:@"desc"]);
    CuAssertTrue(test, [[error localizedFailureReason] isEqualToString:@"reas"]);
    CuAssertTrue(test, [[error localizedRecoveryOptions] isEqualToString:@"optn"]);
    CuAssertTrue(test, [[error localizedRecoverySuggestion] isEqualToString:@"sugg"]);
}

void NSErrorRecoveryAttempterConditions(CuTest *test)
// Sees if an NSError instance will nil out -recoveryAttempter when the attempter doesn't conform to NSErrorRecoveryAttempting
{
    NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:[NSObject new], 
                                       NSRecoveryAttempterErrorKey, 
                                       nil];
    NSError *error = [NSError errorWithDomain:@"foo" code:@"bar" userInfo:info];
    CuAssertTrue(test, [error recoveryAttempter] == nil);
}

CuSuite *NSErrorSuite()
{
    CuSuite *suite = CuSuiteNew();
    SUITE_ADD_TEST(suite, NSErrorUInfoAccess);
    SUITE_ADD_TEST(suite, NSErrorRecoveryAttempterConditions);
    return suite;
}
