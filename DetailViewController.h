//
//  DetailViewController.h
//  Barter
//
//  Created by byeong cheol lim on 11. 1. 22..
//  Copyright 2011 ocbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"
#import "Person.h"
#import "BarterAppDelegate.h"

@interface DetailViewController : UIViewController {
	IBOutlet UIImageView *_imageView;
	IBOutlet UITextView *_descView;
	IBOutlet UITextView *_infoView;
		IBOutlet UITextView *_titleView;
	NSData *_bookImageData;
	NSString *_desc;
	NSString *_infoText;
	NSString *_titleText;
}
@property (nonatomic,retain) UIImageView *imageView;
@property (nonatomic,retain) UITextView *descView;
@property (nonatomic,retain) UITextView *infoView;
@property (nonatomic,retain) UITextView *titleView;
@property (nonatomic, retain) NSData *bookImageData;
@property (nonatomic,retain) NSString *desc;
@property (nonatomic,retain) NSString *infoText;
@property (nonatomic,retain) NSString *titleText;

-(IBAction)iHaveIt;
-(IBAction)iWantIt;
@end
