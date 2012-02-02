//
//  SummaryViewController.m
//  Barter
//
//  Created by byeong cheol lim on 11. 1. 24..
//  Copyright 2011 ocbs. All rights reserved.
//

#import "SummaryViewController.h"


@implementation SummaryViewController


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	//self.tableView.rowHeight=53;
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
-(IBAction)loginCheck{
	LoginModalViewController *lVC=[[LoginModalViewController alloc] initWithNibName:@"LoginModalViewController" bundle:nil];
	[self presentModalViewController:lVC animated:YES];
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
- (void)dealloc {
    [super dealloc];
}


@end

