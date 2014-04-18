//
//  TeamSelectionTVCell.m
//  rubi
//
//  Created by Markus Kroisenbrunner on 18.04.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import "TeamSelectionTVCell.h"

@interface TeamSelectionTVCell ()

@property (nonatomic, strong) IBOutlet UILabel *vorname;
@property (nonatomic, strong) IBOutlet UILabel *nachname;

@end

@implementation TeamSelectionTVCell


-(void)setEmploye:(Employees *)employe {
    _employe = employe;
    if (employe) {
        self.vorname.text = employe.firstname;
        self.nachname.text = employe.lastname;
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
