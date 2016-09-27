//
//  OwnViewController.m
//  GPUImageDemo
//
//  Created by xiudou on 16/9/27.
//  Copyright © 2016年 xiudo. All rights reserved.
//

#import "OwnViewController.h"
#import <GPUImage.h>
@interface OwnViewController ()
// 强引用属性
@property (nonatomic, weak) GPUImageBilateralFilter *bilateralFilter;
@property (nonatomic, weak) GPUImageBrightnessFilter *brightnessFilter;
@property (nonatomic, strong) GPUImageVideoCamera *videoCamera;

// 控件属性
- (IBAction)brightnessSld:(id)sender;
- (IBAction)BilateralSld:(id)sender;


@end

@implementation OwnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1 设置数据源
    GPUImageVideoCamera *videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionFront];
    videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    self.videoCamera = videoCamera;
    
    // 2 设置组 (美白 磨皮)
    GPUImageFilterGroup *filterGroup = [[GPUImageFilterGroup alloc] init];
    
    // 3 设置美白
    GPUImageBrightnessFilter *brightnessFilter = [[GPUImageBrightnessFilter alloc] init];
    self.brightnessFilter = brightnessFilter;
    [filterGroup addTarget:brightnessFilter];
    
    // 4 设置磨皮
    GPUImageBilateralFilter *bilateralFilter = [[GPUImageBilateralFilter alloc] init];
    self.bilateralFilter = bilateralFilter;
    [filterGroup addTarget:bilateralFilter];
    
    // 5 创建显示层
    GPUImageView *view = [[GPUImageView alloc] initWithFrame:self.view.bounds];
    [self.view insertSubview:view atIndex:0];
    
    // 5 添加滤镜链关系 ✨
    [bilateralFilter addTarget:brightnessFilter];
    [filterGroup setInitialFilters:@[bilateralFilter]];
    filterGroup.terminalFilter = brightnessFilter;
    
    // 设置GPUImage处理链，从数据源 => 滤镜 => 最终界面效果
    [videoCamera addTarget:filterGroup];
    [filterGroup addTarget:view];
    
    // 6 开始采集
    [self.videoCamera startCameraCapture];
    
    
    
    
}

// 美白
- (IBAction)brightnessSld:(UISlider *)sender {
    _brightnessFilter.brightness = sender.value;
}
// 磨皮
- (IBAction)BilateralSld:(UISlider *)sender {
    // 值越小，磨皮效果越好
    CGFloat maxValue = 10;
    [_bilateralFilter setDistanceNormalizationFactor:(maxValue - sender.value)];
}
@end
