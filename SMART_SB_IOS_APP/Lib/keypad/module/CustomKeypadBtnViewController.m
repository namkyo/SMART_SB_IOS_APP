//
//  CustomKeypadViewController.m
//  KeypadSample
//
//  Created by GyeongO Eo on 2017. 2. 23..
//  Copyright © 2017년 Everspin. All rights reserved.
//

#import "CustomKeypadBtnViewController.h"
#import "ESKeypadView.h"
#import "ESSecureTextField.h"
#import "ESGraphicTools.h"

@interface CustomKeypadBtnViewController () <ESSecureTextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *mainTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *mainTitleContainer;
@property (weak, nonatomic) IBOutlet UIView *contentContainer;

@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;            /* Tag 100 */
@property (weak, nonatomic) IBOutlet UIView *textFieldContainerView;    /* Tag 200 */
@property (weak, nonatomic) IBOutlet UIView *okayCancelContainer;       /* Tag 300 */
@property (weak, nonatomic) IBOutlet UIButton *buttonCancel;            /* Tag 301 */
@property (weak, nonatomic) IBOutlet UIButton *buttonOkay;              /* Tag 302 */

@property (strong, nonatomic) IBOutlet UIView *infoViewPort;
@property (strong, nonatomic) IBOutlet UIView *infoViewLand;
@property (strong, nonatomic) UIView* infoView;

@property (strong) ESKeypadSpec *spec;

@end

@implementation CustomKeypadBtnViewController
{
    ESSecureTextField *_secureTextField;
}

