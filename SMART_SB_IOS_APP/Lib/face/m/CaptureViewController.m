//
//  CaptureViewController.m
//  PACECRDemo
//
//  Created by styx on 2015. 7. 7..
//  Copyright (c) 2015년 PACE System. All rights reserved.
//

#import "CaptureViewController.h"
#import <PACECaptureNRecog/PACECaptureNRecog.h>
#import "MBProgressHUD.h"

#import "ViewController.h"

@interface CaptureViewController () <PACECRControlDelegate>

@property (nonatomic, retain) PACECRControl *crControl;

@end

@implementation CaptureViewController
{
//    PACECRControl *crControl;

    MBProgressHUD *activityIndicator;
    
    NSData *detectFailureImageJpgData;
    
    NSString *datFilePath;
}

@synthesize crControl;

- (NSString *)applicationDocumentsDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

- (void)showIndicator:(NSString *)text
{
    activityIndicator = [[MBProgressHUD alloc] initWithView:self.view];
    activityIndicator.labelText = text;
    [self.view addSubview:activityIndicator];
    [activityIndicator show:YES];
}

- (void)hideIndicator
{
    [activityIndicator hide:YES];
    [activityIndicator removeFromSuperview];
    activityIndicator = nil;
}

- (void)buttonClose
{
    [crControl stopCapture];
    [crControl releaseControl];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)buttonCapture
{
    [crControl capture];
}

- (void)buttonManualDetectDone
{
    NSLog(@"manual detect done!");
    
    [crControl manualDetectDone];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self initControl];
}

- (void)dealloc
{
    NSLog(@"*** deinit CaptureViewController ***");
}

