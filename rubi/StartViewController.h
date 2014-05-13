//
//  StartViewController.h
//  rubi
//
//  Created by Markus Kroisenbrunner on 23.04.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface StartViewController : UITableViewController

@property (nonatomic, strong) Street *street;
- (IBAction)exportProjectToServer:(id)sender;

@end
