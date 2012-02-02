//
//  WantViewCell.m
//  Barter
//
//  Created by byeong cheol lim on 11. 1. 23..
//  Copyright 2011 ocbs. All rights reserved.
//

#import "WantViewCell.h"


@implementation WantViewCell
@synthesize isbnLabel,descLabel,titleLabel,imageView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
	[titleLabel release];
	[descLabel release];
	[isbnLabel release];
    [super dealloc];
}


@end
