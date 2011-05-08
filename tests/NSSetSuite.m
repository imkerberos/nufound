#import <NSSet.h>
#import <NSString.h>
#import <NSArray.h>
#import <NSDictionary.h>
#import <NSPredicate.h>

void NSSetNewByAppending(CuTest *test)
{
    NSString *obj = @"obj";
    NSSet *set = [NSSet setWithObject:@"set"];
    NSArray *arr = [NSArray arrayWithObject:@"arr"];
    
    CuAssertTrue(test, [[set setByAddingObject:obj] member:obj] == obj);
    CuAssertTrue(test, [[[set setByAddingObjectsFromSet:set] member:@"set"] isEqualToString:@"set"]);
    CuAssertTrue(test, [[[set setByAddingObjectsFromArray:arr] member:@"arr"] isEqualToString:@"arr"]);
}

void NSSetSetAndGetValueForKey(CuTest *test)
{
    NSObject *obj1 = [[[NSObject alloc] init] autorelease];
    NSObject *obj2 = [[[NSObject alloc] init] autorelease];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObject:obj1 forKey:@"key"];
    NSSet *set = [NSSet setWithObject:dict];
    
    CuAssertTrue(test, [[set valueForKey:@"key"] anyObject] == obj1);

    [set setValue:obj2 forKey:@"key"];
    CuAssertTrue(test, [[set valueForKey:@"key"] anyObject] == obj2);

}

void NSMutableSetFilterWithPredicate(CuTest *test)
{
    NSObject *obj = [[[NSObject alloc] init] autorelease];
    NSMutableSet *set = [NSMutableSet setWithObject:obj];
    //predicates aren't quite there yet.
    //[set filterUsingPredicate:[NSPredicate predicateWithFormat:@"FALSE"]];
    //CuAssertTrue(test, [set count] == 0);
}

CuSuite *NSSetSuite()
{
    CuSuite *suite = CuSuiteNew();
    SUITE_ADD_TEST(suite, NSSetNewByAppending);
    SUITE_ADD_TEST(suite, NSSetSetAndGetValueForKey);
    SUITE_ADD_TEST(suite, NSMutableSetFilterWithPredicate);
    return suite;
}
