#include <stdio.h>
#include "CuTest.h"
#import <NSAutoreleasePool.h>

// Inline all the tests you need here.
// You won't need to update the makefile, and you won't have to keep including CuTest.

#include "sanity.m"
#include "NSValueSuite.m"

int main(int argc, char** argv)
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

    CuString *output = CuStringNew();
    CuSuite *suite = CuSuiteNew();

    CuSuiteAddSuite(suite, sanitySuite());
    CuSuiteAddSuite(suite, NSValueSuite());

    CuSuiteRun(suite);
    CuSuiteSummary(suite, output);
    CuSuiteDetails(suite, output);
    printf("%s\n", output->buffer);

    [pool release];
    return 0;
}
