//
//  SearchModalViewController.h
//  Barter
//
//  Created by byeong cheol lim on 11. 1. 19..
//  Copyright 2011 ocbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoogleBooks.h"
#import "DetailViewController.h"
#import "MBProgressHUD.h"
@interface SearchModalViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate,MBProgressHUDDelegate> {
	NSArray	*listContent;// The master content.
	NSArray *titleContent;
	NSArray	*photoContent;
	NSArray *infoContent;
	// The content filtered as a result of a search.
//	NSDictionary *dic;
	UIActivityIndicatorView *av;
	DetailViewController *dVC;
	IBOutlet UITableView *aTableView;
	IBOutlet UISearchBar *aSearchBar;
	// The saved state of the search UI if a memory warning removed the view.
    NSString		*savedSearchTerm;
    NSInteger		savedScopeButtonIndex;
    BOOL			searchWasActive;
    MBProgressHUD *progressHud;
}

-(IBAction)closeModalView;
- (void)handleSearchForTerm:(NSString *)searchTerm;
-(void)resetSearch;
//-(void)startSpinner;
//@property(nonatomic,retain) NSDictionary *dic;
@property (nonatomic, retain) MBProgressHUD *progressHud;
@property (nonatomic,retain) UISearchBar *aSearchBar;
@property (nonatomic, retain) NSArray *listContent;
@property (nonatomic, retain) NSArray *titleContent;
@property (nonatomic, retain) NSArray *photoContent;
@property (nonatomic, retain) NSArray *infoContent;
@property (nonatomic, retain) UITableView *aTableView;
@property (nonatomic, copy) NSString *savedSearchTerm;
@property (nonatomic) NSInteger savedScopeButtonIndex;
@property (nonatomic) BOOL searchWasActive;
@end
