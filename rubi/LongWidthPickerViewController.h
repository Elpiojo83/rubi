//
//  LongWidthPickerViewController.h
//  rubi
//
//  Created by David Krachler on 28.05.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LongWidthPickerViewControllerDelegate;
@interface LongWidthPickerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) NSMutableArray* tenthousend;
@property (nonatomic, strong) NSMutableArray* thousend;
@property (nonatomic, strong) NSMutableArray* houndred;
@property (nonatomic, strong) NSMutableArray* meter;
@property (nonatomic, strong) NSMutableArray* dekmeter;
@property (nonatomic, strong) NSMutableArray* decimeter;
@property (nonatomic, strong) NSMutableArray* centimeter;


@property (nonatomic, strong) NSString *tenthousendValueFromPicker;
@property (nonatomic, strong) NSString *thousendValueFromPicker;
@property (nonatomic, strong) NSString *houndredValueFromPicker;
@property (nonatomic, strong) NSString *meterValueFromPicker;
@property (nonatomic, strong) NSString *decimeterValueFromPicker;
@property (nonatomic, strong) NSString *centimeterValueFromPicker;
@property (nonatomic, strong) NSString *dekmeterValueFromPicker;

@property (weak, nonatomic) IBOutlet UIPickerView *LongWidthPickerView;


@property (assign) id <LongWidthPickerViewControllerDelegate> delegate;
@property (assign) id sourceControl;
@end


@protocol LongWidthPickerViewControllerDelegate

-(void) selectedString: (NSString *) value
            forControl: (id) sourceControl
            fromSender: (LongWidthPickerViewController *) sender;

@end