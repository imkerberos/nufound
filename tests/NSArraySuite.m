#import <NSObject.h>
#import <NSArray.h>
#import <NSIndexSet.h>
#import <NSRange.h>
#import <NSException.h>
#import <NSData.h>

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

NSInteger lexSort(id str1, id str2, void* ctx)
{
    return [str1 compare: str2];
}

void NSArraySortedArrayUsingHint(CuTest *test)
//checks to see whether -sortedArrayUsingFunction:hint: replicates vanilla -sortedArrayUsingFunction: functionality.
{
    NSArray *arr = [NSArray arrayWithObjects: @"a", @"b", @"c", @"d", nil];
    NSData *data = [arr sortedArrayHint];
    CuAssertTrue(test, [[arr sortedArrayUsingFunction:&lexSort context:NULL] 
			   isEqual:[arr sortedArrayUsingFunction:&lexSort 
							 context:NULL hint:data]]);
}

CuSuite *NSArraySuite()
{
    CuSuite *suite = CuSuiteNew();
    SUITE_ADD_TEST(suite, NSArrayObjectsAtIndexes);
    SUITE_ADD_TEST(suite, NSArraySortedArrayUsingHint);
    return suite;
}
