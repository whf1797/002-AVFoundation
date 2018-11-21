//
//  ViewController.h
//  003-AVFoundation
//
//  Created by 王洪飞 on 2018/11/19.
//  Copyright © 2018 王洪飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

extern NSString *const THThumbnailCreateNotification;

@protocol THcameraControllerDelegate <NSObject>

-(void)deviceConfigurationFailedWithError:(NSError *)error;
-(void)mediaCaptureFailedWithError:(NSError *)error;
-(void)assetLibraryWriteFailedWithError:(NSError *)error;


@end

@interface ViewController : UIViewController

@property (weak, nonatomic) id <THcameraControllerDelegate>delegate;
@property (nonatomic, strong , readonly)AVCaptureSession *captureSession;

-(BOOL)setupSession:(NSError *)error;
-(void)startSession;
-(void)stopSession;

-(BOOL)switchCameras;
-(BOOL)canSwitchCameras;

@property (nonatomic, readonly)NSUInteger cameraCount;

@property (nonatomic, readonly)BOOL cameraHasTorch; // 手电筒

@property (nonatomic, readonly)BOOL camearHasFlash; //闪光灯

@property (nonatomic, readonly)BOOL cameraSupportsTapToFocus; // 聚焦

@property (nonatomic, readonly)BOOL cameraSupportsTapToExpose;// 曝光

@property (nonatomic)AVCaptureTorchMode torchMode;

@property (nonatomic)AVCaptureFlashMode flashMode;

// 聚焦 曝光 重设聚焦 曝光的方法
-(void)focusAtPoint:(CGPoint)point;
-(void)exposeAtPoint:(CGPoint)point;
-(void)resetFocusAndExposureModes;

// 实现捕捉静态图片 视频的g功能
-(void)captureStillImage;

// 开始录制
-(void)startRecording;
// 停止录制
-(void)stopRecording;
// 获取录制状态
-(BOOL)isRecording;
// 录制时间
-(CMTime)recordedDuration;
@end

