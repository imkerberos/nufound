#import <Foundation/NSIndexSet.h>
#import <Foundation/NSEnumerator.h>
#import <Foundation/NSException.h>
#import <Foundation/NSDictionary.h>

#include <stdio.h>

/*
  First edited by rplacd 5/11/11.
*/

@interface NSIndexSet (Privates)
- (NSMutableArray*)indices;
- (void)setIndices:(NSMutableArray*)newIndices;
- (void)sortIndices;
//Op - is either "gt" "gte" "lt" "lte"...
//TopMost - if YES, use the last value in the list of eligible indices
// - otherwise use the first value
//returns NSNotFound when indices are empty.
- (NSUInteger)searchIndices:(NSString*)op withTarget:(NSUInteger)target returningGreatest:(BOOL)greatest_p;
@end

@implementation NSIndexSet (Privates)
- (NSMutableArray*)indices
{
    //if this was for public use, I'd retain-autorelease this.
    return indices;
}
- (void)setIndices:(NSMutableArray*)newIndices
{
    [newIndices retain];
    [indices release];
    indices = newIndices;
}
- (void)sortIndices
{
    [self setIndices:[[[indices sortedArrayUsingSelector:@selector(compare:)] mutableCopyWithZone:NULL] autorelease]];
}
- (NSUInteger)searchIndices:(NSString*)op withTarget:(NSUInteger)target returningGreatest:(BOOL)greatest_p
{
    if([indices count] < 1) {
        return NSNotFound;
    } else {
        //hooray for thinking in terms of map-reduce-filter
        //naive - we could b-search.
        NSMutableArray *accum = [NSMutableArray array];
        {
            NSEnumerator *enm = [indices objectEnumerator];
            id curr = nil;
            while(curr = [enm nextObject]) {
                BOOL keep = NO;
                if([op isEqualToString:@"lt"]) {
                    keep = [curr unsignedIntegerValue] < target;
                } else if([op isEqualToString:@"lte"]) {
                    keep = [curr unsignedIntegerValue] <= target;
                } else if([op isEqualToString:@"gt"]) {
                    keep = [curr unsignedIntegerValue] > target;
                } else if([op isEqualToString:@"gte"]) {
                    keep = [curr unsignedIntegerValue] >= target;
                } else {
                    [[NSException exceptionWithName:@"SearchIndicesInvalidOperationException"
                                             reason:op
                                           userInfo:[NSDictionary dictionary]]
                        raise];
                }
                if(keep)
                    [accum addObject:curr];
            }
        }

        if([accum count] < 1) {
            return NSNotFound;
        } else {      
            NSArray *sorted = [accum sortedArrayUsingSelector:@selector(compare:)];
            if(greatest_p) {
                return [[sorted objectAtIndex:[sorted count] - 1] unsignedIntegerValue];
            } else {
                return [[sorted objectAtIndex: 0] unsignedIntegerValue];
            }
        }
    }
}
@end

@implementation NSIndexSet

// Creating Index Sets

+ (id)indexSet
{
    return [[[NSIndexSet alloc] init] autorelease];
}

+ (id)indexSetWithIndex:(NSUInteger)index
{
    return [[[NSIndexSet alloc] initWithIndex:index] autorelease];
}

+ (id)indexSetWithIndexesInRange:(NSRange)indexRange
{
    return [[[NSIndexSet alloc] initWithIndexesInRange:indexRange] autorelease];
}

- (id)init
{
    if(self = [super init]) {
        indices = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [indices release];
    [super dealloc];
}

- (id)initWithIndex:(NSUInteger)index
{
    if(self = [self init]) {
        [indices addObject:[NSNumber numberWithUnsignedInteger:index]];
    }
    //guaranteed to be sorted.
    return self;
}

- (id)initWithIndexesInRange:(NSRange)indexRange
{
    if(self = [self init]) {
        NSUInteger offset;
        for(offset = 0;
            offset < indexRange.length;
            ++offset) {
            [indices addObject:[NSNumber numberWithUnsignedInteger:indexRange.location + offset]];
        }
    }
    //guaranteed to be sorted.
    return self;
}

- (id)initWithIndexSet:(NSIndexSet *)indexSet
{
    if(self = [super init]) {
        indices = [[indexSet indices] retain];
    }
    //indices are sorted here as well, remember!
    return self;
}

// Protocol implementation.

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:indices];
}

