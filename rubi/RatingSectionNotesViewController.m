//
//  RatingSectionNotesViewController.m
//  rubi
//
//  Created by David Krachler on 13.05.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "RatingSectionNotesViewController.h"
#import "RatingsectionViewController.h"
#import "Project.h"
#import "Ratingsection.h"


@interface RatingSectionNotesViewController ()

@end

@implementation RatingSectionNotesViewController

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
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onKeyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    if(!self.ratingsection.ratingSectionNotes){
        self.ratingSectionNotesTextField.text = [NSString stringWithFormat:@""];
    }else{
        self.ratingSectionNotesTextField.text = [NSString stringWithFormat:@" %@", self.ratingsection.ratingSectionNotes];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)onKeyboardHide:(NSNotification *)notification
{
    //keyboard will hide
    
    self.ratingsection.ratingSectionNotes = self.ratingSectionNotesTextField.text;
    
    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    [delegate saveContext];
    
    NSLog(@"Nnote %@", self.ratingsection.ratingSectionNotes);
    
    NSLog(@"Save Notes");
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
