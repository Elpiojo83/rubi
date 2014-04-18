//
//  TeamTVCell.m
//  rubi
//
//  Created by Markus Kroisenbrunner on 18.04.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import "TeamTVCell.h"

@interface TeamTVCell () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *vorname;
@property (weak, nonatomic) IBOutlet UITextField *nachname;


@end

@implementation TeamTVCell

-(void)setEmploye:(Employees *)employe {
    _employe = employe;
    if (employe) {
        self.vorname.text = employe.firstname;
        self.nachname.text = employe.lastname;
        self.vorname.delegate = self;
        self.nachname.delegate = self;
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    if ([textField isEqual: self.vorname]) {
        self.employe.firstname = textField.text;
    }
    else    if ([textField isEqual: self.nachname]) {
        self.employe.lastname = textField.text;
    }
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
