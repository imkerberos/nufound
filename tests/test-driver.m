#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include "CuTest.h"
#import <NSAutoreleasePool.h>
#import <NSProcessInfo.h>

// Inline all the tests you need here.
// You won't need to update the makefile, and you won't have to keep including CuTest.

#include "sanity.m"
#include "NSValueSuite.m"
#include "NSNumberSuite.m"
#include "NSErrorSuite.m"
#include "NSDictionarySuite.m"
#include "NSSetSuite.m"
#include "NSIndexSetSuite.m"

int main(int argc, char** argv)
{
    [NSProcessInfo initializeWithArguments:argv count:argc environment:environ];
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

    CuString *output = CuStringNew();
    CuSuite *suite = CuSuiteNew();

    CuSuiteAddSuite(suite, sanitySuite());
    CuSuiteAddSuite(suite, NSValueSuite());
    CuSuiteAddSuite(suite, NSNumberSuite());
    CuSuiteAddSuite(suite, NSErrorSuite());
    CuSuiteAddSuite(suite, NSDictionarySuite());
    CuSuiteAddSuite(suite, NSSetSuite());
    CuSuiteAddSuite(suite, NSIndexSetSuite());

    CuSuiteRun(suite);
    CuSuiteSummary(suite, output);
    CuSuiteDetails(suite, output);
    printf("%s\n", output->buffer);

    [pool release];
    return 0;
}
