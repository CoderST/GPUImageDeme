//
//  BeautifyViewController.m
//  GPUImageDemo
//
//  Created by xiudou on 16/9/27.
//  Copyright © 2016年 xiudo. All rights reserved.
//

#import "BeautifyViewController.h"
#import <GPUImage.h>
#import "GPUImageBeautifyFilter.h"
@interface BeautifyViewController ()
/** 测试按钮 */
@property (nonatomic,strong) UIButton *beautiflButton;
/** 数据源 */
@property (nonatomic,strong) GPUImageVideoCamera *videoCamera;
/** 最终界面效果 */
@property (nonatomic,strong) GPUImageView *imageView;
@end

@implementation BeautifyViewController

- (UIButton *)beautiflButton{
    if (!_beautiflButton) {
        _beautiflButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_beautiflButton setTitle:@"开" forState:UIControlStateNormal];
        [_beautiflButton setTitle:@"关" forState:UIControlStateSelected];
        [_beautiflButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_beautiflButton setBackgroundColor:[UIColor blackColor]];
        [_beautiflButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _beautiflButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 添加测试按钮
    [self.view addSubview:self.beautiflButton];
    self.beautiflButton.frame = CGRectMake(self.view.frame.size.width - 60, 80, 40, 40);
    
    // 创建数据源
    GPUImageVideoCamera *videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionFront];
    // 设置显示方向
    videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    self.videoCamera = videoCamera;
    
    // 创建最终界面效果
    GPUImageView *imageView = [[GPUImageView alloc] initWithFrame:self.view.bounds];
    self.imageView = imageView;
    
    // 插入
    [self.view insertSubview:imageView atIndex:0];
    
    // 强引用,以防销毁对象
    [videoCamera addTarget:imageView];
    [videoCamera startCameraCapture];
}

- (void)buttonClick:(UIButton *)button{
    if (!button.selected) {
        // 改变按钮状态
        button.selected = YES;
        // 移除所有处理链
        [self.videoCamera removeAllTargets];
        // 添加美颜效果
        GPUImageBeautifyFilter *beautifyFilter = [[GPUImageBeautifyFilter alloc] init];
        // 设置GPUImage处理链，从数据源 => 滤镜 => 最终界面效果
        [self.videoCamera addTarget:beautifyFilter];
        [beautifyFilter addTarget:self.imageView];
    }else{
        // 改变按钮状态
        button.selected = NO;
        // 移除所有处历链
        [self.videoCamera removeAllTargets];
        // 设置GPUImage处理链，从数据源 => 最终界面效果
        [self.videoCamera addTarget:self.imageView];
    }
    
}


@end
