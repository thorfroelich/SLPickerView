//
//  SLPickerViewController.m
//  SLPicker
//
//  Created by Thor Frølich on 12/08/11.
//  Copyright 2011 Strange Loop. All rights reserved.
//  http://strangeloop.dk
//

#import "SLPickerViewController.h"

@implementation SLPickerViewController

@synthesize pickerView = _pickerView;
@synthesize pickerData = _pickerData;

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    
    if (self)
    {
        touchDidMove = NO;
        
        // Init some dummy data for the picker view
        self.pickerData = [NSArray arrayWithObjects:
                           @"Carcass",
                           @"SYL",
                           @"Parts & Labor",
                           @"Gojira",
                           @"Omega Massif",
                           @"Girl Talk", nil];
    }
    
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set up the custom pickerview
    self.pickerView = [[[SLPickerView alloc] init] autorelease];
    CGRect pickerRect = self.pickerView.frame;
    pickerRect.origin.y = CGRectGetMidY(self.view.frame) - (pickerRect.size.height * 0.5);
    self.pickerView.frame = pickerRect;
    self.pickerView.showsSelectionIndicator = NO;
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.exclusiveTouch = NO;
    
    [self.view addSubview:self.pickerView];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    self.pickerView = nil;
}
                       
#pragma Mark - Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{    
    // Forward touches here if needed
    
    touchDidMove = NO;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Forward touches here if needed
    
    touchDidMove = YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Forward touches here if needed    
    
    // All UIPickerView selection is handled here!
    if (!touchDidMove)
    {
        for (int i = 0; i < [self.pickerView numberOfRowsInComponent:0]; i++)
        {
            UILabel *label = (UILabel *)[self.pickerView viewForRow:i forComponent:0];
            
            // Detect taps in the custom SLPickerView labels
            UITouch * touch = [touches anyObject];
            CGPoint point = [touch locationInView:label];
            if ([label pointInside:point withEvent:event])
            {
                // Move pickerview to tapped row
                [self.pickerView selectRow:i inComponent:0 animated:YES];
                NSLog(@"You chose %@", [self.pickerData objectAtIndex:i]);
            }
        }
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Forward touches here if needed
}

#pragma mark - UIPickerView data source and delegate protocols methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{    
    return [self.pickerData count];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{    
    // Only do something here if you want the entries going past the center to become selected!
    // Click-selection of picker entries is handled in touchesEnded:
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = (UILabel *)view;
    
    if (!label)
    {
        // Customize your label (or any other type UIView) here
        label = [[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.pickerView.bounds.size.width * 0.8, 44.0f)] autorelease];
        label.font = [UIFont systemFontOfSize:26.0];
        label.textAlignment = UITextAlignmentRight;
        label.textColor = [UIColor blackColor];
        label.backgroundColor = [UIColor clearColor];
    }
    
    if (row < [self.pickerData count])
    {
        label.text = (NSString *)[self.pickerData objectAtIndex:row];
    }
    
    return label;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 52.0f;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
