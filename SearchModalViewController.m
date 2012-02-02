//
//  SearchModalViewController.m
//  Barter
//
//  Created by byeong cheol lim on 11. 1. 19..
//  Copyright 2011 ocbs. All rights reserved.
//

#import "SearchModalViewController.h"


@implementation SearchModalViewController
@synthesize aTableView,aSearchBar,listContent,infoContent,titleContent, photoContent, savedSearchTerm, savedScopeButtonIndex, searchWasActive,progressHud;

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
	self.title=@"Search Books";
	aSearchBar.delegate=self;
    
	/*
	NSString *str=[dic objectForKey:@"thum_url"];
	NSURL *url=[NSURL URLWithString:str];
	NSData *data=[NSData dataWithContentsOfURL:url];
	imageView.image=[UIImage imageWithData:data];
//	NSString *info_string=[dic objectForKey:@"binfo_rul"];
//	NSURL *info_url=[NSURL URLWithString:info_string];
//	NSError *error;
//	str=[NSString stringWithContentsOfURL:info_url encoding:NSUTF8StringEncoding error:&error];
//	NSLog(@"info from info_url is : ###%@###",str);loadHTMLString
	[webView loadHTMLString:str baseURL:nil];
	//NSData *stringData=[NSData dataWithContentsOfURL:info_url];
	//str=[NSString stringWithContentsOfURL:info_url encoding:0x80000003 error:&error];
	//str = [[NSString alloc]
	//					initWithData:stringData encoding: 0x80000003];
	str=[dic objectForKey:@"bdesc"];
	textView.text=str;
	NSLog(@"data from info_url is : %@",str);
	*/
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
#pragma mark -
#pragma mark Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
	NSLog(@"in the numberofsections in tableview");
	NSUInteger count;
	NSLog(@"섹션의 갯수는 %d",count);
	if (count == 0) {
		count = 1;
		NSLog(@"sections has 0 section something wrong");
	}
	
	return 1;
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    // Return the number of rows in the section.
	//NSLog(@"section is : %d",section);
	
   // NSArray *sections = [fRC sections];
	//NSLog(@"sections array is : %@",sections);
    NSUInteger count = 0;
    //if ([sections count]) {
    //    id <NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
    //    count = [sectionInfo numberOfObjects];
    //}
	count=[listContent count];
	NSLog(@"row 갯수는 %d",count);
    return count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	NSLog(@"in table , %@",[self.listContent objectAtIndex:indexPath.row]);
    cell.detailTextLabel.text=[self.listContent objectAtIndex:indexPath.row];
	//NSString *str=[photoContent objectAtIndex:indexPath.row];
	//NSURL *url=[NSURL URLWithString:str];
	//NSData *data=[NSData dataWithContentsOfURL:url];
	NSData *data=[self.photoContent objectAtIndex:indexPath.row];
	if (data==(NSData *)[NSNull null]) {
			cell.imageView.image=[UIImage imageNamed:@"noimage.jpeg"];
	} else {
			cell.imageView.image=[UIImage imageWithData:data];
	}


	cell.textLabel.text=[titleContent objectAtIndex:indexPath.row];
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [aSearchBar resignFirstResponder];
	return indexPath;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	//[self dismissModalViewControllerAnimated:YES];
	dVC = [[[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil]autorelease];
	NSData *data=[self.photoContent objectAtIndex:indexPath.row];
	NSString *noImagePath = [[NSBundle mainBundle] pathForResource :@"noimage" ofType:@"jpeg"];
	NSData *noImageData=[NSData dataWithContentsOfFile:noImagePath];
	if (data==(NSData *)[NSNull null]) {
		dVC.bookImageData=noImageData;
	} else {
		dVC.bookImageData=data;
	}
	dVC.desc=[listContent objectAtIndex:indexPath.row];
	
	if ([infoContent objectAtIndex:indexPath.row]==[NSNull null]) {
		dVC.infoText=@"No Data";
	} else {
		dVC.infoText=[infoContent objectAtIndex:indexPath.row];

	}
	dVC.titleText=[titleContent objectAtIndex:indexPath.row];
	 
	[[self navigationController] pushViewController:dVC animated:YES];
	NSLog(@"push DetailView ");
}
#pragma mark -
#pragma mark search handling custom Methods
/*
-(void)startSpinner
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	CGRect frame = CGRectMake(0.0, 0.0, 30.0, 30.0);
	av = [[UIActivityIndicatorView alloc] initWithFrame:frame];
	av.activityIndicatorViewStyle=UIActivityIndicatorViewStyleGray;
	[av setCenter:CGPointMake(160.0f, 208.0f)];
	[av hidesWhenStopped];
	[self.aTableView addSubview:av];
	[av startAnimating];
	[pool release];
}
*/
- (void)handleSearchForTerm:(NSString *)searchTerm{
	NSAutoreleasePool *pool=[[NSAutoreleasePool alloc]init];
	//NSThread *spinThread=[[NSThread alloc] initWithTarget:self selector:@selector(startSpinner) object:nil];
	//[spinThread start];
	GoogleBooks *books=[[GoogleBooks alloc]init];
	/*
	const char *sString=[searchBar.text UTF8String];
	NSString *string=[NSString stringWithCString:sString encoding:NSUTF8StringEncoding];
	NSLog(@"%@ : %@",searchBar.text,string);
	NSDictionary *dic= [books bookSearch:string withName:nil];
	 */
		NSDictionary *dic= [books bookSearch:searchTerm];
	NSLog(@"returned dictionary from googlesearch class is : %@",dic);
	NSArray *str=[dic objectForKey:@"bdesc"];
	self.listContent=[NSArray arrayWithArray:str];
	str=[dic objectForKey:@"thum_url"];
	//for (int i=0; i<[str count]; i++) {
	//		NSLog(@"obj is kind of class : %@,%d",[[str objectAtIndex:i] class],i);
	//}
	//NSLog(@"obj is kind of class : %@",[[str objectAtIndex:0] class]);
	NSMutableArray *array=[[NSMutableArray alloc]initWithCapacity:[str count]];
	for (NSString *obj in str) {
		//NSLog(@"obj is kind of class : %@",[[str objectAtIndex:0] class]);
		NSURL *url=[NSURL URLWithString:obj];
		NSData *data=[NSData dataWithContentsOfURL:url];
		if (data==nil) {
			[array addObject:[NSNull null]];
		} else {
			[array addObject:data];
		}
	}
	self.photoContent=[NSArray arrayWithArray:array];
	[array release];
	str=[dic objectForKey:@"btitle"];
	self.titleContent=[NSArray arrayWithArray:str];
	self.infoContent=[NSArray arrayWithArray:[dic objectForKey:@"bisbn"]];
	[self.aTableView reloadData];
	//[av stopAnimating];
	//[spinThread release];
	[books release];
	[pool release];
}
-(void)resetSearch{}
#pragma mark -
#pragma mark UISearchBar Delegate Methods
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
	NSString *searchTerm=[searchBar text];

    // MBProgressHud
    self.progressHud = [[MBProgressHUD alloc] initWithView:self.view];
    progressHud.delegate=self;
    [self.view addSubview:self.progressHud];
    self.progressHud.labelText = @"책을 검색중입니다...";
    [self.progressHud showWhileExecuting:@selector(handleSearchForTerm:) onTarget:self withObject:searchTerm animated:YES];
    // Hud end
		[searchBar resignFirstResponder];
}
/*
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchTerm {
	if ([searchTerm length]==0) {
		[self resetSearch];
		[aTableView reloadData];
		return;
	}
	[self handleSearchForTerm:searchTerm];
}
*/
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
	aSearchBar.text=@"";
	[self resetSearch];
	[aTableView reloadData];
	[searchBar resignFirstResponder];
}
#pragma mark -
#pragma mark modal view close
-(IBAction)closeModalView{
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark memory management
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

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    NSLog(@"hud was hidden");
}
- (void)dealloc {
    [self setProgressHud:nil];
    [self setATableView:nil];
    [self setASearchBar:nil];
    [self setListContent:nil];
    [self setInfoContent:nil];
    [self setTitleContent:nil];
    [self setPhotoContent:nil];
    [self setSavedSearchTerm:nil];
    [super dealloc];
}


@end
