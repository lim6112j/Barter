//
//  SummaryViewController.h
//  Barter
//
//  Created by byeong cheol lim on 11. 1. 24..
//  Copyright 2011 ocbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginModalViewController.h"
#import "SearchModalViewController.h"
#import "BarcodeViewController.h"
@interface SummaryViewController : UIViewController {
	IBOutlet UIButton *searchButton;
	IBOutlet UIButton *barcodeButton;
	UIViewController *mVC;
}
-(IBAction)loginCheck;
-(IBAction)addModalView:(id)sender;
-(void)closeModalView;
@end
