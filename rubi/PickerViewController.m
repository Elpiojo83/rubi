//
//  PickerViewController.m
//  rubi
//
//  Created by David Krachler on 22.04.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import "PickerViewController.h"
#import "RatingsectionViewController.h"

@interface PickerViewController ()

@end

@implementation PickerViewController

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
    self.constructionTypes = [[NSMutableArray alloc] initWithObjects: @"Aspahltbauweise", @"Betonbauweise", @"Spritzdecke", @"Sonstige Bauweise", @"Naturstein", nil];

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


#pragma mark - Navigation


/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"backConstruction"]){
        
        
        RatingsectionSafetyHazard *dvc = [segue destinationViewController];
        //dvc.constructiontype = _typeOfConstruct;
        
        //NSLog(@"Segue Section: %@", self.managedObjectContext);
        
    }
    
}
*/



@end
