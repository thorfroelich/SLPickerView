//
//  SLPickerViewController.m
//  SLPicker
//
//  Created by Thor Frølich on 12/08/11.
//  Copyright 2011 Strange Loop. All rights reserved.
//  http://strangeloop.dk
//

#import "SLPickerViewController.h"
#import "SLPickerViewLabel.h"

@implementation SLPickerViewController

@synthesize pickerView = _pickerView;
@synthesize pickerData = _pickerData;

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    
    if (self)
    {
        currentPick = -1;
        
        // Init some dummy data for the picker view
        self.pickerData = [NSArray arrayWithObjects:
                           @"Carcass",
                           @"SYL",
                           @"Parts & Labor",
                           @"Gojira",
                           @"Omega Massif",
                           @"Girl Talk",
                           @"Movits",
                           nil];
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
    
    // Add a gesture recognizer to detect taps in pickerview
    UITapGestureRecognizer *singleTap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInPickerView:)] autorelease];
    [singleTap setNumberOfTapsRequired:1];
    [singleTap setNumberOfTouchesRequired:1];
    [self.pickerView addGestureRecognizer:singleTap];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    self.pickerView = nil;
}

- (void)tapInPickerView:(UIGestureRecognizer *)sender
{    
    for (int i = 0; i < [self.pickerView numberOfRowsInComponent:0]; i++)
    {
        SLPickerViewLabel *label = (SLPickerViewLabel *)[self.pickerView viewForRow:i forComponent:0];
        
        // Is tap contained in the label?
        CGPoint point = [sender locationInView:label];
        if (CGRectContainsPoint(label.frame, point))
        {
            // Move pickerview to tapped row
            [self.pickerView selectRow:i inComponent:0 animated:YES];
            NSLog(@"You chose %@", [self.pickerData objectAtIndex:i]);
            currentPick = i;
            label.checkMarkView.hidden = NO;
        }
        else
        {
            label.checkMarkView.hidden = YES;
        }
    }
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
    SLPickerViewLabel *label = (SLPickerViewLabel *)view;
    
    if (!label)
    {
        // Customize your label (or any other type UIView) here
        label = [[[SLPickerViewLabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.pickerView.bounds.size.width * 0.8, 44.0f)] autorelease];
    }
    
    if (row < [self.pickerData count])
    {
        label.label.text = (NSString *)[self.pickerData objectAtIndex:row];
        label.checkMarkView.hidden = !(row == currentPick);
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
