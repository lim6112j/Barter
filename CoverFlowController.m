//
//  CoverFlowController.m
//  Barter
//
//  Created by lim byeong cheol on 11. 10. 13..
//  Copyright (c) 2011년 SK M&S. All rights reserved.
//

#import "CoverFlowController.h"

@implementation CoverFlowController

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self.view setTag:10];
    BarterAppDelegate *appDelegate=(BarterAppDelegate *)[[UIApplication sharedApplication] delegate];
	[NSFetchedResultsController deleteCacheWithName:@"Root"];
	NSFetchRequest *req=[[NSFetchRequest alloc] init];
	NSLog(@"context in teh haveviewcontroller is %@",appDelegate.managedObjectContext);
	NSEntityDescription *entity=[NSEntityDescription entityForName:@"Book" inManagedObjectContext:appDelegate.managedObjectContext];
	[req setEntity:entity];
	NSPredicate *predicate=[NSPredicate predicateWithFormat:@"%K != %@",@"personOwnedBy",NULL];
	[req setPredicate:predicate];
	NSSortDescriptor *descriptor=[[NSSortDescriptor alloc]initWithKey:@"isbn" ascending:YES];
	NSArray *sortDescriptors=[[NSArray alloc] initWithObjects:descriptor,nil];
	req.sortDescriptors=sortDescriptors;
	fRC=[[NSFetchedResultsController alloc] initWithFetchRequest:req managedObjectContext:appDelegate.managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
	fRC.delegate=self;
	NSLog(@"fetchedresultscontroller is %@",fRC);
	NSError *error;
	if (![fRC performFetch:&error]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error loading data", @"Error loading data") 
														message:[NSString stringWithFormat:@"Error was: %@, quitting.", [error localizedDescription]]
													   delegate:self 
											  cancelButtonTitle:NSLocalizedString(@"Aw, Nuts", @"Aw, Nuts")
											  otherButtonTitles:nil];
		[alert show];
		
	}
	[descriptor release];
	[sortDescriptors release];
	[req release];
    
    
    NSArray *sections = [fRC sections];
    if ([sections count]) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:0];
        numberOfData = [sectionInfo numberOfObjects];
       
    }
     NSLog(@"numberOfData is %d",numberOfData);
    for (int i=0; i<numberOfData; i++) {
        Book *book = [fRC objectAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (book==nil) {
            NSLog(@"book is nil");
        }
        [(AFOpenFlowView *)self.view setImage:[UIImage imageWithData:[book image]] forIndex:i];
    }
    [(AFOpenFlowView *)self.view setNumberOfImages:numberOfData];
}

- (void)openFlowView:(AFOpenFlowView *)openFlowView requestImageForIndex:(int)index
{
    NSLog(@"protocol needs this method");
}
- (UIImage *)defaultImage
{
    NSLog(@"protocol needs this method");
    return [UIImage imageNamed:@"tab.png"]; //의미 없는 리턴.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}
-(void)dealloc
{
    [fRC release];
    [super dealloc];
}
@end
