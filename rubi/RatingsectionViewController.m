//
//  RatingsectionViewController.m
//  rubi
//
//  Created by David Krachler on 18.04.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import "RatingsectionViewController.h"

@interface RatingsectionViewController ()

@end

@implementation RatingsectionViewController

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
    
    UIColor *streetBg = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"street.png"]];
    self.RatingSectionInterfaceView.backgroundColor = streetBg;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
