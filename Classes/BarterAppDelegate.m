//
//  BarterAppDelegate.m
//  Barter
//
//  Created by byeong cheol lim on 11. 1. 10..
//  Copyright 2011 ocbs. All rights reserved.
//

#import "BarterAppDelegate.h"


@implementation BarterAppDelegate

@synthesize window;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
	managedObjectModel_=[self managedObjectModel];
	managedObjectContext_=[self managedObjectContext];
	persistentStoreCoordinator_=[self persistentStoreCoordinator];
	[self coreDataInit2];
	[self.window addSubview:tabBarController.view];
    [self.window makeKeyAndVisible];
    
    return YES;
}
-(void)coreDataInit2{ 
	NSMutableArray *array=(NSMutableArray *)[self fetchManagedObjectsForEntity:@"Person" withPredicate:nil];
	int num=[array count];
	if (num>0) {
        NSLog(@"core date is not nil");
		}
		else {
			NSLog(@"array is nil");
			Person *person = [NSEntityDescription insertNewObjectForEntityForName :@"Person" inManagedObjectContext:managedObjectContext_];
			[person setId:userID];
			NSError *error;
			if (![managedObjectContext_ save:&error]) {
				NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error saving after delete", @"Error saving after delete.") 
																message:[NSString stringWithFormat:NSLocalizedString(@"Error was: %@, quitting.",@"Error was: %@, quitting."), [error localizedDescription]]
															   delegate:self 
													  cancelButtonTitle:NSLocalizedString(@"Aw, Nuts", @"Aw, Nuts")
													  otherButtonTitles:nil];
				[alert show];
				
				exit(-1);
		}

	}

		
	
	}
-(void)coreDataInit{
	//Get path to copy the Bundle to the Documents directory...
	NSString *rootPath = [self applicationDocumentsDirectory];
	NSString *plistPath = [rootPath stringByAppendingPathComponent:@"Fake.plist"];
	
	//Pull the data from the Bundle object in the Resources directory...
	NSFileManager *defaultFile = [NSFileManager defaultManager];
	BOOL isInstalled = [defaultFile fileExistsAtPath :plistPath];
	
	NSArray *plistData = [NSArray arrayWithContentsOfFile :plistPath];
	
	if(isInstalled == NO)
	{		
		//		NSLog(@"Initial installation: retrieve and copy FakeData.plist from Main Bundle");
		
		NSString *bundlePath = [[NSBundle mainBundle] pathForResource :@"Fake" ofType:@"plist"];
		plistData = [NSArray arrayWithContentsOfFile :bundlePath];
		
		if(plistData)
		{
			[plistData writeToFile :plistPath atomically:YES];
			//OR... [defaultFile copyItemAtPath:bundlePath toPath:plistPath error:&errorDesc];
		}		

	
	//Process plistData to store in Photo and Person objects...
	NSEnumerator *enumr = [plistData objectEnumerator];
	id curr = [enumr nextObject];
	NSMutableArray *names = [[NSMutableArray alloc] init];
	
	while (curr != nil)
	{
		Book *book = [NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:managedObjectContext_];
		[book setName:[curr objectForKey:@"bookName"]];
		[book setIsbn:[curr objectForKey:@"isbn"]];
		[book setImage:[curr objectForKey:@"image"]];
		[book setState:[curr objectForKey:@"state"]];
		
		//See if the name has already been set for a Person object...
		NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%@ IN %@", [curr objectForKey:@"userName"], names];
		BOOL doesExist = [predicate evaluateWithObject :curr];
		
		if (doesExist == NO)
		{				
			Person *person = [NSEntityDescription insertNewObjectForEntityForName :@"Person" inManagedObjectContext:managedObjectContext_];
			[person setId:[curr objectForKey:@"userName"]];

			if ([[curr objectForKey:@"ownOrWant"] intValue]==0) {
				[person addBooksOwnedObject:book];
				[book setPersonOwnedBy:person];
			} else if ([[curr objectForKey:@"ownOrWant"] intValue]==1) {
				[person addBooksWantedObject:book];
				[book setPersonWantedBy:person];
			}


			[names addObject :[curr objectForKey :@"userName"]];
		}
		else 
		{
			NSArray *objectArray = [self fetchManagedObjectsForEntity :@"Person" withPredicate:predicate];
			Person *person = [objectArray objectAtIndex:0];
			//[photo setPersonOwnedBy:person];
			NSLog(@"ownorwant is %@",[curr objectForKey:@"ownOrWant"]);
			if ([[curr objectForKey:@"ownOrWant"] intValue]==0) {
				[person addBooksOwnedObject:book];
				[book setPersonOwnedBy:person];
			} else if ([[curr objectForKey:@"ownOrWant"] intValue]==1) {
				[person addBooksWantedObject:book];
				[book setPersonWantedBy:person];
			}
			//[objectArray release]; 이넘 땜에 첫 기동시 어플이 다운되는 현상이 있었음.
		}
		curr = [enumr nextObject];
	}
	[names release];
		NSLog(@"context in teh barterappdelegate is %@",managedObjectContext_);
		
	NSError *error;
	if (![managedObjectContext_ save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error saving after delete", @"Error saving after delete.") 
														message:[NSString stringWithFormat:NSLocalizedString(@"Error was: %@, quitting.",@"Error was: %@, quitting."), [error localizedDescription]]
													   delegate:self 
											  cancelButtonTitle:NSLocalizedString(@"Aw, Nuts", @"Aw, Nuts")
											  otherButtonTitles:nil];
		[alert show];
		
		exit(-1);
	}
	}
	/*
	 context=[flicker managedObjectContext];
	 NSArray *objects= [flicker fetchManagedObjectsForEntity:@"Dic" withPredicate:nil];
	 if (objects==nil) {
	 NSLog(@"there is error in coredata");
	 }
	 if ([objects count]>0) {
	 //NSLog(@"objects count :[%d]",[objects count]);
	 //	MODic=[objects objectAtIndex:0];
	 } else {
	 //NSLog(@"objects count :[%d]",[objects count]);
	 #pragma mark -
	 #pragma mark plist file parsing.
	 NSBundle *bundle = [NSBundle mainBundle];
	 NSString *plistPath = [bundle pathForResource:@"FakeData" ofType:@"plist"];
	 NSArray *array = [NSArray  arrayWithContentsOfFile:plistPath];
	 NSEnumerator *obj=[array objectEnumerator];
	 id curEnum=[obj nextObject];
	 NSMutableArray *names = [[NSMutableArray alloc] init];
	 while (curEnum != nil) {
	 Photo *photoMO=[NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:context];
	 photoMO.photoName=[curEnum objectForKey:@"name"];
	 photoMO.path=[curEnum objectForKey:@"path"];
	 NSPredicate *predicate=[NSPredicate predicateWithFormat:@"%@ IN %@",[curEnum objectForKey:@"user"],names];
	 BOOL exists=[predicate evaluateWithObject:curEnum];
	 if (exists == NO)
	 {				
	 Person *personMO = [NSEntityDescription insertNewObjectForEntityForName :@"Person" inManagedObjectContext:context];
	 
	 [personMO setUserName:[curEnum objectForKey:@"user"]];
	 [personMO addPhotosObject:photoMO];
	 [photoMO setPersonOwnedBy:personMO];
	 NSLog(@"Person OBJECT: %@", personMO);
	 [names addObject :[curEnum objectForKey :@"user"]];
	 }
	 else 
	 {
	 NSArray *objectArray = [flicker fetchManagedObjectsForEntity :@"Person" withPredicate:predicate];
	 Person *personMO = [objectArray objectAtIndex:0];
	 [photoMO setPersonOwnedBy:personMO];
	 [objectArray release];
	 }
	 curEnum = [obj nextObject];
	 }
	 [names release];
	 
	 
	 
	 
	 } 
	 예전 버전
	 NSError *error;
	 for (int i=0; i<[array count]; i++) {
	 NSManagedObject *MODic;
	 MODic=[NSEntityDescription insertNewObjectForEntityForName:@"Dic" inManagedObjectContext:context];
	 
	 NSDictionary *dic=[[NSDictionary alloc] initWithDictionary:[array objectAtIndex:i]];
	 //[MOReal setValue:MODic forKey:@"dic"];
	 [MODic setValue:[dic objectForKey:@"path"] forKey:@"path"];
	 [MODic setValue:[dic objectForKey:@"name"] forKey:@"name"];
	 [MODic setValue:[dic objectForKey:@"user"] forKey:@"user"];
	 [context save:&error];
	 NSLog(@"[%d] Data from Fakedata.plist transfered to Coredata and sqlite.",[array count]);
	 NSLog(@"%@ is inserted in path key",[MODic valueForKey:@"path"]);
	 NSLog(@"%@ is inserted in user key",[MODic valueForKey:@"user"]);
	 NSLog(@"%@ is inserted in name key",[MODic valueForKey:@"name"]);
	 [dic release];
	 }
	 */
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
    [self saveContext];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of the transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveContext];
}


