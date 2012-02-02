//
//  MyTabBarController.h
//  Barter
//
//  Created by lim byeong cheol on 11. 10. 13..
//  Copyright (c) 2011년 SK M&S. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HaveViewController.h"
#import "CoverFlowController.h"
@interface MyTabBarController : UITabBarController
{
    UITabBar *myTabBar;
    
}
@property(nonatomic,retain)IBOutlet UITabBar *myTabBar;
@end
