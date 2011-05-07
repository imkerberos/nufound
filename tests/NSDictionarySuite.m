#import <NSDictionary.h>
#import <NSArray.h>
#import <NSValue.h>
void NSDictionaryKeysSortedUsingSelector(CuTest *test)
{
    NSDictionary *dictOrdered = [NSDictionary dictionaryWithObjectsAndKeys:
                                            [NSNumber numberWithInt:0], @"zero",
                                            [NSNumber numberWithInt:1], @"one",
                                                   [NSNumber numberWithInt:2], @"two", nil];
    NSDictionary *dictReverse = [NSDictionary dictionaryWithObjectsAndKeys:
                                            [NSNumber numberWithInt:2], @"two",
                                            [NSNumber numberWithInt:1], @"one",
                                                   [NSNumber numberWithInt:0], @"zero", nil];

    NSArray *doArray = [dictOrdered keysSortedByValueUsingSelector:@selector(compare:)];
    CuAssertTrue(test, [[doArray objectAtIndex:0] isEqualToString:@"zero"]);
    CuAssertTrue(test, [[doArray objectAtIndex:1] isEqualToString:@"one"]);
    CuAssertTrue(test, [[doArray objectAtIndex:2] isEqualToString:@"two"]);

    NSArray *drArray = [dictOrdered keysSortedByValueUsingSelector:@selector(compare:)];
    CuAssertTrue(test, [[drArray objectAtIndex:0] isEqualToString:@"zero"]);
    CuAssertTrue(test, [[drArray objectAtIndex:1] isEqualToString:@"one"]);
    CuAssertTrue(test, [[drArray objectAtIndex:2] isEqualToString:@"two"]);
}

void NSMutableDictSetValueForKey(CuTest *test)
//test both addition and removal with nil.
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:[NSNumber numberWithInt:3] forKey:@"key"];
    CuAssertTrue(test, [dict valueForKey:@"key"] != nil);
    [dict setValue:nil forKey:@"key"];
    CuAssertTrue(test, [dict valueForKey:@"key"] == nil);
}

CuSuite *NSDictionarySuite()
{
    CuSuite *suite = CuSuiteNew();
    SUITE_ADD_TEST(suite, NSDictionaryKeysSortedUsingSelector);
    SUITE_ADD_TEST(suite, NSMutableDictSetValueForKey);
    return suite;
}