+ (instancetype)newKeypadWithSpec:(ESKeypadSpec *)spec
{
    [ESKeypadViewController newKeypadWithSpec:spec];
    CustomKeypadBtnViewController *vc = [[CustomKeypadBtnViewController alloc] initWithNibName:@"CustomKeypadBtnViewController" bundle:NULL];
    vc.spec = spec;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect bounds = self.textFieldContainerView.bounds;
    bounds.origin.x += 10;
    bounds.size.width -= 10;
    
    _secureTextField = [[ESSecureTextField alloc] initWithFrame:bounds
                                                           spec:self.spec];
    _secureTextField.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _secureTextField.borderStyle = UITextBorderStyleNone;
    _secureTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _secureTextField.secureTextFieldDelegate = self;
    
    if (self.mainTitle)
        self.mainTitleLabel.text = self.mainTitle;
    
    if (self.placeholderText)
        _secureTextField.placeholder = self.placeholderText;
    
    //
    // Info View 초기화 (가로, 세로)
    //
    
    NSArray *arrTextField = [[NSArray alloc] initWithObjects:
                             self.infoViewLand, self.infoViewPort, nil];
    
    for(NSInteger i = 0, l = arrTextField.count; i < l; ++ i){
        UIView *ifv = [arrTextField objectAtIndex:i];
        UIView *textContainer = [ifv viewWithTag:200];
        
        [textContainer.layer setBorderWidth:1];
        [textContainer.layer setBorderColor:[[ESGraphicTools colorWithARGBInt:0xFFA3A3A3] CGColor]];
        
        UILabel* subtitleLabel = (UILabel *)[ifv viewWithTag:100];
        
        if (subtitleLabel)
            subtitleLabel.text = self.subTitle;
        
        UIButton* btnOkay = (UIButton *)[ifv viewWithTag:302];
        UIButton* btnCancel = (UIButton *)[ifv viewWithTag:301];
        
        btnCancel.backgroundColor = [ESGraphicTools colorWithARGBInt:0xff888888];
        btnOkay.backgroundColor = [ESGraphicTools colorWithARGBInt:0xFFF4BE48];
        
        [btnCancel setTitleColor:[ESGraphicTools colorWithARGBInt:0xFFFFFFFF]
                        forState:UIControlStateNormal];
        
        [btnOkay setTitleColor:[ESGraphicTools colorWithARGBInt:0xFFFFFFFF]
                      forState:UIControlStateNormal];
        
        [btnOkay addTarget:self
                    action:@selector(buttonOkayTouchedUpInside:)
          forControlEvents:UIControlEventTouchUpInside];
        
        [btnCancel addTarget:self
                      action:@selector(buttonCancelTouchedUpInside:)
            forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self loadInfoView:[self isVertical]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 화면이 뜨면서 바로 텍스트필드가 선택되어 키보드가 보이도록 한다.
    [_secureTextField becomeFirstResponder];
}


//
// ES Secure Text Field Delegate
//

- (void)secureTextFieldDidBeginEditing:(ESSecureTextField *)secureTextField
{
    // 키패드 뷰를 윈도우의 하단에 위치시킨다.
    CGSize suggestedSize = [secureTextField.keypadView.layoutManager suggestedSizeForContainerSize:self.view.bounds.size];
    secureTextField.keypadView.frame =
    CGRectMake(0, self.view.bounds.size.height - suggestedSize.height, suggestedSize.width, suggestedSize.height);
    
    [self.view addSubview:secureTextField.keypadView];
}

- (void)secureTextFieldDidReturn:(ESSecureTextField *)secureTextField
{
    BOOL shouldEnd = YES;
    if ([self.delegate respondsToSelector:@selector(keypadViewControllerShouldEndInput:)]) {
        shouldEnd = [self.delegate keypadViewControllerShouldEndInput:self];
    }
    if (shouldEnd) {
        [self.delegate keypadViewControllerDidEndInput:self];
    }
}


//
// 입력완료/취소 버튼 이벤트 핸들러
//

- (IBAction)buttonOkayTouchedUpInside:(id)sender {
    NSLog(@"buttonOkayTouchedUpInside");
    [self secureTextFieldDidReturn:_secureTextField];
}

- (IBAction)buttonCancelTouchedUpInside:(id)sender {
    NSLog(@"buttonCancelTouchedUpInside");
    [self.delegate keypadViewControllerDidCancelInput:self];
}

- (IBAction)cancel:(id)sender {
    [self.delegate keypadViewControllerDidCancelInput:self];
}


//
// 현재 화면 방향
//

- (BOOL)isVertical{
    CGSize size = [UIScreen mainScreen].bounds.size;
    return size.height > size.width;
}


//
// 화면 방향에 따라 취소/입력완료 부분 로딩
//

- (void)loadInfoView:(BOOL)isVertical{
    if(self.infoViewLand.superview){
        [self.infoViewLand removeFromSuperview];
    }
    
    if(self.infoViewPort.superview){
        [self.infoViewPort removeFromSuperview];
    }
    
    if(_secureTextField.superview){
        [_secureTextField resignFirstResponder];
        [_secureTextField removeFromSuperview];
    }
    
    if(isVertical){
        // 세로
        self.infoView = self.infoViewPort;
    }
    else{
        // 가로
        self.infoView = self.infoViewLand;
    }
    
    self.subTitleLabel = (UILabel *)[self.infoView viewWithTag:100];
    self.textFieldContainerView = (UIView *)[self.infoView viewWithTag:200];
    self.okayCancelContainer = (UIView *)[self.infoView viewWithTag:300];
    self.buttonCancel = (UIButton *)[self.infoView viewWithTag:301];
    self.buttonOkay = (UIButton *)[self.infoView viewWithTag:302];
    
    [self.textFieldContainerView addSubview:_secureTextField];
    CGRect bounds = self.textFieldContainerView.bounds;
    bounds.origin.x += 10;
    bounds.size.width -= 10;
    
    _secureTextField.frame = bounds;
    _secureTextField.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _secureTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_secureTextField becomeFirstResponder];
    [self.view addSubview:self.infoView];
    
    self.okayCancelContainer.backgroundColor = [ESGraphicTools colorWithARGBInt:0x00000000];
    
    self.infoView.backgroundColor = [ESGraphicTools colorWithARGBInt:0x00000000];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self loadInfoView:[self isVertical]];
    
    CGSize suggestedSize = [_secureTextField.keypadView.layoutManager suggestedSizeForContainerSize:self.view.bounds.size];
    _secureTextField.keypadView.frame = CGRectMake(0, self.view.bounds.size.height - suggestedSize.height, suggestedSize.width, suggestedSize.height);
    
    
    // Info View를 적절한 위치로 옮긴다.
    // 화면 상단에서 키패드 윗 부분까지의 중앙에 위치시키도록 한다.
    //
    // 하단 키패드가 Info View를 덮을 정도로 클 경우 적절하게 사이즈를 줄인다.
    
    CGFloat min = self.mainTitleContainer.frame.size.height;
    CGFloat max = _secureTextField.keypadView.frame.origin.y;
    CGRect keypadFrame = _secureTextField.keypadView.frame;
    
    if( ( max - min ) < (self.infoView.frame.size.height + 16)) {
        CGFloat diff = (self.infoView.frame.size.height + 16) - (max - min);
        _secureTextField.keypadView.frame =
        CGRectMake(0, keypadFrame.origin.y + diff, suggestedSize.width, keypadFrame.size.height - diff);
    }
    
    max = _secureTextField.keypadView.frame.origin.y;
    CGFloat dy = ((max - min) - (self.infoView.bounds.size.height)) / 2;
    
    self.infoView.frame = CGRectMake(0, dy + min, self.view.bounds.size.width, self.infoView.bounds.size.height);
    
    [_secureTextField.keypadView.superview bringSubviewToFront:_secureTextField.keypadView];
}


//
// 현재 입력 내용 확인
//

- (NSString *)encryptedString
{
    return [_secureTextField encryptedString];
}

- (NSData *)encryptedData
{
    return [_secureTextField encryptedData];
}

- (NSString *)encryptedStringForThirdParty
{
    return [_secureTextField encryptedStringForThirdParty];
}

- (NSData *)encryptedDataForThirdParty
{
    return [_secureTextField encryptedDataForThirdParty];
}

- (NSUInteger)enteredCharacters
{
    return [_secureTextField enteredCharacters];
}

- (char *)getPlainText
{
    return [_secureTextField getPlainText];
}

- (void)putPlainText:(char *)plainText
{
    return [_secureTextField putPlainText:plainText];
}

@end
