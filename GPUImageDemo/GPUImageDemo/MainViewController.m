//
//  MainViewController.m
//  GPUImageDemo
//
//  Created by xiudou on 16/9/27.
//  Copyright © 2016年 xiudo. All rights reserved.
//

#import "MainViewController.h"
#import "BeautifyViewController.h"
#import "OwnViewController.h"
@interface MainViewController ()
- (IBAction)beautifulButton:(id)sender;

- (IBAction)ownButton:(id)sender;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)beautifulButton:(id)sender {
    BeautifyViewController *beautifyVC = [[BeautifyViewController alloc] init];
    [self.navigationController pushViewController:beautifyVC animated:YES];
    
}

- (IBAction)ownButton:(id)sender {
    OwnViewController *ownVC = [[OwnViewController alloc] init];
    [self.navigationController pushViewController:ownVC animated:YES];
}
@end
