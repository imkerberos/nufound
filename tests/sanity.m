#import <NSString.h>

/* Some very basic sanity tests to prove that NuFound's been built correctly.
   Currently deals with our very best buddy - NSString.
*/

void NSStringCaseIdentity(CuTest *test)
// Flips an NSString from lower- to upper- and back to lower-case.
{
    char *string = "baobab";
    NSString *str = [[NSString alloc] initWithUTF8String:string];
    CuAssertStrEquals(test, string, [[[str uppercaseString] lowercaseString] cString]);
}

CuSuite *sanitySuite()
{
    CuSuite *suite = CuSuiteNew();
    SUITE_ADD_TEST(suite, NSStringCaseIdentity);
    return suite;
}
