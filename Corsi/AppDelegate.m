//
//  AppDelegate.m
//  Corsi
//
//  Created by Jon Howell on 02/09/2014.
//  Copyright (c) 2014 Manchester Metropolitan University - ESS - essmobile. All rights reserved.
//  Minor updates and re-build for distro 2/11/15 jah
//  Minor updates and re-build for distro 9/9/16 jah
//

#import "AppDelegate.h"
#import "mySingleton.h"

@implementation AppDelegate{
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions

{
    mySingleton *singleton = [mySingleton sharedSingleton];
    
    UIAlertController * alertView =   [UIAlertController
                                       alertControllerWithTitle:@"Corsi Block Tapping Test App"
                                       message:@"Read The Instructions First..."
                                       preferredStyle:UIAlertControllerStyleAlert];
    
    alertView.view.tintColor          = [UIColor blueColor];//Agree button colour
    
    NSMutableAttributedString *textMessage = [[NSMutableAttributedString alloc] initWithString:@"To see details on how to use this\nApplication and adjust its settings,\nplease read the notes under the\n'(?)Information' Tab-Bar choice.\n\n* Safety Note *\nTake regular breaks and avoid\n strain. If you develop discomfort\n using this App,you must stop\n using it and seek advice.\n\nThis Application is NOT\n for clinical use.\n\nv1.4.5, Copyright © 24.3.2017"];
    
    long lens = [textMessage length];
    [textMessage addAttribute:NSFontAttributeName
     //value:[UIFont systemFontOfSize:10.0] //specific system font
                        value:[UIFont fontWithName:@"Courier" size:(10.5)] //any other font in the system
     //range:NSMakeRange(24, 11)];//splits string to when font size starts
                        range:NSMakeRange(0, lens)];//splits string to when font size starts and ends in characters starting at zero
    [alertView setValue:textMessage forKey:@"attributedMessage"]; //@"attributedTitle"]; //the text field you want font size and style to effect
    
    //the line '* safety note *' bigger font
    [textMessage addAttribute:NSFontAttributeName
                        value:[UIFont systemFontOfSize:14.0] //specific system font
     
     //range:NSMakeRange(24, 11)];//splits string to when font size starts
                        range:NSMakeRange(138, 15)];//splits string to when font size starts and ends in characters starting at zero
    [alertView setValue:textMessage forKey:@"attributedMessage"]; //@"attributedTitle"]; //the text field you want font size and style to effect
    
    //the line 'v1.0.1, Copyright © 8.Feb 2017' bigger font
    [textMessage addAttribute:NSFontAttributeName
                        value:[UIFont systemFontOfSize:14.0] //specific system font
     
     //range:NSMakeRange(24, 11)];//splits string to when font size starts
                        range:NSMakeRange(lens-30, 30)];//splits string to when font size starts and ends in characters starting at zero
    [alertView setValue:textMessage forKey:@"attributedMessage"]; //@"attributedTitle"]; //the text field you want font size and style to effect
    
    
    //[[UIView appearanceWhenContainedIn:UIAlertController.class, nil] setBackgroundColor:[UIColor yellowColor]];
    
    //[[UIView appearanceWhenContainedIn:UIAlertController.class, nil] setTintColor:[UIColor yellowColor]];
    
    alertView.view.layer.cornerRadius = 90.0; //sets the fade in of the background colour
    alertView.view.backgroundColor    = [UIColor yellowColor]; //centre background colour
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Agree - RUN App"
                         //style:UIAlertActionStyleDefault // could be 'destructive' or 'cancel'
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                         [alertView dismissViewControllerAnimated:YES completion:nil];
                         //NSLog(@"ok");
                         //continue to App run
                         singleton.okGoNow=YES;
                         }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Do Not Agree - EXIT App"
                             style:UIAlertActionStyleDestructive
                             handler:^(UIAlertAction * action)
                             {
                             [alertView dismissViewControllerAnimated:YES completion:nil];
                             //NSLog(@"canceled the App");
                             singleton.okGoNow=NO;
                             //stop App if cancelled
                             
                             if (singleton.okGoNow == NO) {
                                 //NSLog(@"Cancelled");
                                 //the app has been cancelled by the alert cancel in the accept message in AppDelegate
                                 //STOP//
                                 UIApplication *app = [UIApplication sharedApplication];
                                 [app performSelector:@selector(suspend)];
                                 
                                 //wait 2 seconds while app is going background
                                 [NSThread sleepForTimeInterval:2.0];
                                 
                                 //exit app when app is in background
                                 exit(0);
                                 //stop
                             } else {
                                 //NSLog(@"Running App.");
                             }
                             }];
    
    [alertView addAction:ok];
    [alertView addAction:cancel];
    [self.window addSubview:self.inputViewController.view];
    [self.window makeKeyAndVisible];
    
    [self.window.rootViewController presentViewController:alertView animated:TRUE completion:nil];
    
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
