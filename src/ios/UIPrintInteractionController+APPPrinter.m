/*
 Copyright 2013 appPlant GmbH

 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIPrintInteractionController+APPPrinter.h"
#import "APPPrinterInfo.h"
#import <objc/runtime.h>

static char SETTINGS_KEY;

@implementation UIPrintInteractionController (APPPrinter)

@dynamic settings;

+ (instancetype)sharedPrintControllerWithSettings:(NSDictionary *)settings
{
    UIPrintInteractionController *ctrl =
        [UIPrintInteractionController sharedPrintController];

    ctrl.printInfo = [APPPrinterInfo printInfoWithDictionary:settings];
    ctrl.settings  = settings;

    return ctrl;
}

- (void)setSettings:(NSDictionary *)settings
{
    objc_setAssociatedObject(
        self,
        &SETTINGS_KEY,
        settings,
        OBJC_ASSOCIATION_RETAIN_NONATOMIC
    );
}

- (NSDictionary *)settings
{
    return objc_getAssociatedObject(self, &SETTINGS_KEY);
}

@end

