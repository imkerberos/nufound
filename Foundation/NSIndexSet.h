#ifndef __NSIndexSet_h__
#define __NSIndexSet_h__

/*
  First edited by rplacd 5/11/11.
*/

#import <Foundation/NSObject.h>
#import <Foundation/NSRange.h>
#import <Foundation/NSArray.h>
#import <Foundation/NSValue.h>
#import <Foundation/NSCoder.h>

@class NSMutableArray;

@interface NSIndexSet : NSObject <NSCoding, NSCopying, NSMutableCopying>
{
    //sets, unfortunately, aren't ordered - indexsets are, though.
    //so make the assumption that no index should be repeated.
    NSMutableArray *indices; //our policy - sort on alter or insert. 
    //therefore indices should always be sorted outside of mutableindexset methods.
}

// Creating Index Sets
+ (id)indexSet;
+ (id)indexSetWithIndex:(NSUInteger)index;
+ (id)indexSetWithIndexesInRange:(NSRange)indexRange;
- (id)initWithIndex:(NSUInteger)index;
- (id)initWithIndexesInRange:(NSRange)indexRange;
- (id)initWithIndexSet:(NSIndexSet *)indexSet;

// Querying Index Sets
- (BOOL)containsIndex:(NSUInteger)index;
- (BOOL)containsIndexes:(NSIndexSet *)indexSet;
- (BOOL)containsIndexesInRange:(NSRange)indexRange;
- (BOOL)intersectsIndexesInRange:(NSRange)indexRange;
- (NSUInteger)count;
- (NSUInteger)countOfIndexesInRange:(NSRange)indexRange;

// Comparing Index Sets
- (BOOL)isEqualToIndexSet:(NSIndexSet *)indexSet;

// Getting Indexes
- (NSUInteger)firstIndex;
- (NSUInteger)lastIndex;
- (NSUInteger)indexLessThanIndex:(NSUInteger)index;
- (NSUInteger)indexLessThanOrEqualToIndex:(NSUInteger)index;
- (NSUInteger)indexGreaterThanIndex:(NSUInteger)index;
- (NSUInteger)indexGreaterThanOrEqualToIndex:(NSUInteger)index;
@end

//this, while not being part of Apple's official API, is our only way to access the internals without implementing blocks.
@interface NSIndexSet (Privates)
- (NSMutableArray*)indices;
- (void)setIndices:(NSMutableArray*)newIndices;
- (void)cleanUpIndices; //sorts and removes dupes.
//Op - is either "gt" "gte" "lt" "lte"...
//TopMost - if YES, use the last value in the list of eligible indices
// - otherwise use the first value
//returns NSNotFound when indices are empty.
- (NSUInteger)searchIndices:(NSString*)op withTarget:(NSUInteger)target returningGreatest:(BOOL)greatest_p;
@end

@interface NSMutableIndexSet : NSIndexSet
// Adding Indexes
- (void)addIndex:(NSUInteger)index;
- (void)addIndexes:(NSIndexSet *)indexSet;
- (void)addIndexesInRange:(NSRange)indexRange;

// Removing Indexes
- (void)removeIndex:(NSUInteger)index;
- (void)removeIndexes:(NSIndexSet *)indexSet;
- (void)removeAllIndexes;
- (void)removeIndexesInRange:(NSRange)indexRange;

// Shifting Index Groups.
//Poorly defined. My take:
//Delta determines whether we shift the indexes to the "left" or "right" of startIndex
//as well as offset.
- (void)shiftIndexesStartingAtIndex:(NSUInteger)startIndex by:(NSInteger)delta;

@end

#endif
