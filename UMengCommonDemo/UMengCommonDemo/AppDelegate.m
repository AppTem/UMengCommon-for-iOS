//
//  AppDelegate.m
//  UMengCommonDemo
//
//  Created by Emck on 9/24/13.
//  Copyright (c) 2013 AppTem. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import <UMengCommon/UMengCommon.h>
#import <UMengCommon/UMengCommonConstants.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //////////------------------------UMengCommonSDK for iOS------------- Add -----
    [UMengCommon setAppKey:@"51fb3f9d56240b4bcb03fc5d"];
    [UMengCommon setChannelID:@"EmckTest"];
    [UMengCommon setShareToSnsNames:[NSArray arrayWithObjects:UMengCommonSocialShareToTencent,UMengCommonSocialShareToSina,nil]];
    //////////------------------------UMengCommonSDK for iOS------------- End -----
    
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[ViewController alloc] initWithNibName:@"Main_iPhone" bundle:nil];
    } else {
        self.viewController = [[ViewController alloc] initWithNibName:@"Main_iPad" bundle:nil];
    }
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    //////////------------------------UMengCommonSDK for iOS------------- Add -----
    [UMengCommon setViewAndDelegate:self.viewController Delegate:self.viewController];
    //////////------------------------UMengCommonSDK for iOS------------- End -----
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
