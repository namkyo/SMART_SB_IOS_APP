//
//  ResultViewController.h
//  PACECRDemo
//
//  Created by styx on 2015. 9. 8..
//  Copyright (c) 2015년 PACE System. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PACECaptureNRecog/PACECaptureNRecog.h>

@interface ResultViewController : UIViewController

@property (nonatomic, retain) PACECRControl *crControl;
@property (nonatomic, strong) NSData *faceImageData;
@property (nonatomic, strong) NSData *resultImageData;
@property (nonatomic, strong) NSDictionary *dicResultValue;

@end
