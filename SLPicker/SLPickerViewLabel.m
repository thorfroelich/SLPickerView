//
//  SLPickerViewLabel.m
//  SLPicker
//
//  Created by Thor Frølich on 12/08/11.
//  Copyright 2011 Strange Loop. All rights reserved.
//

#import "SLPickerViewLabel.h"

@implementation SLPickerViewLabel

@synthesize checkMarkView;
@synthesize label;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UIImage *check = [UIImage imageNamed:@"check.png"];
        self.checkMarkView = [[UIImageView alloc] initWithImage:check];
        self.checkMarkView.hidden = YES;
        self.checkMarkView.center = self.center;
        
        CGRect rect;
        
        rect = self.checkMarkView.frame;
        rect.origin.x = 10.0;
        self.checkMarkView.frame = rect;
        
        self.label = [[UILabel alloc] initWithFrame:self.frame];
        self.label.backgroundColor = [UIColor clearColor];
        self.label.font = [UIFont systemFontOfSize:26.0];
        
        rect = self.label.frame;
        rect.origin.x = 50.0;
        self.label.frame = rect;
        
        [self addSubview:self.checkMarkView];
        [self addSubview:self.label];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


@end
