//
//  Book.h
//  Barter
//
//  Created by byeong cheol lim on 11. 1. 18..
//  Copyright 2011 ocbs. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Person;

@interface Book :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * isbn;
@property (nonatomic, retain) NSString * memo;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSNumber * howmany;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * state;
@property (nonatomic, retain) Person * personOwnedBy;
@property (nonatomic, retain) Person * personWantedBy;

@end