- (void)initControl
{
    // 컨트롤 생성...
    crControl = [[PACECRControl alloc] initControl:self portrait:YES showGuideAnchor:YES setDetectLayer:YES];
    
    if(crControl != nil)
    {
        // dat file 복사
        NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        datFilePath = [NSString stringWithFormat:@"%@/dat", documentDirectory];
        
        //BOOL bDir;
        //if([[NSFileManager defaultManager] fileExistsAtPath:datFilePath isDirectory:&bDir] == NO)
        {
            [[NSFileManager defaultManager] createDirectoryAtPath:datFilePath withIntermediateDirectories:YES attributes:nil error:nil];
            
            NSString *wgtFileSourcePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"asc" ofType:@"wgt"];
            NSString *recFileSourcePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"hang" ofType:@"rec"];
            // 200323 추가
            NSString *wgt2FileSourcePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"idcard_kor_one" ofType:@"wgt"];
            
            NSString *wgtFileDestPath = [NSString stringWithFormat:@"%@/asc.wgt", datFilePath];
            NSString *recFileDestPath = [NSString stringWithFormat:@"%@/hang.rec", datFilePath];
            // 200323 추가
            NSString *wgt2FileDestPath = [NSString stringWithFormat:@"%@/idcard_kor_one.wgt", datFilePath];
            
            //200326 데이터 파일 세팅
            if ([[NSFileManager defaultManager] fileExistsAtPath:wgtFileDestPath]) {
                NSError *error;
                if (![[NSFileManager defaultManager] removeItemAtPath:wgtFileDestPath error:&error]) {
                    NSLog(@"Error removing file: %@", error);
                }
            }
            
            //200326 데이터 파일 세팅
            if ([[NSFileManager defaultManager] fileExistsAtPath:recFileDestPath]) {
                NSError *error;
                if (![[NSFileManager defaultManager] removeItemAtPath:recFileDestPath error:&error]) {
                    NSLog(@"Error removing file: %@", error);
                }
            }
            
            //200326 데이터 파일 세팅
            if ([[NSFileManager defaultManager] fileExistsAtPath:wgt2FileDestPath]) {
                NSError *error;
                if (![[NSFileManager defaultManager] removeItemAtPath:wgt2FileDestPath error:&error]) {
                    NSLog(@"Error removing file: %@", error);
                }
            }
            
            [[NSFileManager defaultManager] copyItemAtPath:wgtFileSourcePath toPath:wgtFileDestPath error:nil];
            [[NSFileManager defaultManager] copyItemAtPath:recFileSourcePath toPath:recFileDestPath error:nil];
            // 200323 추가
            [[NSFileManager defaultManager] copyItemAtPath:wgt2FileSourcePath toPath:wgt2FileDestPath error:nil];
        }
        
        datFilePath = [NSString stringWithFormat:@"%@/", datFilePath];
        // dat file 복사
        
        crControl.delegate = self;
        
        // 컨트롤 모드 설정...
        if(_bFlashOn)
        {
            [crControl setCaptureFlashMode:PACECRCONTROL_FLASH_ON];
        }
        else
        {
            [crControl setCaptureFlashMode:PACECRCONTROL_FLASH_OFF];
        }
        
        if(_bAutoCapture)
        {
            [crControl setCaptureMode:PACECRCONTROL_CAPTUREMODE_AUTO];
            _bAutoCapture = NO;
        }
        else
        {
            [crControl setCaptureMode:PACECRCONTROL_CAPTUREMODE_FUNCTION_CALL];
            _bAutoCapture = YES;
        }
        
        // 암호화 함수
        [crControl setEncrypt:PACE_ENC_IDNUM|PACE_ENC_IDNUM_SECOND|PACE_ENC_LICENSE|PACE_ENC_IMAGE_TOTAL];
        [crControl setDetectRatio:30];
        
        [crControl setDetectedColor:UIColor.yellowColor];
        [crControl setNotDetectedColor:UIColor.whiteColor];
        
        [crControl startCapture];
    }
    
    // capture overlay view의 custom ui는 다음과 같이 구성하면 됨.
    //    UIImageView *viewAnchorImage = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 40.0f + [[UIApplication sharedApplication] statusBarFrame].size.height, self.view.frame.size.width, self.view.frame.size.height - (90.0f + [[UIApplication sharedApplication] statusBarFrame].size.height))];
    //    viewAnchorImage.contentMode = UIViewContentModeScaleAspectFit;
    //    [viewAnchorImage setImage:[UIImage imageNamed:@"anchor.png"]];
    //    [self.view addSubview:viewAnchorImage];
    
    /*
     UIView *viewTop = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width, 40.0f + [[UIApplication sharedApplication] statusBarFrame].size.height)];
     viewTop.backgroundColor = [UIColor grayColor]
     [self.view addSubview:viewTop];
     */
    
    UIButton *overlayCancelButton = [UIButton new];
    //[overlayCancelButton setFrame:CGRectMake(self.view.bounds.size.width - 50, 26, 40, 30)];
//    [overlayCancelButton setFrame:CGRectMake(self.view.bounds.size.width / 1.15 - 20, self.view.bounds.size.height - 100, 40, 30)];
    [overlayCancelButton setTitle:@"취소" forState:UIControlStateNormal];
    [overlayCancelButton addTarget:self action:@selector(buttonClose) forControlEvents:UIControlEventTouchUpInside];
    [overlayCancelButton setBackgroundColor: [UIColor colorWithRed:7.0f/255.0f green:46.0f/255.0f blue:94.0f/255.0f alpha:1]];   //취소버튼 색깔
    
    [overlayCancelButton setTransform:CGAffineTransformMakeRotation(M_PI / 2)];
    [self.view addSubview:overlayCancelButton];
    
    /*
     UIView *viewBottom = [[UIView alloc] initWithFrame:CGRectMake(0.0f, [UIScreen mainScreen].bounds.size.height - 50, [UIScreen mainScreen].bounds.size.width, 50.0f)];
     viewBottom.backgroundColor = [UIColor orangeColor];
     */
    
    UIButton *captureButton =  [UIButton new];//[UIButton buttonWithType:UIButtonTypeSystem];
//    [captureButton setFrame:CGRectMake(self.view.bounds.size.width / 2 - 20, self.view.bounds.size.height - 50, 40, 30)];
    
//    captureButton.backgroundColor = UIColor.lightGrayColor;
    
