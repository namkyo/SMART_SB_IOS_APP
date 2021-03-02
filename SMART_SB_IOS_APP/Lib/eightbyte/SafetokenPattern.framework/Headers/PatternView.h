//
//  PatternView.h
//  PatternLock
//
//  Created by Jubin Jacob on 15/09/15.
//  Copyright (c) 2015 J. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PatternDelegate <NSObject>

-(void)enteredPattern:(NSArray *)pattern;
-(void)completedAnimations;
-(void)startedDrawing;

@end

@interface PatternView : UIView
// Added by mskim
@property (assign) BOOL stealthMode;
@property (assign) CGFloat outerCircleWidth;
@property (assign) CGFloat outerCircleRatio;
@property (assign) CGFloat pathWidth;
@property (nonatomic,strong,setter=setPathColor:) UIColor *pathColor;
@property (nonatomic,strong,setter=setPathInvalidColor:) UIColor *pathInvalidColor;
@property (nonatomic,strong,setter=setOuterCircleColor:) UIColor *outerCircleColor;
@property (nonatomic,strong,setter=setNormalNodeColor:) UIColor *normalNodeColor;
@property (nonatomic,strong,setter=setSelectedNodeColor:) UIColor *selectedNodeColor;
@property (nonatomic,strong,setter=setInvalidNodeColor:) UIColor *invalidNodeColor;

-(instancetype)initWithDelegate:(id<PatternDelegate>)delegate;
-(void)layoutView;
-(void)updateViewForCorrectPatternAnimates:(BOOL)shouldAnimate;
-(void)updateViewForInCorrectPattern;
-(void)updateViewForReEntry;
-(void)invalidateCurrentPattern;
@end
