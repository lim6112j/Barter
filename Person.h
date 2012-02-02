//
//  Person.h
//  Barter
//
//  Created by byeong cheol lim on 11. 1. 18..
//  Copyright 2011 ocbs. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Book;

@interface Person :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSSet* booksOwned;
@property (nonatomic, retain) NSSet* booksWanted;

@end


@interface Person (CoreDataGeneratedAccessors)
- (void)addBooksOwnedObject:(Book *)value;
- (void)removeBooksOwnedObject:(Book *)value;
- (void)addBooksOwned:(NSSet *)value;
- (void)removeBooksOwned:(NSSet *)value;

- (void)addBooksWantedObject:(Book *)value;
- (void)removeBooksWantedObject:(Book *)value;
- (void)addBooksWanted:(NSSet *)value;
- (void)removeBooksWanted:(NSSet *)value;

@end