//    [captureButton setFrame:CGRectMake(self.view.bounds.size.width / 2 - 120, self.view.bounds.size.height - 50, 120, 80)];
    
    [captureButton setImage:[UIImage imageNamed:@"ocr_pic_ok"] forState:UIControlStateNormal];
//    [captureButton setTitle:@"촬영" forState:UIControlStateNormal];
//    [captureButton setTintColor:UIColor.blackColor];
//    [captureButton setTintColor:nil];
    
    
    [captureButton addTarget:self action:@selector(buttonCapture) forControlEvents:UIControlEventTouchUpInside];
//    [captureButton setTransform:CGAffineTransformMakeRotation(M_PI / 2)];
    [self.view addSubview:captureButton];
    
    // capture button layout
    captureButton.translatesAutoresizingMaskIntoConstraints = false;
    [captureButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-30].active = true;
    [captureButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = true;
    [captureButton.widthAnchor constraintEqualToConstant:180].active = true;
    [captureButton.heightAnchor constraintEqualToConstant:80].active = true;

    // cancel button layout
    overlayCancelButton.translatesAutoresizingMaskIntoConstraints = false;
    [overlayCancelButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20].active = true;
    [overlayCancelButton.centerYAnchor constraintEqualToAnchor:captureButton.centerYAnchor].active = true;
    [overlayCancelButton.widthAnchor constraintEqualToConstant:60].active = true; // 취소버튼 width
    [overlayCancelButton.heightAnchor constraintEqualToConstant:60].active = true; // 취소버튼 height

    
    // 191212 촬영 모드 변경 버튼 추가
    UIButton *CaptureModeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    CaptureModeButton.backgroundColor = [UIColor colorWithRed:7.0f/255.0f green:46.0f/255.0f blue:94.0f/255.0f alpha:1]; // 수동 or 자동 색상
    [CaptureModeButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal]; // 버튼 titleLabel 색상
    
    if(_bAutoCapture) {
        [CaptureModeButton setTitle:@"수동" forState:UIControlStateNormal];
    } else {
        [CaptureModeButton setTitle:@"자동" forState:UIControlStateNormal];
    }
    
//    [CaptureModeButton setFrame:CGRectMake(self.view.bounds.size.width - 50, (self.view.bounds.size.height / 2) - 15, 40, 30)];
    [CaptureModeButton setTransform:CGAffineTransformMakeRotation(M_PI / 2)];
    
    [CaptureModeButton addTarget:self action:@selector(buttonCaptureMode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CaptureModeButton];
    
    // capture mode button layout
    CaptureModeButton.translatesAutoresizingMaskIntoConstraints = false;
    [CaptureModeButton.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:20].active = true;
    [CaptureModeButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = true;
    [CaptureModeButton.widthAnchor constraintEqualToConstant:100].active = true;
    [CaptureModeButton.heightAnchor constraintEqualToConstant:60].active = true;

    
}

- (void)buttonCaptureMode
{
    [crControl stopCapture];
    [crControl releaseControl];
    
    [self initControl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// portrait로 설정된 경우는 해당 없음.
// landscape left, landscape right를 모두 지원 할 경우 사용.
/*
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSLog(@"########################### Rotate!!! ###########################");
    
    UIDeviceOrientation orientation = (UIDeviceOrientation)[UIApplication sharedApplication].statusBarOrientation;
    
    [crControl setCurrentLandscapeOrientation:orientation];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - PACECRControlDelegate

// 이미지의 영역의 인식 여부를 리턴하는 delegate method
- (void)didWarpPerspectiveDetecting:(Boolean)boolean {
    if(boolean) {
        NSLog(@"############# Detecting!!! #############");
    } else {
        NSLog(@"############# No Detecting!!! #############");
    }
}

- (void)onStartWarpPerspectiveTransform
{
    NSLog(@"############# onStartWarpPerspectiveTransform #############");
    
    [self showIndicator:@"이미지 보정 중..."];
}

// 이미지 보정에 실패하였을 경우 불려지는 delegate method
- (void)didWarpPerspectiveFailure:(NSData *)stillImageJpgData
{
    NSLog(@"############# didWarpPerspectiveFailure #############");
    
    // 아래 [수동보정을 원할 때...]와 [연속적으로 재촬영을 원할 때...]을 택1하여 선택적으로 사용.
    
    // ###### 수동보정을 원할 때... ######
    detectFailureImageJpgData = stillImageJpgData;
    [self showAlert:100
            message:@"신분증을 감지하여 보정하는데 실패하였습니다. 수동으로 설정하여 보정하시겠습니까?"
       leftBtnTitle:@"취소"
      rightBtnTitle:@"수동 설정"];
    
    // ###### 연속적으로 재촬영을 원할 때... ######
//    [self showAlert:0
//            message:@"신분증을 감지하여 보정하는데 실패하였습니다.\n다시 시도해 주세요."];
//    [crControl startCapture];
//    [self hideIndicator];
}

// 이미지 보정에 성공하였을 경우 불려지는 delegate method
- (void)didWarpPerspectiveSuccess:(NSData *)adjustedImageJpgData
{
    NSLog(@"############# didWarpPerspectiveSuccess #############");
    
    [self hideIndicator];
    
    [self showIndicator:@"인식 중..."];
    
    // 1. 인식엔진 초기화
    CGSize resultSize = CGSizeMake(1127, 698); // 원하는 결과 신분증 이미지 사이즈
    int nRet = [crControl initRecognize:datFilePath sourceImageJpgData:adjustedImageJpgData resultIDCardSize:resultSize];
    
    if(nRet != 1)
    {
        [self hideIndicator];
        [self showAlert:0
                message:@"인식엔진 초기화에 실패하였습니다!"
           leftBtnTitle:@""
          rightBtnTitle:@"확인"];
        return;
    }
    
    // 2. 주민번호 유효성 여부 및 흑백 복사본 체크 여부 설정
    // 주민등록번호 유효성 검증 혹은 흑백 카피본 신분증에 대한 인식 허용 여부를 설정하려면 반드시 initRecognize 함수 호출 이후, recognize 함수 호출 이전에 설정해야 유효함.
    // setCheckIDNumberValidation, setCheckBlackNWhiteCopy
    [crControl setCheckIDNumberValidation:NO];
    [crControl setCheckBlackNWhiteCopy:YES];
    
    // 3. 인식
    NSDictionary *resultDictionary = [[NSDictionary alloc] init];
    nRet = [crControl recognize:&resultDictionary];
    
    // 1:주민등록증 3:운전면허증 9:외국인등록증
    if(nRet != 1 && nRet != 3 && nRet != 9)
    {
        [self hideIndicator];
        
        // 5. 인식 엔진 해제(해제하지 않으면 메모리가 누수되므로 반드시 해야함)
        [crControl releaseRecognize];
        
        if(nRet == -1) {
            [self showAlert:0
                    message:@"인식엔진이 초기화되지 않았습니다! 인식엔진 초기화 후 다시 시도해 주십시오."
               leftBtnTitle:nil
              rightBtnTitle:@"확인"];
        } else { // 주민등록증(1), 운전면허증(3) 이외(2:주민등록증 뒷면, 4:운전면허증 뒷면 등등)의 리턴값은 0보다 크더라도 모두 인식실패로 분류.
            [self showAlert:0
                    message:@"인식에 실패하였습니다! 다시 시도해 주십시오."
               leftBtnTitle:nil
              rightBtnTitle:@"확인"];
        }
        
    }
    else
    {
        NSString *idCardType = [NSString stringWithFormat:@"%d", nRet];
        
        // 4. 인식 후 이미지 데이터 가져오기 예제(인식성공후에만 결과이미지를 가져올 수 있음)
        NSString *documentDirectory = [self applicationDocumentsDirectory];
        
        // format : jpg / mask : 주민번호 / mask 컬러 : red
        NSString *idCardJpgPath_maskIDNumber_maskColorRed = [NSString stringWithFormat:@"%@/idCard_maskIDNumber_maskColorRed.jpg", documentDirectory];
        NSData *idCardJpgData_maskIDNumber_maskColorRed = [crControl getIDCardImageData:PACECRCONTROL_GET_IMAGE_FORMAT_JPEG maskType:PACECRCONTROL_GET_IMAGE_MASK_TYPE_IDNUMBER maskColor:[UIColor redColor] imageQuality:100];
        [idCardJpgData_maskIDNumber_maskColorRed writeToFile:idCardJpgPath_maskIDNumber_maskColorRed atomically:NO];
        
        // format : jpg / mask : 주민번호 & 얼굴 / mask 컬러 : white
        NSString *idCardJpgPath_maskIDNumberNFace_maskColorWhite = [NSString stringWithFormat:@"%@/idCard_maskIDNumberNFace_maskColorWhite.jpg", documentDirectory];
        NSData *idCardJpgData_maskIDNumberNFace_maskColorWhite = [crControl getIDCardImageData:PACECRCONTROL_GET_IMAGE_FORMAT_JPEG maskType:PACECRCONTROL_GET_IMAGE_MASK_TYPE_IDNUMBER | PACECRCONTROL_GET_IMAGE_MASK_TYPE_FACE maskColor:[UIColor whiteColor] imageQuality:100];
        [idCardJpgData_maskIDNumberNFace_maskColorWhite writeToFile:idCardJpgPath_maskIDNumberNFace_maskColorWhite atomically:NO];
        
        // format : tiff / mask : 주민번호 & 얼굴 & 작은얼굴 / mask 컬러 : black
        NSString *idCardTifPath_maskIDNumberNFaceNSmallFace_maskColorBlack = [NSString stringWithFormat:@"%@/idCard_maskIDNumberNFaceNSmallFace_maskColorBlack.tif", documentDirectory];
        NSData *idCardTifData_maskIDNumberNFaceNSmallFace_maskColorBlack = [crControl getIDCardImageData:PACECRCONTROL_GET_IMAGE_FORMAT_TIFF maskType:PACECRCONTROL_GET_IMAGE_MASK_TYPE_IDNUMBER | PACECRCONTROL_GET_IMAGE_MASK_TYPE_FACE | PACECRCONTROL_GET_IMAGE_MASK_TYPE_SMALL_FACE maskColor:[UIColor blackColor] imageQuality:100];
        [idCardTifData_maskIDNumberNFaceNSmallFace_maskColorBlack writeToFile:idCardTifPath_maskIDNumberNFaceNSmallFace_maskColorBlack atomically:NO];
        
        // format : tiff / mask : 주민번호 & 얼굴 & 운전면허번호 / mask 컬러 : black
        NSString *idCardTifPath_maskIDNumberNFaceNDriverLicenseNumber_maskColorBlack = [NSString stringWithFormat:@"%@/idCard_maskIDNumberNDriverLicenseNumber_maskColorBlack.tif", documentDirectory];
        NSData *idCardTifData_maskIDNumberNFaceNDriverLicenseNumber_maskColorBlack = [crControl getIDCardImageData:PACECRCONTROL_GET_IMAGE_FORMAT_TIFF maskType:PACECRCONTROL_GET_IMAGE_MASK_TYPE_IDNUMBER | PACECRCONTROL_GET_IMAGE_MASK_TYPE_FACE | PACECRCONTROL_GET_IMAGE_MASK_TYPE_DRIVER_LICENSE_NUMBER maskColor:[UIColor blackColor] imageQuality:100];
        [idCardTifData_maskIDNumberNFaceNDriverLicenseNumber_maskColorBlack writeToFile:idCardTifPath_maskIDNumberNFaceNDriverLicenseNumber_maskColorBlack atomically:NO];
        
        // format : jpg / mask : 없음
        NSString *idCardJpgPath_maskNone = [NSString stringWithFormat:@"%@/idCard_maskNone.jpg", documentDirectory];
        NSData *idCardJpgData_maskNone = [crControl getIDCardImageData:PACECRCONTROL_GET_IMAGE_FORMAT_JPEG maskType:PACECRCONTROL_GET_IMAGE_MASK_TYPE_NONE maskColor:nil imageQuality:100];
        [idCardJpgData_maskNone writeToFile:idCardJpgPath_maskNone atomically:NO];
        
        // 얼굴 bitmap
        NSString *faceBitmapPath = [NSString stringWithFormat:@"%@/face.bmp", documentDirectory];
        NSData *faceBitmapData = [crControl getFaceBitmapData];
        [faceBitmapData writeToFile:faceBitmapPath atomically:NO];
        
        
        
         // 주민등록번호 뒷자리 복호화 테스트
//         NSString *base64String = [[resultDictionary objectForKey:@"IDNUMBER_LAST_SEVEN_DIGIT_ENCRYPTED"] objectForKey:@"TEXT"];
//        NSLog(@"암호화 된 주민등록번호 뒷자리 복호화 테스트 전 : %@", base64String);
//         NSData *encryptedData = [[NSData alloc] initWithBase64EncodedString:base64String options:0];
//         NSString *plainText = [crControl decryptSEED128Data:encryptedData];
//         NSLog(@"암호화 된 주민등록번호 뒷자리 복호화 테스트 : %@", plainText);
         // 주민등록번호 뒷자리 복호화 테스트
         
         
        // 로컬 암호화 테스트
        //idCardJpgData_maskIDNumberNFace_maskColorWhite = [crControl getEncryptImageData:adjustedImageJpgData];
        
        // 이미지 복호화 테스트
        idCardJpgData_maskIDNumberNFace_maskColorWhite = [crControl decryptSEED128ByteData:idCardJpgData_maskIDNumberNFace_maskColorWhite];
        
//            NSLog(@"TEST => %lu", (unsigned long)idCardJpgData_maskIDNumberNFace_maskColorWhite.length);
        
        // pass result (image path and recogintion result)
        NSDictionary *dicResult = [NSDictionary dictionaryWithObjectsAndKeys:idCardType, @"type", idCardJpgData_maskIDNumberNFace_maskColorWhite, @"resultimage", faceBitmapData, @"faceimage", resultDictionary, @"resultrecognitionvalue", nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CAPTURECOMPLETENOTIFICATION" object:dicResult];
        
        [self hideIndicator];
        
        // 5. 인식 엔진 해제(해제하지 않으면 메모리가 누수되므로 반드시 해야함)
        [crControl releaseRecognize];

        [crControl releaseControl];
        
        [self dismissViewControllerAnimated:YES completion:^{
            [self.delegate completeCapture:dicResult
                                      type:nRet];
        }];
    }
    
    [crControl releaseControl];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIAlertView delegate protocol
- (void)showAlert:(int)tag message:(NSString *)message leftBtnTitle:(NSString *)leftTitle rightBtnTitle:(NSString *)rightTitle{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"안내"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    alert.message = message;
    
    // 오른쪽 버튼
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:rightTitle
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction *action){
        [self confirmHandler:tag];
    }];
    
    [alert addAction:confirm];
    
    // tag가 0이 아니면 cancel버튼 보여주기
    if(tag != 0) {
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:leftTitle
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action){
            [self cancelHandler:tag];
            
        }];
        [alert addAction:cancel];
    }
    
    [self presentViewController:alert
                       animated:true
                     completion:nil];
    
    
}

- (void)confirmHandler:(int)tag {
    if(tag == 100) {
        UIImage *image = [UIImage imageWithData:detectFailureImageJpgData];
        [crControl manualDetect:image];
        
        // 수동 설정 완료 버튼
        UIButton *overlayManualDetectDoneButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [overlayManualDetectDoneButton setFrame:CGRectMake(self.view.bounds.size.width - 50, 40, 40, 30)];
        [overlayManualDetectDoneButton setTitle:@"완료" forState:UIControlStateNormal];
        [overlayManualDetectDoneButton addTarget:self action:@selector(buttonManualDetectDone) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:overlayManualDetectDoneButton];
    }
}

- (void)cancelHandler:(int)tag {
    if(tag == 100) {
        [self hideIndicator];
        [crControl releaseControl];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
}

@end
