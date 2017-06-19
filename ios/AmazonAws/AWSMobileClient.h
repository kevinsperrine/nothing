//
//  AWSMobileHubClient.h
//
//
// Copyright 2017 Amazon.com, Inc. or its affiliates (Amazon). All Rights Reserved.
//
// Code generated by AWS Mobile Hub. Amazon gives unlimited permission to 
// copy, distribute and modify it.
//
// Source code generated from template: aws-my-sample-app-ios-objc v0.20
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AWSCore/AWSCore.h>
#import <AWSPinpoint/AWSPinpoint.h>

@interface AWSMobileClient : NSObject

/**
 * AWSPinpoint client - Used for Pinpoint Analytics and Pinpoint Targeting
 */
@property(atomic) AWSPinpoint *pinpoint;

/**
 * Retrieves a shared instance of this class.
 *
 * @return shared instance.
 */
+ (instancetype)sharedInstance;

/**
 * Configures third-party services from application delegate with options.
 *
 * @param application instance from application delegate.
 * @param launchOptions from application delegate.
 */
- (BOOL)didFinishLaunching:(UIApplication *)application withOptions:(NSDictionary *)launchOptions;

/**
 * Configure third-party services from application delegate with url, application
 * that called this provider, and any annotation info.
 *
 * @param application instance from application delegate.
 * @param url called from application delegate.
 * @param sourceApplication that triggered this call.
 * @param annotation from application delegate.
 * @return true if call was handled by this component
 */
- (BOOL)withApplication:(UIApplication *)application
                withURL:(NSURL *)url
  withSourceApplication:(NSString *)sourceApplication
         withAnnotation:(id)annotation;

/**
 * Handles callback from iOS platform indicating push notification registration was a success.
 * @param application application
 * @param deviceToken device token
 */
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;

/**
 * Handles callback from iOS platform indicating push notification registration failed.
 * @param application application
 * @param error error
 */
- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;

/**
 * Handles a received push notification.
 * @param userInfo push notification contents
 */
- (void) application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;

@end