- (id)initWithCoder:(NSCoder *)coder
{
    if(self = [super init]) {
        indices = (NSMutableArray*)[coder decodeObject];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    NSIndexSet *ret = [[[NSIndexSet allocWithZone:zone] init] autorelease];
    [ret setIndices:indices];
    return ret;
}

/*
- (id)mutableCopyWithZone:(NSZone *)zone
{
    NSMutableIndexSet *ret = [[[NSMutableIndexSet allocWithZone:zone] init] autorelease];
    [ret setIndices:indices];
    return ret;
}
*/

// Querying Index Sets
- (BOOL)containsIndex:(NSUInteger)index
{
    return [indices containsObject:[NSNumber numberWithUnsignedInteger:index]];
}

- (BOOL)containsIndexes:(NSIndexSet *)indexSet
{
    //naive - O(n*m).
    BOOL ret = NO;

    NSMutableArray *idcs = [indexSet indices];
    NSEnumerator *enm = [idcs objectEnumerator];
    id val = nil;
    while(val = [enm nextObject]) {
        if(ret = [indices containsObject: val], !ret)
            break;
    }

    return ret;
}

//naive - very much like containsIndexes. can we abstract out?
- (BOOL)intersectsIndexesInRange:(NSRange)indexRange
{
    return [self countOfIndexesInRange:indexRange] > 0;
}

- (BOOL)containsIndexesInRange:(NSRange)indexRange
{
    if(indexRange.length < 1) {
        return NO;
    } else {
        return [self countOfIndexesInRange:indexRange] >= indexRange.length;
    }
}

- (NSUInteger)count
{
    return [indices count];
}

- (NSUInteger)countOfIndexesInRange:(NSRange)indexRange
{    
    //monkeypatch to avoid negative promotion to unsigned issues -
    //but assumes we don't have negative components../.
    if(indexRange.length == 0)
        return 0;

    NSUInteger count = 0;
    NSEnumerator *enm = [indices objectEnumerator]; 
    id val = nil;

    //below range...
    while(val = [enm nextObject]) {
        if([val unsignedIntegerValue] >= indexRange.location)
            goto resume;
    }
    //in range.
    while(val = [enm nextObject]) {
    resume:
        if(([val unsignedIntegerValue] >= indexRange.location) &&
           ([val unsignedIntegerValue] <= (indexRange.location + (indexRange.length - 1)))) {
            ++count;
        } else {
            break;
        }
    }
    return count;
}

// Comparing Index Sets
- (BOOL)isEqualToIndexSet:(NSIndexSet *)indexSet
{
    [[indexSet indices] isEqualToArray:[self indices]];
}

// Getting Indexes
- (NSUInteger)firstIndex
{
    if([indices count] > 1) {
        return [[indices objectAtIndex:0] unsignedIntegerValue];
    } else {
        return NSNotFound;
    }
}

- (NSUInteger)lastIndex
{
    if([indices count] > 1) {
        return [[indices objectAtIndex:[indices count] - 1] unsignedIntegerValue];
    } else {
        return NSNotFound;
    }
}

- (NSUInteger)indexLessThanIndex:(NSUInteger)index
{
    return [self searchIndices:@"lt" withTarget:index returningGreatest:YES];
}

- (NSUInteger)indexLessThanOrEqualToIndex:(NSUInteger)index
{
    return [self searchIndices:@"lte" withTarget:index returningGreatest:YES];
}

- (NSUInteger)indexGreaterThanIndex:(NSUInteger)index
{
    return [self searchIndices:@"gt" withTarget:index returningGreatest:NO];
}

- (NSUInteger)indexGreaterThanOrEqualToIndex:(NSUInteger)index
{
    return [self searchIndices:@"gte" withTarget:index returningGreatest:NO];
}

@end
