//
//  LoginModalViewController.m
//  Barter
//
//  Created by byeong cheol lim on 11. 1. 24..
//  Copyright 2011 ocbs. All rights reserved.
//

#import "LoginModalViewController.h"


@implementation LoginModalViewController
@synthesize idField,pwdField;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/
-(IBAction)sendLoginInfo{
	NSString *identity=idField.text;
	NSString *pwd=pwdField.text;
	NSString *post=[NSString stringWithFormat:@"email=%@&passwd=%@",identity,pwd];
	NSData *postData=[post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
	
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	[request setURL:[NSURL URLWithString:@"http://172.16.101.98/member/loginCheck.php"]];
	[request setHTTPMethod:@"POST"];
	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	[request setHTTPBody:postData];
	
	NSError *error;
	NSURLResponse *response;
	NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
	NSLog(@"data received :%@",data);
	NSDictionary *dic=[data JSONValue];

	NSString *string=[dic objectForKey:@"login_auth"];
	//NSLog(@"dic login_auth is %@",[dic objectForKey:@"login_auth"]);
	//NSLog(@"string is %@",string);
	if ([string isEqualToString:@"success"]) {
		NSLog(@"login accepted!");
		[self dismissModalViewControllerAnimated:YES];
	} else {
		//아이디, 비번 틀린 경우에 따라 조건문을 더 분기할수 있다. 로그참조.
		NSLog(@"retry");
	}

	//NSLog(data);
}
-(IBAction)touchOutside{
	[self.idField resignFirstResponder];
		[self.pwdField resignFirstResponder];
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
