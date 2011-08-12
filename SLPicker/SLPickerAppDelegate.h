//
//  SLPickerAppDelegate.h
//  SLPicker
//
//  Created by Thor Frølich on 12/08/11.
//  Copyright 2011 Strange Loop. All rights reserved.
//  http://strangeloop.dk
//

#import <UIKit/UIKit.h>

@class SLPickerViewController;

@interface SLPickerAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet SLPickerViewController *viewController;

@end
