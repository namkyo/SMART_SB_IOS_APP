//
//  PACECRControl.h
//  PACECaptureNRecog
//
//  Created by styx on 2015. 7. 3..
//  Copyright (c) 2015년 PACE System. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

typedef enum : NSInteger
{
    PACECRCONTROL_CAPTUREMODE_AUTO,
    PACECRCONTROL_CAPTUREMODE_SCREEN_TOUCH,
    PACECRCONTROL_CAPTUREMODE_FUNCTION_CALL
} PACECRCONTROL_CAPTUREMODE;

typedef enum : NSInteger
{
    PACECRCONTROL_FLASH_ON,
    PACECRCONTROL_FLASH_OFF
    
} PACECRCONTROL_FLASH;

typedef enum : NSInteger
{
    PACECRCONTROL_GET_IMAGE_FORMAT_JPEG,
    PACECRCONTROL_GET_IMAGE_FORMAT_TIFF
} PACECRCONTROL_GET_IMAGE_FORMAT;

typedef enum : NSInteger
{
    PACECRCONTROL_GET_IMAGE_MASK_TYPE_NONE = 0,
    PACECRCONTROL_GET_IMAGE_MASK_TYPE_FACE = 1,
    PACECRCONTROL_GET_IMAGE_MASK_TYPE_IDNUMBER = 2,
    PACECRCONTROL_GET_IMAGE_MASK_TYPE_SMALL_FACE = 4,
    PACECRCONTROL_GET_IMAGE_MASK_TYPE_DRIVER_LICENSE_NUMBER = 8,
} PACECRCONTROL_GET_IMAGE_MASK_TYPE;

typedef enum : NSInteger
{
    PACE_ENC_IDNUM = 0x0001,            // 1    idnum first field
    PACE_ENC_IDNUM_FIRST = 0x0002,      // 2    idnum first field
    PACE_ENC_IDNUM_SECOND = 0x0004,     // 4    idnum second field
    PACE_ENC_NAME = 0x0008,             // 8    name field
    PACE_ENC_DATE = 0x0010,             // 16   date field
    PACE_ENC_RENEWAL = 0x0020,          // 32   license card renewal date field
    PACE_ENC_LICENSE = 0x0040,          // 64   license number field
    PACE_ENC_CHECKDIGIT = 0x0080,       // 256  license checkdigit field
    PACE_ENC_IMAGE_FACE = 0x0100,       // 512  idcard face image
    PACE_ENC_IMAGE_TOTAL = 0x0200,      // 800  idcard total image
} PACECRCONTROL_SET_ENCRYPT_TYPE;

@protocol PACECRControlDelegate <NSObject>

@required
- (void)didWarpPerspectiveSuccess:(NSData *)adjustedImageJpgData;

@optional
- (void)didWarpPerspectiveFailure:(NSData *)stillImageJpgData;
- (void)onStartWarpPerspectiveTransform;
- (void)didWarpPerspectiveDetecting:(Boolean)boolean;

@end

@interface PACECRControl : NSObject <AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, assign) id <PACECRControlDelegate> delegate;

// control life cycle
- (id)initControl:(UIViewController *)superViewController portrait:(BOOL)bPortrait showGuideAnchor:(BOOL)bShow setDetectLayer:(BOOL)status;
- (void)releaseControl;

// about capture
- (void)startCapture;
- (void)stopCapture;
- (void)setCaptureMode:(PACECRCONTROL_CAPTUREMODE)mode;
- (void)setCaptureFlashMode:(PACECRCONTROL_FLASH)mode;
- (void)capture;

- (void)setDetectRatio:(NSInteger)ratio;

- (void)setDetectedColor:(UIColor *)color;
- (void)setNotDetectedColor:(UIColor *)color;

// UI
- (void)setCurrentLandscapeOrientation:(UIDeviceOrientation)orientation;    // landscape일 때만 사용. App이 Portrait일 경우는 사용하지 않음.

- (BOOL)turnFlashOnImmediately;
- (BOOL)turnFlashOffImmediately;

// manual detect
- (void)manualDetect:(UIImage *)captureImage;
- (void)manualDetectDone;

// about recognize
- (int)initRecognize:(NSString *)datPath sourceImageJpgData:(NSData *)adjustedImageJpgData resultIDCardSize:(CGSize)idcardsize;
- (void)setCheckIDNumberValidation:(BOOL)bCheck;
- (void)setCheckBlackNWhiteCopy:(BOOL)bCheck;
- (void)setEncrypt:(PACECRCONTROL_SET_ENCRYPT_TYPE)type;
- (int)recognize:(NSDictionary **)dictionaryResult;
- (NSData *)getIDCardImageData:(PACECRCONTROL_GET_IMAGE_FORMAT)format maskType:(PACECRCONTROL_GET_IMAGE_MASK_TYPE)type maskColor:(UIColor *)color imageQuality:(NSInteger)quality;
- (NSData *)getFaceBitmapData;
- (NSData *)getEncryptImageData:(NSData *)imageData;
- (void)releaseRecognize;

// test utilities
- (NSData *)decryptSEED128ByteData:(NSData *)encryptedData;
- (NSString *)decryptSEED128Data:(NSData *)encryptedData;

@end
