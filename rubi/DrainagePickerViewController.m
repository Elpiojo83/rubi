//
//  DrainagePickerViewController.m
//  rubi
//
//  Created by David Krachler on 28.05.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//


#import "DrainagePickerViewController.h"
#import "RatingsectionViewController.h"

@interface DrainagePickerViewController ()

@end

@implementation DrainagePickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.constructionTypes = [[NSMutableArray alloc] initWithObjects: @"Bankett", @"PVC", @"Beton", @"Sonstige Bauweise", nil];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pickerView:(UIPickerView *)typeOfConstructionPickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"select %@", [_constructionTypes objectAtIndex:row]);
    self.typeOfConstruct = [_constructionTypes objectAtIndex:row];
    
    [self.delegate selectedString: self.typeOfConstruct forControl: self.sourceControl fromSender: self];
    
}

#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)typeOfConstructionPickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)typeOfConstructionPickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_constructionTypes count];
}

- (NSString *)pickerView:(UIPickerView *)typeOfConstructionPickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_constructionTypes objectAtIndex:row];
}



@end