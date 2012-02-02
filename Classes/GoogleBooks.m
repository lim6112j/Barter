//
//  GoogleBooks.m
//  Barter
//
//  Created by byeong cheol lim on 11. 1. 19..
//  Copyright 2011 ocbs. All rights reserved.
//

#import "GoogleBooks.h"


@implementation GoogleBooks
-(NSDictionary *)bookSearch:(NSString *)isbn{
	NSLog(@"isbn = %@",isbn);
	NSInteger numberOfBooks=10;
	NSString *isbnEscape=[isbn stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]; //한글 쿼리를 위해 이줄이 필수임.
	NSLog(@"isbnEscape = %@",isbnEscape);

	NSString *urlString = [NSString stringWithFormat:@"http://%@/rs.php?isbn=%@&snum=%d",searchAddress,isbnEscape,numberOfBooks];
	NSURL *url = [NSURL URLWithString:urlString];
	//NSLog(@"########### calling url is :%@###################",url);
	NSString *jsonString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
	//NSString *trimedString=[jsonString stringByReplacingOccurrencesOfString:@"mycallback({\"ISBN:9788959191291\":{" withString:@"{"];
	//NSString *TS=[trimedString stringByReplacingOccurrencesOfString:@"});" withString:@""];
	//NSLog(@"return value of  search : %@",jsonString);
	//NSLog(@"returning jsonvalue is :%@",[jsonString JSONValue]);
	return [jsonString JSONValue];

}
- (void)dealloc {
    [super dealloc];
}

@end
