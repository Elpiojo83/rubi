//
//  StartViewController.h
//  rubi
//
//  Created by Markus Kroisenbrunner on 23.04.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "MBProgressHUD.h"

@interface StartViewController : UITableViewController <MBProgressHUDDelegate> {
	MBProgressHUD *HUD;
    
	long long expectedLength;
	long long currentLength;
}


@property (nonatomic, strong) Street *street;
- (IBAction)exportProjectToServer:(id)sender;

@end
