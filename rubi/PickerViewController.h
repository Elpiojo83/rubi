//
//  PickerViewController.h
//  rubi
//
//  Created by David Krachler on 22.04.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PickerViewControllerDelegate;
@interface PickerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) NSMutableArray* constructionTypes;

@property (nonatomic, strong) NSString *constructiontype;
@property (nonatomic, strong) NSString *typeOfConstruct;

@property (weak, nonatomic) IBOutlet UIPickerView *typeOfConstructionPickerView;


@property (assign) id <PickerViewControllerDelegate> delegate;
@property (assign) id sourceControl;
@end


@protocol PickerViewControllerDelegate

-(void) selectedString: (NSString *) value
            forControl: (id) sourceControl
            fromSender: (PickerViewController *) sender;

@end