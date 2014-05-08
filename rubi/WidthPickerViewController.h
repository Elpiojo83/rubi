//
//  WidthPickerViewController.h
//  rubi
//
//  Created by David Krachler on 08.05.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PickerViewControllerDelegate;
@interface WidthPickerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>


@property (nonatomic, strong) NSMutableArray* meter;
@property (nonatomic, strong) NSMutableArray* decimeter;
@property (nonatomic, strong) NSMutableArray* centimeter;

@property (nonatomic, strong) NSString *meterOne;
@property (nonatomic, strong) NSString *meterTwo;

@property (weak, nonatomic) IBOutlet UIPickerView *widthPickerView;


@property (assign) id <PickerViewControllerDelegate> delegate;
@property (assign) id sourceControl;
@end


@protocol WidthPickerViewControllerDelegate

-(void) selectedString: (NSString *) value
            forControl: (id) sourceControl
            fromSender: (WidthPickerViewController *) sender;

@end
