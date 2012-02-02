//
//  DetailViewController.m
//  Barter
//
//  Created by byeong cheol lim on 11. 1. 22..
//  Copyright 2011 ocbs. All rights reserved.
//

#import "DetailViewController.h"


@implementation DetailViewController
@synthesize imageView=_imageView,descView=_descView,infoView=_infoView,titleView=_titleView,bookImageData=_bookImageData,desc=_desc,infoText=_infoText,titleText=_titleText;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.title=self.titleText;
	self.imageView.image=[UIImage imageWithData:self.bookImageData];
	self.descView.text=self.desc;
	self.infoView.text=self.infoText;
	self.titleView.text=self.titleText;
}

#pragma mark IBAction method
-(IBAction)iHaveIt{
BarterAppDelegate *appDelegate=(BarterAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *context=[appDelegate managedObjectContext];
	Book *book = [NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:context];
	[book setName:self.titleText];
	[book setIsbn:self.infoText];
	[book setImage:self.bookImageData];
	[book setMemo:self.desc];
	NSPredicate *predicate=[NSPredicate predicateWithFormat:@"%K like %@",@"id",@"lim"];
	NSArray *objectArray = [appDelegate fetchManagedObjectsForEntity :@"Person" withPredicate:predicate];
	Person *person = [objectArray objectAtIndex:0];
	[person addBooksOwnedObject:book];
	[book setPersonOwnedBy:person];
	NSError *error;
	if (![context save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error saving after delete", @"Error saving after delete.") 
														message:[NSString stringWithFormat:NSLocalizedString(@"Error was: %@, quitting.",@"Error was: %@, quitting."), [error localizedDescription]]
													   delegate:self 
											  cancelButtonTitle:NSLocalizedString(@"Aw, Nuts", @"Aw, Nuts")
											  otherButtonTitles:nil];
		[alert show];
		
		exit(-1);
	}
	//[self dismissModalViewControllerAnimated:YES]; //haveviewcontroller로 복귀한다.
	[[self navigationController] popViewControllerAnimated:YES];//이전 네비게이션으로 복귀한다.
	
}
-(IBAction)iWantIt{
	BarterAppDelegate *appDelegate=(BarterAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *context=[appDelegate managedObjectContext];
	Book *book = [NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:context];
	[book setName:self.titleText];
	[book setIsbn:self.infoText];
	[book setImage:self.bookImageData];
	NSPredicate *predicate=[NSPredicate predicateWithFormat:@"%K like %@",@"id",@"lim"];
	NSArray *objectArray = [appDelegate fetchManagedObjectsForEntity :@"Person" withPredicate:predicate];
	Person *person = [objectArray objectAtIndex:0];
	[person addBooksWantedObject:book];
	[book setPersonWantedBy:person];
	NSError *error;
	if (![context save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error saving after delete", @"Error saving after delete.") 
														message:[NSString stringWithFormat:NSLocalizedString(@"Error was: %@, quitting.",@"Error was: %@, quitting."), [error localizedDescription]]
													   delegate:self 
											  cancelButtonTitle:NSLocalizedString(@"Aw, Nuts", @"Aw, Nuts")
											  otherButtonTitles:nil];
		[alert show];
		
		exit(-1);
	}
	//[self dismissModalViewControllerAnimated:YES]; //haveviewcontroller로 복귀한다.
	[[self navigationController] popViewControllerAnimated:YES];//이전 네비게이션으로 복귀한다.
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [self setImageView:nil];
    [self setDescView:nil];
    [self setInfoView:nil];
    [self setTitleView:nil];
    [self setBookImageData:nil];
    [self setDesc:nil];
    [self setInfoText:nil];
    [self setTitleText:nil];
    [super dealloc];
}


@end
