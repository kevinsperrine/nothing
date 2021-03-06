//
//  AWSMobileHubClient.m
//
//
// Copyright 2017 Amazon.com, Inc. or its affiliates (Amazon). All Rights Reserved.
//
// Code generated by AWS Mobile Hub. Amazon gives unlimited permission to 
// copy, distribute and modify it.
//
// Source code generated from template: aws-my-sample-app-ios-objc v0.20
//
//
#import "AWSMobileClient.h"
#import "AWSConfiguration.h"
#import <AWSMobileHubHelper/AWSMobileHubHelper.h>
#import <AWSPinpoint/AWSPinpoint.h>

@interface AWSMobileClient ()

@property (nonatomic) BOOL initialized;

@end

@implementation AWSMobileClient

- (instancetype)init {
    AWSDDLogDebug(@"init");
    self = [super init];
    _initialized = NO;
    [AWSDDLog sharedInstance].logLevel = AWSDDLogLevelInfo;
    return self;
}

- (void)dealloc {
    // Should never get called
    AWSDDLogError(@"Dealloc called on singleton AWSMobileClient.");
}

#pragma mark Singleton Methods

+ (instancetype)sharedInstance {
    static AWSMobileClient* client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[self alloc] init];
    });
    
    return client;
}

#pragma mark AppDelegate Methods

- (BOOL)didFinishLaunching:(UIApplication *)application
              withOptions:(NSDictionary *)launchOptions {
    AWSDDLogDebug(@"didFinishLaunching:withOptions:");
    
    
    BOOL didFinishLaunching = [[AWSSignInManager sharedInstance] interceptApplication:application
                                                        didFinishLaunchingWithOptions:launchOptions];
    
    //Register for push notifications
    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound);
    UIUserNotificationSettings *notificationSettings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
    [[UIApplication sharedApplication] registerForRemoteNotifications];

    if (!_initialized) {
        [[AWSSignInManager sharedInstance] resumeSessionWithCompletionHandler:^(id result, AWSIdentityManagerAuthState authState, NSError *error) {
            NSLog(@"result = %@, authState = %ld, error = %@", result, (long)authState, error);
        }];
        _initialized = YES;
    }
    
    _pinpoint = [AWSPinpoint pinpointWithConfiguration:[AWSPinpointConfiguration defaultPinpointConfigurationWithLaunchOptions:launchOptions]];

    return didFinishLaunching;
}

- (BOOL)withApplication:(UIApplication *)application
               withURL:(NSURL *)url
 withSourceApplication:(NSString *)sourceApplication
        withAnnotation:(id)annotation {
    AWSDDLogDebug(@"withApplication:withURL:...");
    
    [[AWSSignInManager sharedInstance] interceptApplication:application
                                                    openURL:url
                                          sourceApplication:sourceApplication
                                                 annotation:annotation];
    
    if (!_initialized) {
        _initialized = YES;
    }

    return NO;
}


- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"didRegisterForRemoteNotificationsWithDeviceToken: %@", deviceToken);
    
    [_pinpoint.notificationManager interceptDidRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"didFailToRegisterForRemoteNotificationsWithError: %@", error);
}

- (void) application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    [_pinpoint.notificationManager interceptDidReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
}

#pragma mark - AWS Methods



@end
