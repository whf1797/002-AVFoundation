//
//  ViewController.m
//  003-AVFoundation
//
//  Created by 王洪飞 on 2018/11/19.
//  Copyright © 2018 王洪飞. All rights reserved.
//

#import "ViewController.h"


NSString *const THThumbnailCreateNotification = @"THThumbnailCreated" ;

@interface ViewController ()<AVCaptureFileOutputRecordingDelegate>

@property (strong, nonatomic)dispatch_queue_t videoQueue; //视频队列
@property (strong, nonatomic)AVCaptureSession *captureSession;// 捕捉会话
@property (weak, nonatomic)AVCaptureDeviceInput *activeVideoInput; //输入
@property (strong, nonatomic)AVCaptureMovieFileOutput *moveOutput;
@property (strong, nonatomic)NSURL *outputURL;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(BOOL)setupSession:(NSError *)error
{
    self.captureSession = [[AVCaptureSession alloc] init];
    // 设置分辨率
    self.captureSession.sessionPreset = AVCaptureSessionPreset640x480;
    
    // 拿到默认视频捕捉设备 ios系统返回后置摄像头
    AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //
    AVCaptureDeviceInput *videoinput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
    
    if (videoinput) {
        // canAddinput 测试能否添加到会话中
        if ([self.captureSession canAddInput:videoinput]) {
            [self.captureSession addInput:videoinput];
            self.activeVideoInput = videoinput;
            
        }
    }else{
        return NO;
    }
    
    // 选择默认音频捕捉设备 即返回一个内置麦克风
    AVCaptureDevice *audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    // 为设备创建一个捕捉设备输入
    AVCaptureDeviceInput *audioInput = [AVCaptureDeviceInput deviceInputWithDevice:audioDevice error:&error];
    
    if (audioInput) {
        if ([self.captureSession canAddInput:audioInput]) {
            [self.captureSession addInput:audioInput];
        }
    }else{
        return NO;
    }

    
    self.videoQueue = dispatch_queue_create("cc.videoqueue", DISPATCH_QUEUE_SERIAL);
    
    
    return YES;
}


-(void)startSession
{
    if (![self.captureSession isRunning]) {
        dispatch_async(self.videoQueue, ^{
            [self.captureSession startRunning];
        });
    }
}


-(void)stopSession
{
    if ([self.captureSession isRunning]) {
        dispatch_async(self.videoQueue, ^{
            [self.captureSession stopRunning];
        });
    }
}


-(AVCaptureDevice *)activeCamera
{
    return self.activeVideoInput.device;
}

-(AVCaptureDevice *)inactiveCamera
{
    return nil;
}




@end
