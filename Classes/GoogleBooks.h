//
//  GoogleBooks.h
//  Barter
//
//  Created by byeong cheol lim on 11. 1. 19..
//  Copyright 2011 ocbs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON.h"
#define searchAddress @"124.50.196.187"
@interface GoogleBooks : NSObject {

}
-(NSDictionary *)bookSearch:(NSString *)isbn;
@end
