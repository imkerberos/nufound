#import <NSIndexSet.h>
#import <NSRange.h>

void NSIndexSetSupersetTests(CuTest *test)
//Index superset and range superset tests
{
    NSIndexSet *is = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(5, 5)];
    CuAssertTrue(test, [is containsIndex:7]);
    CuAssertTrue(test, ![is containsIndex:11]);
    CuAssertTrue(test, [is containsIndexes:[NSIndexSet indexSetWithIndex:7]]);
    CuAssertTrue(test, ![is containsIndexes:[NSIndexSet indexSetWithIndex:11]]);
    CuAssertTrue(test, ![is containsIndexesInRange:NSMakeRange(7, 0)]);
    CuAssertTrue(test, [is containsIndexesInRange:NSMakeRange(5, 5)]);
    CuAssertTrue(test, ![is containsIndexesInRange:NSMakeRange(11, 1)]);
    CuAssertTrue(test, ![is containsIndexesInRange:NSMakeRange(7, 10)]);

    CuAssertTrue(test, 5 == [is count]);
    CuAssertTrue(test, 5 == [is countOfIndexesInRange:NSMakeRange(5, 5)]);
    printf("now\n"); CuAssertTrue(test, 0 == [is countOfIndexesInRange:NSMakeRange(0, 0)]);
    CuAssertTrue(test, 0 == [is countOfIndexesInRange:NSMakeRange(20, 2)]);
    CuAssertTrue(test, 1 == [is countOfIndexesInRange:NSMakeRange(3, 3)]);
}

void NSIndexSetRangeIntersection(CuTest *test)
//Range intersection.
{
    NSIndexSet *is = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(5, 5)];
    CuAssertTrue(test, [is intersectsIndexesInRange:NSMakeRange(5, 5)]);
    CuAssertTrue(test, [is intersectsIndexesInRange:NSMakeRange(5, 10)]);
    CuAssertTrue(test, ![is intersectsIndexesInRange:NSMakeRange(5, 0)]);
    CuAssertTrue(test, ![is intersectsIndexesInRange:NSMakeRange(11, 2)]);
}

void NSIndexSetGettingIndexes(CuTest *test)
//quick whirlwind test of all the Getting Indexes operations
{
    NSIndexSet *is = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(5, 5)];
    NSIndexSet *es = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(5, 0)];
    CuAssertTrue(test, 5 == [is firstIndex]);
    CuAssertTrue(test, NSNotFound == [es firstIndex]);
    CuAssertTrue(test, 9 == [is lastIndex]);
    CuAssertTrue(test, NSNotFound == [es lastIndex]);

    CuAssertTrue(test, 9 == [is indexLessThanIndex:11]);
    CuAssertTrue(test, 5 == [is indexLessThanIndex:6]);
    CuAssertTrue(test, NSNotFound == [is indexLessThanIndex: 4]);
    CuAssertTrue(test, NSNotFound == [es indexLessThanIndex: 5]);

    CuAssertTrue(test, 9 == [is indexLessThanOrEqualToIndex: 9]);
    CuAssertTrue(test, 5 == [is indexLessThanOrEqualToIndex: 5]);
    CuAssertTrue(test, NSNotFound == [es indexLessThanOrEqualToIndex: 5]);

    CuAssertTrue(test, 5 == [is indexGreaterThanIndex:4]);
    CuAssertTrue(test, 9 == [is indexGreaterThanIndex:8]);
    CuAssertTrue(test, NSNotFound == [is indexGreaterThanIndex: 11]);
    CuAssertTrue(test, NSNotFound == [es indexGreaterThanIndex: 5]);

    CuAssertTrue(test, 5 == [is indexGreaterThanOrEqualToIndex: 4]);
    CuAssertTrue(test, 9 == [is indexGreaterThanOrEqualToIndex: 9]);
    CuAssertTrue(test, NSNotFound == [es indexGreaterThanOrEqualToIndex: 5]);
}

void NSIndexSetEquality(CuTest *test)
//tests in-order equality, out-of-order equality, and inequality.
{
    NSIndexSet *a = [NSIndexSet indexSetWithIndex: 3];
    NSIndexSet *equal = [[NSIndexSet alloc] initWithIndexSet:a];
    NSIndexSet *morethanequal = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(3, 2)];
    NSIndexSet *notequal = [NSIndexSet indexSetWithIndex: 5];

    CuAssertTrue(test, [a isEqualToIndexSet:equal]);
    CuAssertTrue(test, ![a isEqualToIndexSet:morethanequal]);
    CuAssertTrue(test, ![a isEqualToIndexSet:notequal]);
}

void NSMutableIndexSetAdd(CuTest *test)
{
    NSMutableIndexSet *a = [NSMutableIndexSet indexSet];
    [a addIndex:1];
    CuAssertTrue(test, [a containsIndex:1]);

    NSMutableIndexSet *b = [NSMutableIndexSet indexSetWithIndex:2];
    [a addIndexes:b];
    CuAssertTrue(test, [a containsIndex:2]);
    
    [a addIndexesInRange:NSMakeRange(3, 2)];
    CuAssertTrue(test, [a containsIndex:3]);
    CuAssertTrue(test, [a containsIndex:4]);
}

void NSMutableIndexSetRemove(CuTest *test)
{
    NSMutableIndexSet *a = [NSMutableIndexSet indexSetWithIndexesInRange:NSMakeRange(1, 5)];
    [a removeIndex:5];
    CuAssertTrue(test, ![a containsIndex:5]);

    NSMutableIndexSet *b = [NSMutableIndexSet indexSetWithIndex:4];
    [a removeIndexes:b];
    CuAssertTrue(test, ![a containsIndex:4]);

    [a removeIndexesInRange:NSMakeRange(2, 2)];
    CuAssertTrue(test, ![a containsIndex:3]); 
    CuAssertTrue(test, ![a containsIndex:2]); 

    [a removeAllIndexes];
    CuAssertTrue(test, ![a containsIndex:1]);
}

void NSMutableIndexSetShift(CuTest *test)
{
    //normal shifting in both directions...
    NSMutableIndexSet *a = [NSMutableIndexSet indexSetWithIndexesInRange:NSMakeRange(5, 3)];
    //sort me - we go past 0. delta also determines whether we shift the indexes to the "left" or "right" side as well.
    //this means we don't have overwriting issues - we shift any potential overrightees.
    [a shiftIndexesStartingAtIndex:5 by:-1];
    CuAssertTrue(test, ![a containsIndex:5]);
    CuAssertTrue(test, [a containsIndex:4]);
    [a shiftIndexesStartingAtIndex:6 by:1];
    CuAssertTrue(test, ![a containsIndex:6]);
    CuAssertTrue(test, [a containsIndex:7]);
    CuAssertTrue(test, [a containsIndex:8]);

}

CuSuite *NSIndexSetSuite()
{
    CuSuite *suite = CuSuiteNew();
    SUITE_ADD_TEST(suite, NSIndexSetSupersetTests);
    SUITE_ADD_TEST(suite, NSIndexSetRangeIntersection);
    SUITE_ADD_TEST(suite, NSIndexSetGettingIndexes);
    SUITE_ADD_TEST(suite, NSIndexSetEquality);
    SUITE_ADD_TEST(suite, NSMutableIndexSetAdd);
    SUITE_ADD_TEST(suite, NSMutableIndexSetRemove);
    SUITE_ADD_TEST(suite, NSMutableIndexSetShift);
    return suite;
}
