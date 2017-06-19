//
//  AWSConfiguration.m
//  MySampleApp
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

#import "AWSConfiguration.h"
// This ServiceKey variable is used to determine which configuration to use.
// If it is a release build, it will use the Prod platform configuration.
// If it's not (debug build), it will default to the Devo (Sandbox) platform configuration.

#if RELEASE
NSString *const ServiceKey = @"Prod";
#else
NSString *const ServiceKey = @"Devo";
#endif


