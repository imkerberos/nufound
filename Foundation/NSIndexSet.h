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

@interface NSIndexSet : NSObject <NSCoding, NSCopying/*, NSMutableCopying*/>
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

@interface NSMutableIndexSet

@end

#endif
