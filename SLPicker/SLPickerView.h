//
//  SLPickerView.h
//
//  Created by Thor Frølich on 20/07/11.
//  Copyright 2011 Strange Loop. All rights reserved.
//  http://strangeloop.dk
//
// This UIPickerView subclass allows touch events that would otherwise 
// get trapped by the picker to be forwarded to the picker's superview
//
// It is useful for creating a pickerview that only makes a selection when
// the user taps an entry and not when an entry scrolls past the
// center indicator area, which is the default UIPickerView behaviour.

#import <UIKit/UIKit.h>


@interface SLPickerView : UIPickerView

- (UIView *)getNextResponderView:(NSSet *)touches withEvent:(UIEvent *)event;

@end
