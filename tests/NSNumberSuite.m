#import <Foundation/NSValue.h>

/* Checks NSNumber's functions with NSInteger and NSUInteger values.
*/
void NSNumberEquality(CuTest *test)
// Tests NSNumber's -isEqualToNumber: with some obviously equal and no-so-obviously equal values.
{
    NSNumber *base = [NSNumber numberWithInteger:85];
    NSNumber *equal = [NSNumber numberWithUnsignedInteger:85];
    NSNumber *couldntbe = [NSNumber numberWithFloat:84];

    CuAssertTrue(test, [base isEqualToNumber:base]);
    CuAssertTrue(test, [base isEqualToNumber:equal]);
    CuAssertTrue(test, ![base isEqualToNumber:couldntbe]);
}

void NSNumberGeneralityComparison(CuTest *test)
// Makes sure the NSUInt..'s generality is higher than an NSInt's, thanks to C promotion rules.
{
    CuAssertTrue(test, [NSNumber numberWithInteger:10] <= [NSNumber numberWithUnsignedInteger:10]);
}

void NSNumberComparison(CuTest *test)
// Tests NSNumber's -compare: method for all values in NSComparisonResult.
{
    NSNumber *low = [NSNumber numberWithInteger:-10];
    NSNumber *med = [NSNumber numberWithUnsignedInteger:0];
    NSNumber *hi = [NSNumber numberWithInteger:10];

    CuAssertTrue(test, NSOrderedDescending != [med compare:low]);
    CuAssertTrue(test, NSOrderedSame == [med compare:med]);
    CuAssertTrue(test, NSOrderedAscending == [med compare:hi]);
}

CuSuite *NSNumberSuite()
{
    CuSuite *suite = CuSuiteNew();
    SUITE_ADD_TEST(suite, NSNumberEquality);
    SUITE_ADD_TEST(suite, NSNumberGeneralityComparison);
    SUITE_ADD_TEST(suite, NSNumberComparison);
    return suite;
}
