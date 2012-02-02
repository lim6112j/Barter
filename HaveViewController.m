//
//  HaveViewController.m
//  Barter
//
//  Created by byeong cheol lim on 11. 1. 10..
//  Copyright 2011 ocbs. All rights reserved.
//

#import "HaveViewController.h"


@implementation HaveViewController
@synthesize customCell,isbnLabel,titleLabel,descLabel;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	self.title=@"Have List";
    searchButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(addModalView:)];
    barcodeButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(addModalView:)];
	self.navigationItem.leftBarButtonItem=searchButton;
    self.navigationItem.rightBarButtonItem=barcodeButton;
	UIView *containerView =
	[[[UIView alloc]
	  initWithFrame:CGRectMake(0, 0, 300, 60)]
	 autorelease];

	UILabel *headerLabel =
	[[[UILabel alloc]
	  initWithFrame:CGRectMake(80, 12, 300, 40)]
	 autorelease];
	UIImageView *imageView=[[[UIImageView	alloc]initWithFrame:CGRectMake(5,0, 67, 67)]autorelease];
	imageView.image=[UIImage imageNamed:@"havestar.png"];
	headerLabel.text = NSLocalizedString(@"Save The Earth", @"");
	headerLabel.textColor = [UIColor whiteColor];
	headerLabel.shadowColor = [UIColor blackColor];
	headerLabel.shadowOffset = CGSizeMake(0, 1);
	headerLabel.font = [UIFont boldSystemFontOfSize:22];
	headerLabel.backgroundColor = [UIColor clearColor];
	[containerView addSubview:headerLabel];
	[containerView addSubview:imageView];
	//self.tableView.tableHeaderView = containerView;
	//NSLog(@"headerlabel's retaincount is : %d",[headerLabel retainCount]);
	UIView *containerView2 =
	[[[UIView alloc]
	  initWithFrame:CGRectMake(0, 0, 300, 60)]
	 autorelease];
	
	UILabel *headerLabel2 =
	[[[UILabel alloc]
	  initWithFrame:CGRectMake(80, 12, 300, 40)]
	 autorelease];
	UIImageView *imageView2=[[[UIImageView	alloc]initWithFrame:CGRectMake(5,0, 67, 67)]autorelease];
	imageView2.image=[UIImage imageNamed:@"havestar.png"];
	headerLabel2.text = NSLocalizedString(@"Save The Earth", @"");
	headerLabel2.textColor = [UIColor whiteColor];
	headerLabel2.shadowColor = [UIColor blackColor];
	headerLabel2.shadowOffset = CGSizeMake(0, 1);
	headerLabel2.font = [UIFont boldSystemFontOfSize:22];
	headerLabel2.backgroundColor = [UIColor clearColor];
	[containerView2 addSubview:headerLabel2];
	[containerView2 addSubview:imageView2];
	//self.tableView.tableFooterView = containerView2;

	
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
	[self.tableView reloadData];
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
	//NSLog(@"in the numberofsections in tableview");
	NSUInteger count = [[fRC sections] count];
	//NSLog(@"섹션의 갯수는 %d",count);
	if (count == 0) {
		count = 1;
		NSLog(@"sections has 0 section something wrong");
	}
	
	return count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    // Return the number of rows in the section.
	//NSLog(@"section is : %d",section);
    NSArray *sections = [fRC sections];
	NSLog(@"sections array is : %@",sections);
	NSLog(@"in the tableview , fetchedresultscontroller is : %@",fRC);
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
		cell=customCell;
		self.customCell=nil;
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
	UILabel *label;
	label=(UILabel *)[cell viewWithTag:1];
	label.text=[book name];
	label=(UILabel *)[cell viewWithTag:2];
	label.text=[book isbn];
	label=(UILabel *)[cell viewWithTag:3];
	label.text=[book memo];
	UIImageView *imageView;
	imageView=(UIImageView *)[cell viewWithTag:4];
	imageView.image=[UIImage imageWithData:[book image]];
	/*
	cell.isbnLabel.text = [book isbn];
	cell.textLabel.text=[book name];
	cell.imageView.image=[UIImage imageWithData:[book image]];
	*/
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
/*
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
	NSLog(@"willdisplayCell working");
	if (indexPath.row % 2)
	{
        [cell setBackgroundColor:[UIColor clearColor]];
	}
	else [cell setBackgroundColor:[UIColor whiteColor]];
}
 */
//아래 줄을 시험해 보면 재밌는 효과가 나온다.
/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
	UIView *containerView2 =
	[[[UIView alloc]
	  initWithFrame:CGRectMake(0, 0, 300, 60)]
	 autorelease];
	
	UILabel *headerLabel =
	[[[UILabel alloc]
	  initWithFrame:CGRectMake(80, 12, 300, 40)]
	 autorelease];
	UIImageView *imageView=[[[UIImageView	alloc]initWithFrame:CGRectMake(5,0, 67, 67)]autorelease];
	imageView.image=[UIImage imageNamed:@"havestar.png"];
	headerLabel.text = NSLocalizedString(@"Save The Earth", @"");
	headerLabel.textColor = [UIColor whiteColor];
	headerLabel.shadowColor = [UIColor blackColor];
	headerLabel.shadowOffset = CGSizeMake(0, 1);
	headerLabel.font = [UIFont boldSystemFontOfSize:22];
	headerLabel.backgroundColor = [UIColor clearColor];
	
	[containerView2 addSubview:headerLabel];
	[containerView2 addSubview:imageView];
	
	return containerView2;
}
*/

#pragma mark -
#pragma mark NSFetchedResultsController delegate
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
	NSLog(@"coredata changed");
	[self.tableView reloadData];
}
#pragma mark -
#pragma mark modal view controller

-(IBAction)addModalView:(id)sender{
    [ZBarReaderView class];
    if (sender==searchButton) {
        NSLog(@"search button clicked");
        SearchModalViewController *searchModalView=[[SearchModalViewController alloc] initWithNibName:@"SearchModalViewController" bundle:nil];
        mVC=searchModalView; 
    }    if (sender==barcodeButton) {
        NSLog(@"search button clicked");
        BarcodeViewController *searchModalView=[[BarcodeViewController alloc] initWithNibName:@"BarcodeViewController" bundle:nil];
        NSLog(@"barcodeViewController : %@",[searchModalView description]);
        mVC=searchModalView; 
    }
        UINavigationController *navigationController=[[UINavigationController alloc] initWithRootViewController:mVC];
        UIBarButtonItem *buttonItem=[[UIBarButtonItem alloc] initWithTitle:@"done" style:UIBarButtonItemStyleBordered target:self action:@selector(closeModalView)];
        mVC.navigationItem.rightBarButtonItem=buttonItem;
        
        [self presentModalViewController:navigationController animated:YES];
        
        [navigationController release];
       // [searchModalView release];
	//NSLog(@"searchmodalview's retain count is : %d",[searchModalView retainCount]);

    }
 


-(void)closeModalView{
[self dismissModalViewControllerAnimated:YES];}
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
	[fRC release];
    [super dealloc];
}


@end

