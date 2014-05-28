//
//  DrainagePickerViewController.h
//  rubi
//
//  Created by David Krachler on 28.05.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DrainagePickerViewControllerDelegate;
@interface DrainagePickerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) NSMutableArray* constructionTypes;

@property (nonatomic, strong) NSString *constructiontype;
@property (nonatomic, strong) NSString *typeOfConstruct;

@property (weak, nonatomic) IBOutlet UIPickerView *typeOfConstructionPickerView;


@property (assign) id <DrainagePickerViewControllerDelegate> delegate;
@property (assign) id sourceControl;
@end


@protocol DrainagePickerViewControllerDelegate

-(void) selectedString: (NSString *) value
            forControl: (id) sourceControl
            fromSender: (DrainagePickerViewController *) sender;

@end