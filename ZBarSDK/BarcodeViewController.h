//
//  EmbedReaderViewController.h
//  EmbedReader
//
//  Created by lim on 5/2/11.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"
#import "GoogleBooks.h"
#import "DetailViewController.h"
#import "MBProgressHUD.h"
@interface BarcodeViewController: UIViewController< ZBarReaderViewDelegate,MBProgressHUDDelegate>
{
    ZBarReaderView *readerView;
    UITextView *resultText;
    ZBarCameraSimulator *cameraSim;
    NSArray *str;
    NSArray	*listContent;// The master content.
	NSArray *titleContent;
	NSArray	*photoContent;
	NSArray *infoContent;
	// The content filtered as a result of a search.
    //	NSDictionary *dic;
	UIActivityIndicatorView *av;
	DetailViewController *dVC;
	IBOutlet UIImageView *imageView;
    IBOutlet UILabel *label;
    IBOutlet UIButton *button;
	// The saved state of the search UI if a memory warning removed the view.
    NSString		*savedSearchTerm;
    NSInteger		savedScopeButtonIndex;
    BOOL			searchWasActive;
    MBProgressHUD *progressHud;
}
- (void)handleSearchForTerm:(NSString *)searchTerm;
-(IBAction)openSafari:(id)sender;
@property (nonatomic, retain) MBProgressHUD *progressHud;
@property (nonatomic, retain) IBOutlet ZBarReaderView *readerView;
@property (nonatomic, retain) IBOutlet UITextView *resultText;
@property (nonatomic, retain) IBOutlet UIButton *button;
@property (nonatomic, retain) NSArray *listContent;
@property (nonatomic, retain) NSArray *titleContent;
@property (nonatomic, retain) NSArray *photoContent;
@property (nonatomic, retain) NSArray *infoContent;
@property (nonatomic, copy) NSString *savedSearchTerm;
@property (nonatomic) NSInteger savedScopeButtonIndex;
@property (nonatomic) BOOL searchWasActive;
@end
