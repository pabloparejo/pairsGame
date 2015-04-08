//
//  AppDelegate.m
//  PairsApp
//
//  Created by parejo on 7/4/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

#import "AppDelegate.h"
#import "PARCardsViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    PARCardsViewController *vc = [[PARCardsViewController alloc]init];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:vc];
    [self configureAppearance];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setRootViewController:navVC];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void) configureAppearance{
    UIColor *background =[UIColor colorWithRed:221.0/255
                                         green:75.0/255
                                          blue:76.0/255
                                         alpha:1];
    
    [[UINavigationBar appearance] setBarTintColor:background];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2];
    shadow.shadowOffset = CGSizeMake(0, 1);

    UIColor *blueColor = [UIColor colorWithRed:229.0/255 green:225.0/255 blue:214.0/255 alpha:1.0];
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setTitleTextAttributes: @{NSForegroundColorAttributeName:blueColor,
                                                            NSShadowAttributeName:shadow,
                                                            NSFontAttributeName:[UIFont fontWithName:@"TrebuchetMS-Bold" size:32.0]}];

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

@end
