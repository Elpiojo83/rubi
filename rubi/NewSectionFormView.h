//
//  NewSectionFormView.h
//  rubi
//
//  Created by David Krachler on 16.04.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewSectionFormView : UIViewController


@property (nonatomic, strong) Project* project;
@property (nonatomic, strong) Section* section;
@property (nonatomic, strong) Street* street;

@property NSManagedObjectContext *parentManagedObjectContext;

@property (weak, nonatomic) IBOutlet UITextField *NewSectionTextField;

@end
