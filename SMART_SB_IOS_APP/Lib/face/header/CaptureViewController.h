//
//  CaptureViewController.h
//  PACECRDemo
//
//  Created by styx on 2015. 7. 7..
//  Copyright (c) 2015년 PACE System. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PACECaptureNRecog/PACECaptureNRecog.h>

@protocol OcrCaptureDelegate <NSObject>
- (void)completeCapture:(NSDictionary<NSString *, id> *) result type:(int) type;
@end

@interface CaptureViewController : UIViewController

@property (nonatomic, assign) BOOL bAutoCapture;
@property (nonatomic, assign) BOOL bFlashOn;
@property (nonatomic, weak) id<OcrCaptureDelegate> delegate;

@end
 
