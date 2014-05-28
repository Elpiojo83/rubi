//
//  LongWidthPickerViewController.m
//  rubi
//
//  Created by David Krachler on 28.05.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import "LongWidthPickerViewController.h"
#import "RatingsectionViewController.h"


@interface LongWidthPickerViewController ()

@end

@implementation LongWidthPickerViewController

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
    
    self.tenthousend = [[NSMutableArray alloc] initWithObjects: @"0",@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", nil];
    self.thousend = [[NSMutableArray alloc] initWithObjects: @"0",@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", nil];
    self.houndred = [[NSMutableArray alloc] initWithObjects: @"0",@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", nil];
    self.meter = [[NSMutableArray alloc] initWithObjects: @"0",@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", nil];
    self.dekmeter = [[NSMutableArray alloc] initWithObjects: @"0",@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", nil];
    self.decimeter = [[NSMutableArray alloc] initWithObjects:@"0",@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", nil];
    self.centimeter = [[NSMutableArray alloc] initWithObjects: @"0", @"5", nil];
    
    
    
}



-(void)pickerView:(UIPickerView *)LongWidthPickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if(component == 0){
        self.tenthousendValueFromPicker = [NSString stringWithFormat:@"%@", [_tenthousend objectAtIndex:row]];
        NSLog(@"0 Kilometer %@", _tenthousendValueFromPicker);
    }
              
    if(component == 1){
        self.thousendValueFromPicker = [NSString stringWithFormat:@"%@", [_thousend objectAtIndex:row]];
        NSLog(@"Kilometer %@", _thousendValueFromPicker);
    }
    
    if(component == 2){
        self.houndredValueFromPicker= [NSString stringWithFormat:@"%@", [_dekmeter objectAtIndex:row]];
        NSLog(@"Meter %@", _houndredValueFromPicker);
    }
    
    if(component == 3){
        self.dekmeterValueFromPicker= [NSString stringWithFormat:@"%@", [_dekmeter objectAtIndex:row]];
        NSLog(@"Meter %@", _dekmeterValueFromPicker);
    }
    if(component == 4){
        
        self.meterValueFromPicker= [NSString stringWithFormat:@"%@", [_meter objectAtIndex:row]];
        NSLog(@"Meter %@",_meterValueFromPicker);
        
    }
    if(component == 6){
        
        self.decimeterValueFromPicker= [NSString stringWithFormat:@"%@", [_decimeter objectAtIndex:row]];
        NSLog(@"Meter dec %@", _decimeterValueFromPicker);
        
    }
    
    if(component == 7){
        
        self.centimeterValueFromPicker= [NSString stringWithFormat:@"%@", [_centimeter objectAtIndex:row]];
        NSLog(@"Meter dec %@", _centimeterValueFromPicker);
        
    }
    
    if(_decimeterValueFromPicker == nil){
        self.decimeterValueFromPicker = @"";
    }

    if(_meterValueFromPicker == nil){
        self.meterValueFromPicker = @"";
    }

    if(_centimeterValueFromPicker == nil){
        self.centimeterValueFromPicker = @"";
    }

    if(_dekmeterValueFromPicker == nil){
        self.dekmeterValueFromPicker = @"";
    }

    if(_houndredValueFromPicker == nil ){
        self.houndredValueFromPicker = @"";
    }

    if(_tenthousendValueFromPicker == nil || [_tenthousendValueFromPicker isEqualToString:@"0"]){
        self.tenthousendValueFromPicker = @"";
    }

    if(_thousendValueFromPicker == nil){
        self.thousendValueFromPicker = @"";
    }

    
    
    
    [self.delegate selectedString: [NSString stringWithFormat: @"%@%@%@%@%@,%@%@",_tenthousendValueFromPicker, _thousendValueFromPicker, _houndredValueFromPicker, _dekmeterValueFromPicker, _meterValueFromPicker, _decimeterValueFromPicker, _centimeterValueFromPicker] forControl: self.sourceControl fromSender: self];
    
    NSLog(@"delegate meter %@%@%@%@%@,%@%@",_tenthousendValueFromPicker, _thousendValueFromPicker,_houndredValueFromPicker, _dekmeterValueFromPicker, _meterValueFromPicker, _decimeterValueFromPicker, _centimeterValueFromPicker);
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 8;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == 0) {
        return [_tenthousend count];
    }
    if (component == 1) {
        return [_thousend count];
    }
    if (component == 2) {
        return [_houndred count];
    }
    if (component == 3) {
        return [_meter count];
    }
    if( component == 4){
        return [_decimeter count];
    }
    if (component == 5) {
        return 1;
    }
    if( component == 6){
        return [_dekmeter count];
    }
    return [_centimeter count];
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    if (component == 0) {
        return [_tenthousend objectAtIndex:row];
    }
    if (component == 1) {
        return [_thousend objectAtIndex:row];
    }
    if (component == 2) {
        return [_houndred objectAtIndex:row];
    }
    if (component == 3) {
        return [_meter objectAtIndex:row];
    }
    if (component == 4) {
        return [_decimeter objectAtIndex:row];
    }
    if (component == 5) {
        return @",";
    }
    if (component == 6) {
        return [_dekmeter objectAtIndex:row];
    }
    return [_centimeter objectAtIndex:row];
    
    
}



@end
