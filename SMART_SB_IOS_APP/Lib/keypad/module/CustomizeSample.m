//
//  CustomizeSample.m
//  KeypadSample
//
//  Created by YoonSungwook on 2016. 11. 11..
//  Copyright © 2016년 Everspin. All rights reserved.
//

#import "CustomizeSample.h"
#import "ESKeypadViewController.h"


@implementation CustomNumberAppearenceManager
- (NSDictionary *)customImagesInfoForCharacter:(char)character
{
    // 키 배경색을 회색으로 바꾸는 예제
    NSMutableDictionary *info = [[super customImagesInfoForCharacter:character] mutableCopy];
    UIImage *backgroundImage = (UIImage *)[info valueForKey:ESKeyNormalBackgroundImage];
    if (backgroundImage) {
        CGRect rect = CGRectMake(0, 0, backgroundImage.size.width, backgroundImage.size.height);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextClipToMask(context, rect, backgroundImage.CGImage);
        CGContextSetFillColorWithColor(context, [[UIColor grayColor] CGColor]);
        CGContextFillRect(context, rect);
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        UIImage *flippedImage = [UIImage imageWithCGImage:img.CGImage
                                                    scale:1.0 orientation: UIImageOrientationUp];
        
        [info setObject:flippedImage forKey:ESKeyNormalBackgroundImage];
    }
    return info;
}

- (NSDictionary *)customImagesInfoForSpecialKey:(ESSpecialKey)specialKey
{
    // 특수문자 전환키를 없애는 예제
    if (specialKey == ESSpecialKeyToggle)
        return  nil;
    return [super customImagesInfoForSpecialKey:specialKey];
}




@end

@implementation CustomNumberLayoutManager
- (CGRect)frameForKeyAtRow:(NSUInteger)row column:(NSUInteger)column
{
    // 키를 작게 만드는 예제
    CGRect rect = [super frameForKeyAtRow:row column:column];
    return CGRectInset(rect, 1, 1);
}

- (CGRect)frameForSpecialKey:(ESSpecialKey)specialKey
{
    // 키를 작게 만드는 예제
    CGRect rect = [super frameForSpecialKey:specialKey];
    return CGRectInset(rect, 1, 1);
}



@end

//쿼티 커스텀
@implementation CustomQwertyAppearenceManager

- (NSDictionary *)customImagesInfoForCharacter:(char)character
{
    // 키 배경색을 바꾸는 예제
    NSMutableDictionary *info = [[super customImagesInfoForCharacter:character] mutableCopy];
    UIImage *backgroundImage = (UIImage *)[info valueForKey:ESKeyNormalBackgroundImage];
    if (backgroundImage) {
        CGRect rect = CGRectMake(0, 0, backgroundImage.size.width, backgroundImage.size.height);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextClipToMask(context, rect, backgroundImage.CGImage);
        CGContextSetFillColorWithColor(context, [[UIColor colorWithRed:7.0f/255.0f green:46.0f/255.0f blue:94.0f/255.0f alpha:1] CGColor]);
        CGContextFillRect(context, rect);
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        UIImage *flippedImage = [UIImage imageWithCGImage:img.CGImage
                                                    scale:1.0 orientation: UIImageOrientationUp];
        
        [info setObject:flippedImage forKey:ESKeyNormalBackgroundImage];
    }
    
    
    // 키 자판색을 바꾸는 예제
    UIImage *keyImage = (UIImage *)[info valueForKey:ESKeyNormalSymbolImage];
    if (keyImage) {
        CGRect rect = CGRectMake(0, 0, keyImage.size.width, keyImage.size.height);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextClipToMask(context, rect, keyImage.CGImage);
        CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
        CGContextFillRect(context, rect);
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        UIImage *flippedImage = [UIImage imageWithCGImage:img.CGImage
                                                    scale:1.0 orientation: UIImageOrientationDownMirrored];
        [info setObject:flippedImage forKey:ESKeyNormalSymbolImage];
    }
    
    return info;
}

- (NSDictionary *)customImagesInfoForSpecialKey:(ESSpecialKey)specialKey
{
    NSMutableDictionary *info = [NSMutableDictionary new] ;
    
    // 특수문자 전환키를 없애는 예제
    //if (specialKey == ESSpecialKeyToggle)  return  nil;
//    if (specialKey == ESSpecialKeyToggle) {
//        UIImage *backgroundImage = (UIImage *)[info valueForKey:ESKeyNormalSymbolImage];
//        
//        if (backgroundImage){
//            // 키 배경색을 바꾸는 예제
//            CGRect rect = CGRectMake(0, 0, backgroundImage.size.width, backgroundImage.size.height);
//            UIGraphicsBeginImageContext(rect.size);
//            CGContextRef context = UIGraphicsGetCurrentContext();
//            CGContextClipToMask(context, rect, backgroundImage.CGImage);
//            CGContextSetFillColorWithColor(context, [[UIColor colorWithRed:7.0f/255.0f green:46.0f/255.0f blue:94.0f/255.0f alpha:1] CGColor]);
//            CGContextFillRect(context, rect);
//            UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//            UIGraphicsEndImageContext();
//            
//            UIImage *flippedImage = [UIImage imageWithCGImage:img.CGImage
//                                                        scale:1.0 orientation: UIImageOrientationUp];
//            [info setObject:flippedImage forKey:ESSpecialKeyToggle];
//        }
//    }
    
    
    
    return [super customImagesInfoForSpecialKey:specialKey];
}

@end


@implementation CustomQwertyLayoutManager

- (CGRect)frameForKeyAtRow:(NSUInteger)row column:(NSUInteger)column
{
    // 키를 작게 만드는 예제
    CGRect rect = [super frameForKeyAtRow:row column:column];
    return CGRectInset(rect, 1, 1);
}

- (CGRect)frameForSpecialKey:(ESSpecialKey)specialKey
{
    // 키를 작게 만드는 예제
    CGRect rect = [super frameForSpecialKey:specialKey];
    return CGRectInset(rect, 1, 1);
}

@end


//@interface CustomizeSample () <UITextFieldDelegate, ESKeypadViewControllerDelegate>
//@property (strong) ESKeypadViewController *keypadVC;
//
//@end
//
//@implementation CustomizeSample
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    ESKeypadSpec *spec = [[ESKeypadSpec alloc] init];
//    spec.maxInputLength = 16;
//    spec.keypadType = ESKeypadTypeQwerty;
//    spec.appearenceManager = [CustomAppearenceManager new];
//    spec.layoutManager = [CustomLayoutManager new];
//    self.keypadVC = [ESKeypadViewController newKeypadWithSpec:spec];
//    self.keypadVC.delegate = self;
//}
//
//- (IBAction)showKeypad:(id)sender {
//    [self presentViewController:self.keypadVC animated:YES completion:nil];
//}
//
//- (void)keypadViewControllerDidCancelInput:(ESKeypadViewController *)keypadViewController
//{
//    // 사용자가 취소 버튼을 누른 경우.
//    // 모달 방식으로 띄운 키패드 뷰컨트롤러를 내린다.
//    [keypadViewController dismissViewControllerAnimated:YES completion:nil];
//}
//
//- (void)keypadViewControllerDidEndInput:(ESKeypadViewController *)keypadViewController
//{
//    // 사용자가 입력을 완료한 경우
//    [keypadViewController dismissViewControllerAnimated:YES completion:nil];
//}
//
//
//
//
//@end
