//
//  WantViewController.h
//  Barter
//
//  Created by byeong cheol lim on 11. 1. 10..
//  Copyright 2011 ocbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BarterAppDelegate.h"
#import "Person.h"
#import "Book.h"
#import "DetailViewController.h"
#import "WantViewCell.h"
#define kTableViewRowHeight 100.0
@interface WantViewController : UITableViewController <NSFetchedResultsControllerDelegate>{
	NSFetchedResultsController *fRC;
			DetailViewController *dVC;
	IBOutlet WantViewCell *wantCell;

}
@property(nonatomic,retain) WantViewCell *wantCell;

@end
