//
//  HaveViewController.h
//  Barter
//
//  Created by byeong cheol lim on 11. 1. 10..
//  Copyright 2011 ocbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BarterAppDelegate.h"
#import "Person.h"
#import "Book.h"
#import "SearchModalViewController.h"
#import "DetailViewController.h"
#import "BarcodeViewController.h"
#define kTableViewRowHeight 100.0


@interface HaveViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
	NSFetchedResultsController *fRC;
	IBOutlet UIBarButtonItem *searchButton;
    IBOutlet UIBarButtonItem *barcodeButton;
	UIViewController *mVC;
    BarcodeViewController *eRV;
		DetailViewController *dVC;
	IBOutlet UITableViewCell *customCell;
	IBOutlet UILabel *isbnLabel;
		IBOutlet UILabel *titleLabel;
		IBOutlet UILabel *descLabel;
}
@property (nonatomic,retain) UITableViewCell *customCell;
@property (nonatomic,retain) UILabel *isbnLabel;
@property (nonatomic,retain) UILabel *titleLabel;
@property (nonatomic,retain) UILabel *descLabel;
-(IBAction)addModalView:(id)sender;
-(void)closeModalView;
@end
