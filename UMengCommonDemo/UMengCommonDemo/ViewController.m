//
//  ViewController.m
//  UMengCommonDemo
//
//  Created by Emck on 9/24/13.
//  Copyright (c) 2013 AppTem. All rights reserved.
//

#import "ViewController.h"

#import <UMengCommon/UMengCommonConstants.h>

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)onClickShare:(id)sender
{
    [[UMengCommon defaultInstance] ShareWithText:@"测试分享" Image:[UIImage imageNamed:@"Demo.jpeg"]];
}

- (IBAction)onClickShare2:(id)sender
{
    [[UMengCommon defaultInstance] ShareWithText:@"测试分享" ImageFileName:@"Documents/Demo2.png"];
}

- (IBAction)onClickShare3:(id)sender
{
    [[UMengCommon defaultInstance] ShareWithText:@"测试分享" ResourceUrl:@"http://www.issgame.com/uploads/allimg/130923/1-130923104942533-lp.jpg" ResourceType:UMSocialUrlResourceTypeImage];
}

-(void)didFinishShareWithResult:(UMSResponseCode)shareResult
{
    if (shareResult == UMSResponseCodeSuccess) {        // 分享成功
        NSLog(@"didFinishShareWithResult Success");
    }
    else {                                              // 分享失败
        NSLog(@"didFinishShareWithResult %d",shareResult);
    }
}

@end