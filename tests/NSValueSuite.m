#import <NSValue.h>
#import <NSConcreteValue.h>
#import <NSRange.h>

/* Checks rect encode/decode functionality for NSValue.
*/

void NSValueRectEncodeDecode(CuTest *test)
// Encodes and decodes a rect from an NSValue and back.
{
    NSRange range = NSMakeRange(11, 22);
    NSValue *val = [NSValue valueWithRange:range];
    NSRange result = [val rangeValue];
    CuAssertIntEquals(test, range.location, result.location);
    CuAssertIntEquals(test, range.length, result.length);
}

void NSValueRectConcreteClass(CuTest *test)
// Attempts to get our concrete class for NSRect - implemented in NSConcreteValue.
{
    CuAssertPtrEquals(test, 
                      [NSValue concreteClassForObjCType:@encode(NSRange)],
                      [NSRangeValue class]);
}

CuSuite *NSValueSuite()
{
    CuSuite *suite = CuSuiteNew();
    SUITE_ADD_TEST(suite, NSValueRectEncodeDecode);
    SUITE_ADD_TEST(suite, NSValueRectConcreteClass);
    return suite;
}
