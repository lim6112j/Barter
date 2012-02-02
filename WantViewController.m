//
//  WantViewController.m
//  Barter
//
//  Created by byeong cheol lim on 11. 1. 10..
//  Copyright 2011 ocbs. All rights reserved.
//

#import "WantViewController.h"


@implementation WantViewController
@synthesize wantCell;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	self.title=@"Want List";
	
	UIView *containerView =
	[[[UIView alloc]
	  initWithFrame:CGRectMake(0, 0, 300, 60)]
	 autorelease];
	UILabel *headerLabel =
	[[[UILabel alloc]
	  initWithFrame:CGRectMake(80, 12, 300, 40)]
	 autorelease];
	UIImageView *imageView=[[[UIImageView	alloc]initWithFrame:CGRectMake(5,0, 67, 67)]autorelease];
	imageView.image=[UIImage imageNamed:@"text3791.png"];
	headerLabel.text = NSLocalizedString(@"Save The Money", @"");
	headerLabel.textColor = [UIColor whiteColor];
	headerLabel.shadowColor = [UIColor blackColor];
	headerLabel.shadowOffset = CGSizeMake(0, 1);
	headerLabel.font = [UIFont boldSystemFontOfSize:22];
	headerLabel.backgroundColor = [UIColor clearColor];
	[containerView addSubview:headerLabel];
	[containerView addSubview:imageView];
	//self.tableView.tableHeaderView = containerView;
	
	BarterAppDelegate *appDelegate=(BarterAppDelegate *)[[UIApplication sharedApplication] delegate];
	[NSFetchedResultsController deleteCacheWithName:@"Root"];
	NSFetchRequest *req=[[NSFetchRequest alloc] init];
	NSLog(@"context in teh haveviewcontroller is %@",appDelegate.managedObjectContext);
	NSEntityDescription *entity=[NSEntityDescription entityForName:@"Book" inManagedObjectContext:appDelegate.managedObjectContext];
	[req setEntity:entity];
	NSPredicate *predicate=[NSPredicate predicateWithFormat:@"%K != %@",@"personWantedBy",NULL];
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
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



/*
 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
 }
 */
/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */
/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
	NSLog(@"in the numberofsections in tableview");
	NSUInteger count = [[fRC sections] count];
	NSLog(@"섹션의 갯수는 %d",count);
	if (count == 0) {
		count = 1;
		NSLog(@"sections has 0 section something wrong");
	}
	
	return count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    // Return the number of rows in the section.
	NSLog(@"section is : %d",section);
    NSArray *sections = [fRC sections];
	NSLog(@"sections array is : %@",sections);
    NSUInteger count = 0;
    if ([sections count]) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
        count = [sectionInfo numberOfObjects];
    }
	NSLog(@"row 갯수는 %d",count);
    return count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *MyIdentifier = @"MyIdentifier";
    
    WantViewCell *cell = (WantViewCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
		NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"WantViewCell" owner:self options:nil];
		for (id oneObject in nib) 
			if ([oneObject isKindOfClass:[WantViewCell class]]) 
				cell=(WantViewCell *)oneObject;
	}
	// design the cell
	cell.backgroundView =
	[[[UIImageView alloc] init] autorelease];
	UIImage *rowBackground;
	//UIImage *selectionBackground;
	//NSInteger sectionRows = [tableView numberOfRowsInSection:[indexPath section]];
	NSInteger row = [indexPath row];
	/*
	if (row == 0 && row == sectionRows - 1)
	{
		rowBackground = [UIImage imageNamed:@"backgound.png"];
		//selectionBackground = [UIImage imageNamed:@"topAndBottomRowSelected.png"];
	}
	 */
    if (row%2==0)
	{
		rowBackground = [UIImage imageNamed:@"tableCellBG_grey_small.png"];
		//selectionBackground = [UIImage imageNamed:@"middleRowSelected.png"];
	} else if (row%2==1)
    {
        rowBackground = [UIImage imageNamed:@"tableCellBG_greyLight_small.png"];
    }
	((UIImageView *)cell.backgroundView).image = rowBackground;
	//((UIImageView *)cell.selectedBackgroundView).image = selectionBackground;
	
	
    // Configure the cell...
	Book *book = [fRC objectAtIndexPath:indexPath];
	
	cell.isbnLabel.text = [book isbn];
	cell.titleLabel.text=[book name];
	cell.descLabel.text=[book memo];
	cell.imageView.image=[UIImage imageWithData:[book image]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return kTableViewRowHeight;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source.
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark -
#pragma mark Table view delegate


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	//[self dismissModalViewControllerAnimated:YES];
	dVC = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
	Book *book = [fRC objectAtIndexPath:indexPath];
	NSData *data=[book image];
	NSString *noImagePath = [[NSBundle mainBundle] pathForResource :@"noimage" ofType:@"jpeg"];
	NSData *noImageData=[NSData dataWithContentsOfFile:noImagePath];
	if (data==(NSData *)[NSNull null]) {
		dVC.bookImageData=noImageData;
	} else {
		dVC.bookImageData=data;
	}
	dVC.desc=[book memo];
	
	if ([book isbn]==nil) {
		dVC.infoText=@"No Data";
	} else {
		dVC.infoText=[book isbn];
		
	}
	dVC.titleText=[book name];
	
	[[self navigationController] pushViewController:dVC animated:YES];
	NSLog(@"push DetailView ");
}

#pragma mark -
#pragma mark NSFetchedResultsController delegate
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
	NSLog(@"coredata changed");
	[self.tableView reloadData];
}
#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

