//
//  SelfVerifyVC.h
//  KSW_Fulltest_Sample
//
//  Created by sjyang on 2014. 7. 14..
//  Copyright (c) 2014년 RaonSecure. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SELF_VERIFY 1
#define XW_VID      2
@interface SelfVerifyVC : UIViewController
- (id)initWithCertIndex:(int)idx function:(int)func;
@end
