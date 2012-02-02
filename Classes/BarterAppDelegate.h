//
//  BarterAppDelegate.h
//  Barter
//
//  Created by byeong cheol lim on 11. 1. 10..
//  Copyright 2011 ocbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>
#import "Book.h"
#import "Person.h"
#define userID @"lim"

@interface BarterAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
	IBOutlet UITabBarController *tabBarController;

    
@private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSString *)applicationDocumentsDirectory;
- (void)saveContext;
-(void)coreDataInit; 
-(void)coreDataInit2;
- (NSArray *)fetchManagedObjectsForEntity:(NSString*)entityName withPredicate:(NSPredicate*)predicate;
@end

