//
//  FirstViewController.h
//  SignKoreaFramework
//
//  Created by sdkim on 2015. 4. 25..
//  Copyright (c) 2015년 signkorea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "EasyJSWebView.h"
#import "EasyJSDataFunction.h"

@protocol BillViewControllerDelegate;

//@interface BillViewController : UIViewController <UIWebViewDelegate>
@interface BillViewController : UIViewController <WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, assign) id<BillViewControllerDelegate> delegate;

@property (nonatomic, assign) BOOL IS_MAIN_SERVER;
@property (nonatomic, retain) NSString *OPERATION, *REFERENCE, *SERIAL, *USCHEME, *PHONENUMBER;
@property (nonatomic, retain) IBOutlet EasyJSWebView *webview;

-(void) showAlertAndReturn:(NSString*)message;
-(void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;
-(void) testDealloc;
-(void) billFinished;
-(void) billCanceled: (NSString*)reason;

@end

@protocol BillViewControllerDelegate <NSObject>
- (void)billViewController:(BillViewController*)viewController result:(int)code reason:(NSString *)reason;
@end
