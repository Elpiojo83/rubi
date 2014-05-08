//
//  WidthPickerViewController.m
//  rubi
//
//  Created by David Krachler on 08.05.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import "WidthPickerViewController.h"
#import "RatingsectionViewController.h"

@interface WidthPickerViewController ()

@end

@implementation WidthPickerViewController

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
    // Do any additional setup after loading the view.
    //self.constructionTypes = [[NSMutableArray alloc] initWithObjects: @"Aspahltbauweise", @"Betonbauweise", @"Spritzdecke", @"Sonstige Bauweise", @"Naturstein", nil];
    
   self.meter = [[NSMutableArray alloc] initWithObjects: @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", nil];
   self.decimeter = [[NSMutableArray alloc] initWithObjects: @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", nil];
   self.centimeter = [[NSMutableArray alloc] initWithObjects: @"0", @"5", nil];
}
/*
-(void)pickerView:(UIPickerView *)typeOfConstructionPickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"select %@", [_constructionTypes objectAtIndex:row]);
    self.typeOfConstruct = [_constructionTypes objectAtIndex:row];
    
    [self.delegate selectedString: self.typeOfConstruct forControl: self.sourceControl fromSender: self];
    
}

*/
-(void)pickerView:(UIPickerView *)WidthPickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"select %@", [_meter objectAtIndex:row]);
    self.meterOne = [_meter objectAtIndex:row];
    
   // [self.delegate selectedString: self.meter forControl: self.sourceControl fromSender: self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark PickerView DataSource
/*
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)typeOfConstructionPickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)widthPickerView numberOfRowsInComponent:(NSInteger)component
{
    //return [_constructionTypes count];
    return 3;
}

- (NSString *)pickerView:(UIPickerView *)widthPickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{

    if(component == 0 ){
        return [_centimeter objectAtIndex:row];
    }
    if(component == 1 ){
        return [_decimeter objectAtIndex:row];
    }
    if(component == 2 ){
        return [_meter objectAtIndex:row];
    }
    return nil;
}
*/
#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 5;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == 0) {
        return [_meter count];
    }
    if( component == 1){
        return [_decimeter count];
    }
    if (component == 2) {
        return 1;
    }
    if( component == 3){
        return [_meter count];
    }
    return [_centimeter count];
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    if (component == 0) {
        return [_meter objectAtIndex:row];
    }
    if (component == 1) {
        return [_decimeter objectAtIndex:row];
    }
    if (component == 2) {
        return @",";
    }
    if (component == 3) {
        return [_meter objectAtIndex:row];
    }
    return [_centimeter objectAtIndex:row];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
