//
//  SLPickerView.m
//
//  Created by Thor Frølich on 20/07/11.
//  Copyright 2011 Strange Loop. All rights reserved.
//  http://strangeloop.dk
//

#import "SLPickerView.h"


@implementation SLPickerView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIView *hitTestView = [self getNextResponderView:touches withEvent:event];
    [hitTestView touchesBegan:touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIView *hitTestView = [self getNextResponderView:touches withEvent:event];
    [hitTestView touchesMoved:touches withEvent:event];
    [self.superview touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIView *hitTestView = [self getNextResponderView:touches withEvent:event];
    [hitTestView touchesEnded:touches withEvent:event];
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIView *hitTestView = [self getNextResponderView:touches withEvent:event];
    [hitTestView touchesCancelled:touches withEvent:event];
    [super touchesCancelled:touches withEvent:event];
}

- (UIView *)getNextResponderView:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.superview];
    
    UIView *hitView = [super hitTest:point withEvent:event];
    
    // Only proceed unless we have a view in the hierachy beneath self.
    // We'll get an infinite loop if we return self here.
    if ([hitView class] == [SLPickerView class]) {
        return nil;
    }
    
    return hitView;
}

@end
