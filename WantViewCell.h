//
//  WantViewCell.h
//  Barter
//
//  Created by byeong cheol lim on 11. 1. 23..
//  Copyright 2011 ocbs. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WantViewCell : UITableViewCell {
	IBOutlet UILabel *titleLabel,*descLabel,*isbnLabel;
	IBOutlet UIImageView *imageView;
}
@property (nonatomic,retain) UILabel *titleLabel;
@property (nonatomic,retain) UILabel *descLabel;
@property (nonatomic,retain) UILabel *isbnLabel;
@property (nonatomic,retain) UIImageView *imageView;
@end
