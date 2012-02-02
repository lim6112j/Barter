//
//  EmbedReaderViewController.m
//  EmbedReader
//
//  Created by lim on 5/2/11.
//

#import "BarcodeViewController.h"

@implementation BarcodeViewController

@synthesize readerView, resultText;
@synthesize listContent,infoContent,titleContent, photoContent, savedSearchTerm, savedScopeButtonIndex, searchWasActive,progressHud,button;

- (void) cleanup
{
    [cameraSim release];
    cameraSim = nil;
    readerView.readerDelegate = nil;
    [readerView release];
    readerView = nil;
    [resultText release];
    resultText = nil;
}

- (void) dealloc
{
    [self cleanup];
    [super dealloc];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    // the delegate receives decode results
    readerView.readerDelegate = self;

    // you can use this to support the simulator
    if(TARGET_IPHONE_SIMULATOR) {
        cameraSim = [[ZBarCameraSimulator alloc]
                     initWithViewController: self];
        cameraSim.readerView = readerView;
    }
}

- (void) viewDidUnload
{
    [self cleanup];
    [super viewDidUnload];
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) orient
{
    // auto-rotation is supported
    return(YES);
}

- (void) willRotateToInterfaceOrientation: (UIInterfaceOrientation) orient
                                 duration: (NSTimeInterval) duration
{
    // compensate for view rotation so camera preview is not rotated
    [readerView willRotateToInterfaceOrientation: orient
                                        duration: duration];
}

- (void) viewDidAppear: (BOOL) animated
{
    // run the reader when the view is visible
    label.text=@"10cm 떨어져서 밝은 곳에서 촬영하세요";
    [readerView start];
}

- (void) viewWillDisappear: (BOOL) animated
{
    [readerView stop];
}

- (void) readerView: (ZBarReaderView*) view
     didReadSymbols: (ZBarSymbolSet*) syms
          fromImage: (UIImage*) img
{
    // do something useful with results

    for(ZBarSymbol *sym in syms) {
        resultText.text = sym.data;
        break;
    }
    // MBProgressHud
    self.progressHud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.progressHud setDelegate:self];
    [self.view addSubview:self.progressHud];
    self.progressHud.labelText = @"책을 검색중입니다...";
    [self.progressHud showWhileExecuting:@selector(handleSearchForTerm:) onTarget:self withObject:resultText.text animated:YES];
    // Hud end
    NSLog(@"책 검색 완료");
}
-(IBAction)openSafari:(id)sender
{
    NSString *string=resultText.text;
    NSString *webAddress=[NSString stringWithFormat:@"http://www.google.co.kr/search?q=%@",string];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:webAddress]];
}
- (void)handleSearchForTerm:(NSString *)searchTerm{
	NSAutoreleasePool *pool=[[NSAutoreleasePool alloc]init];
	//NSThread *spinThread=[[NSThread alloc] initWithTarget:self selector:@selector(startSpinner) object:nil];
	//[spinThread start];
	GoogleBooks *books=[[GoogleBooks alloc]init];
	/*
     const char *sString=[searchBar.text UTF8String];
     NSString *string=[NSString stringWithCString:sString encoding:NSUTF8StringEncoding];
     NSLog(@"%@ : %@",searchBar.text,string);
     NSDictionary *dic= [books bookSearch:string withName:nil];
	 */
    NSDictionary *dic= [books bookSearch:searchTerm];
	NSLog(@"returned dictionary from googlesearch class is : %@",dic);
    if (dic!=nil) {
        
        str=[dic objectForKey:@"bdesc"];
        self.listContent=[NSArray arrayWithArray:str];
        str=[dic objectForKey:@"thum_url"];
        NSMutableArray *array=[[NSMutableArray alloc]initWithCapacity:[str count]];
        NSURL *url=[NSURL URLWithString:[str objectAtIndex:0]];
        NSData *data=[NSData dataWithContentsOfURL:url];
        if (data==nil) {
            NSString *noImagePath = [[NSBundle mainBundle] pathForResource :@"noimage" ofType:@"jpeg"];
            NSData *noImageData=[NSData dataWithContentsOfFile:noImagePath];
            [array addObject:noImageData];
        } else
        {
            [array addObject:data];
        }
        self.photoContent=[NSArray arrayWithArray:array];
        [array release];
        if ([array count]!=0) {
            imageView.image=[UIImage imageWithData:[self.photoContent objectAtIndex:0]];
        }
        
        str=[dic objectForKey:@"btitle"];
        self.titleContent=[NSArray arrayWithArray:str];
        self.infoContent=[NSArray arrayWithArray:[dic objectForKey:@"bisbn"]];
    } else 
    {
        self.listContent=nil;
        self.photoContent=nil;
        self.titleContent=nil;
        self.infoContent=nil;
        imageView.image=nil;
        label.text=@"바코드 검색 결과가 없습니다. 책만 검색 가능";
    }
	
   // [av stopAnimating];
	//[spinThread release];
	[books release];
	[pool release];
}
- (void)hudWasHidden:(MBProgressHUD *)hud
{
    NSLog(@"hud was hidden");
    NSData *data=nil;
    if ((data=[self.photoContent objectAtIndex:0])) {
        dVC = [[[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil]autorelease];
        
        
        NSString *noImagePath = [[NSBundle mainBundle] pathForResource :@"noimage" ofType:@"jpeg"];
        NSData *noImageData=[NSData dataWithContentsOfFile:noImagePath];
        if (data==(NSData *)[NSNull null]) {
            dVC.bookImageData=noImageData;
        } else {
            dVC.bookImageData=data;
        }
        
        if ([infoContent objectAtIndex:0]==[NSNull null]) {
            dVC.infoText=resultText.text;
        } else {
            dVC.infoText=[infoContent objectAtIndex:0];
            
        }
        dVC.titleText=[titleContent objectAtIndex:0];
        
        [[self navigationController] pushViewController:dVC animated:YES];
    }
}
/*
-(void)startSpinner
{
    label.text=@"검색 완료 잠시만 기다려주세요";
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	CGRect frame = CGRectMake(0.0, 0.0, 30.0, 30.0);
	av = [[UIActivityIndicatorView alloc] initWithFrame:frame];
	av.activityIndicatorViewStyle=UIActivityIndicatorViewStyleGray;
	[av setCenter:CGPointMake(160.0f, 300.0f)];
	[av hidesWhenStopped];
	[self.view addSubview:av];
	[av startAnimating];
	[pool release];
}
 */
@end
