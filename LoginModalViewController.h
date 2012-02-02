//
//  LoginModalViewController.h
//  Barter
//
//  Created by byeong cheol lim on 11. 1. 24..
//  Copyright 2011 ocbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON.h"


@interface LoginModalViewController : UIViewController {
	IBOutlet UITextField *idField;
	IBOutlet UITextField *pwdField;
}
@property(nonatomic,retain) UITextField *idField;
@property(nonatomic,retain) UITextField *pwdField;
-(IBAction)sendLoginInfo;
-(IBAction)touchOutside;
@end
