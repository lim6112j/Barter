//
//  CoverFlowController.h
//  Barter
//
//  Created by lim byeong cheol on 11. 10. 13..
//  Copyright (c) 2011년 SK M&S. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFOpenFlowView.h"
#import "BarterAppDelegate.h"
#import "Person.h"
#import "Book.h"
#import "HaveViewController.h"
@interface CoverFlowController : UIViewController<NSFetchedResultsControllerDelegate,AFOpenFlowViewDelegate,AFOpenFlowViewDataSource>
{
    int numberOfData;
    NSFetchedResultsController *fRC;
}

@end
