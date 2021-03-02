//
//  CertListVC.h
//  KeySharpBAgent
//
//  Created by choi sung hoon on 11. 7. 5..
//  Copyright 2011 lumensoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CertManager.h"


@interface CertListVC : UIViewController {
    int function;
    
    NSInteger selectedRow;
    
    
}

@property (nonatomic, retain) CertManager* manager;
@property (nonatomic, retain) IBOutlet UITableView* certTV;

@property (nonatomic, assign) int function;
- (id)initWithFunction:(int)aFunc;
- (void) refreshTableCells;
@end