- (void)saveContext {
    
    NSError *error = nil;
	NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}    


#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext {
    
    if (managedObjectContext_ != nil) {
        return managedObjectContext_;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext_ = [[NSManagedObjectContext alloc] init];
        [managedObjectContext_ setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext_;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel {
    
    if (managedObjectModel_ != nil) {
        return managedObjectModel_;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Barter" withExtension:@"momd"];
    managedObjectModel_ = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return managedObjectModel_;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (persistentStoreCoordinator_ != nil) {
        return persistentStoreCoordinator_;
    }
    
    NSString *stringPath = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:@"Barter.sqlite"];
    NSURL *storeURL=[NSURL fileURLWithPath:stringPath];
    NSError *error = nil;
    persistentStoreCoordinator_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return persistentStoreCoordinator_;
}

- (NSArray *)fetchManagedObjectsForEntity:(NSString*)entityName withPredicate:(NSPredicate*)predicate
{
	
	NSManagedObjectContext	*context = [self managedObjectContext];
	NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
	
	NSFetchRequest	*request = [[NSFetchRequest alloc] init];
	request.entity = entity;
	request.predicate = predicate;
	NSSortDescriptor *sortDiscriptor;
	if (entityName==@"Annotation") {
		NSLog(@"Annotation data calling , sorted by 'idx'");
		sortDiscriptor =[[NSSortDescriptor alloc] initWithKey:@"idx" ascending:NO];
		NSArray *sortDiscriptors=[NSArray arrayWithObjects:sortDiscriptor,nil];
		[request setSortDescriptors:sortDiscriptors];
	}
	NSArray	*results = [context executeFetchRequest:request error:nil];
	[request release];
	
	return results;
	
}
#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}
#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    
    [managedObjectContext_ release];
    [managedObjectModel_ release];
    [persistentStoreCoordinator_ release];
    [tabBarController release];
    [window release];
    [super dealloc];
}


@end

