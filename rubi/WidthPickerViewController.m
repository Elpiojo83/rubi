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

    
    self.meter = [[NSMutableArray alloc] initWithObjects: @"0",@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", nil];
    self.dekmeter = [[NSMutableArray alloc] initWithObjects: @"0",@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", nil];
    self.decimeter = [[NSMutableArray alloc] initWithObjects:@"0",@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", nil];
    self.centimeter = [[NSMutableArray alloc] initWithObjects: @"0", @"5", nil];
    
    
    
}



-(void)pickerView:(UIPickerView *)WidthPickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    



    
    if(component == 0){
        self.dekmeterValueFromPicker= [NSString stringWithFormat:@"%@", [_dekmeter objectAtIndex:row]];
        NSLog(@"Meter %@", _dekmeterValueFromPicker);
    }
    if(component == 1){

        self.meterValueFromPicker= [NSString stringWithFormat:@"%@", [_meter objectAtIndex:row]];
        NSLog(@"Meter %@",_meterValueFromPicker);
        
    }
    if(component == 3){
        
        self.decimeterValueFromPicker= [NSString stringWithFormat:@"%@", [_decimeter objectAtIndex:row]];
        NSLog(@"Meter dec %@", _decimeterValueFromPicker);
        
    }
    
    if(component == 4){
        
        self.centimeterValueFromPicker= [NSString stringWithFormat:@"%@", [_centimeter objectAtIndex:row]];
        NSLog(@"Meter dec %@", _centimeterValueFromPicker);
        
    }
    
    if(_decimeterValueFromPicker == nil){
        self.decimeterValueFromPicker = @"0";
    }
    if(_meterValueFromPicker == nil){
        self.meterValueFromPicker = @"0";
    }
    if(_centimeterValueFromPicker == nil || [_centimeterValueFromPicker isEqualToString:@"0"]){
        self.centimeterValueFromPicker = @"0";
    }
    if(_dekmeterValueFromPicker == nil || [_dekmeterValueFromPicker isEqualToString:@"0"]){
        self.dekmeterValueFromPicker = @"";
    }
    
    [self.delegate selectedString: [NSString stringWithFormat: @"%@%@,%@%@", _dekmeterValueFromPicker, _meterValueFromPicker, _decimeterValueFromPicker, _centimeterValueFromPicker]
                       forControl: self.sourceControl fromSender: self];
    NSLog(@"delegate meter %@%@,%@%@",_dekmeterValueFromPicker, _meterValueFromPicker, _decimeterValueFromPicker, _centimeterValueFromPicker);
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



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
        return [_dekmeter count];
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
        return [_dekmeter objectAtIndex:row];
    }
    return [_centimeter objectAtIndex:row];
    

}



@end
