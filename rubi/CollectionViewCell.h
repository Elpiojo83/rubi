//
//  CollectionViewCell.h
//  rubi
//
//  Created by David Krachler on 27.03.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CollectionViewCellDelegate;

@interface CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *ProjectTitleLabel;
@property (nonatomic, weak) id<CollectionViewCellDelegate> delegate;

@end
