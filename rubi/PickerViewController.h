//
//  PickerViewController.h
//  rubi
//
//  Created by David Krachler on 22.04.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) NSMutableArray* constructionTypes;

@property (nonatomic, strong) NSString *constructiontype;
@property (nonatomic, strong) NSString *typeOfConstruct;

@property (weak, nonatomic) IBOutlet UIPickerView *typeOfConstructionPickerView;

@end
