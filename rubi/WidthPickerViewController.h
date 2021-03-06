//
//  WidthPickerViewController.h
//  rubi
//
//  Created by David Krachler on 08.05.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WidthPickerViewControllerDelegate;
@interface WidthPickerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>


@property (nonatomic, strong) NSMutableArray* meter;
@property (nonatomic, strong) NSMutableArray* dekmeter;
@property (nonatomic, strong) NSMutableArray* decimeter;
@property (nonatomic, strong) NSMutableArray* centimeter;

@property (nonatomic, strong) NSString *meterValueFromPicker;
@property (nonatomic, strong) NSString *decimeterValueFromPicker;
@property (nonatomic, strong) NSString *centimeterValueFromPicker;
@property (nonatomic, strong) NSString *dekmeterValueFromPicker;

@property (weak, nonatomic) IBOutlet UIPickerView *widthPickerView;


@property (assign) id <WidthPickerViewControllerDelegate> delegate;
@property (assign) id sourceControl;
@end


@protocol WidthPickerViewControllerDelegate

-(void) selectedString: (NSString *) value
            forControl: (id) sourceControl
            fromSender: (WidthPickerViewController *) sender;

@end
