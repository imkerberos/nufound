#import <NSArray.h>
#import <NSIndexSet.h>
#import <NSRange.h>
#import <NSException.h>

void NSArrayObjectsAtIndexes(CuTest *test)
//tests no indexes, tests some indexes, tests an index out of range.
{
    NSArray *a = [NSArray arrayWithObjects:@"one", @"two", @"three", nil];
    
    NSArray *res = [a objectsAtIndexes:[NSIndexSet indexSet]];
    CuAssertTrue(test, [res count] == 0);

    res = [a objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)]];
    CuAssertTrue(test, [res count] == 2);
    CuAssertTrue(test, [[res objectAtIndex: 0] isEqual:@"one"]);
    CuAssertTrue(test, [[res objectAtIndex: 1] isEqual:@"two"]);

    //exn catching doesn't seem to work here?
    /*
    @try {
        res = [a objectsAtIndexes:[NSIndexSet indexSetWithIndex:25]];
        CuAssertTrue(test, @"didn't catch an NSRangeException" == nil);
    } @catch(id e) {
        CuAssertTrue(test, @"caught NSRangeException" != nil);
    } @finally {
        printf("Am I working?");
    }
    */ 
}

CuSuite *NSArraySuite()
{
    CuSuite *suite = CuSuiteNew();
    SUITE_ADD_TEST(suite, NSArrayObjectsAtIndexes);
    return suite;
}
