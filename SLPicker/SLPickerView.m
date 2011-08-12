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
    [hitTestView touchesBegan:touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [hitTestView touchesMoved:touches withEvent:event];
    [self.superview touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [hitTestView touchesEnded:touches withEvent:event];
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [hitTestView touchesCancelled:touches withEvent:event];
    [super touchesCancelled:touches withEvent:event];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{    
    // Here we find the internal responder to touches
    if (CGRectContainsPoint(self.bounds, point))
    {
        if (hitTestView == nil)
        {
            UIView *hit = [super hitTest:point withEvent:event];
            
            // Make sure we don't get self lest we create an infinite loop
            if ([hit class] != [SLPickerView class])
            {
                hitTestView = hit;
            }
        }
    }
    
    return self;
}

@end
