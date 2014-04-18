    //
//  TeamToProjectCVCell.m
//  rubi
//
//  Created by Markus Kroisenbrunner on 18.04.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import "TeamToProjectCVCell.h"

@interface TeamToProjectCVCell ()

@property (weak, nonatomic) IBOutlet UILabel *vorname;
@property (weak, nonatomic) IBOutlet UILabel *nachname;

@end


@implementation TeamToProjectCVCell

-(void)setEmployee:(Employees *)employee  {
    _employee = employee;
    if (employee) {
        _vorname.text = employee.firstname;
        _nachname.text = employee.lastname;
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
