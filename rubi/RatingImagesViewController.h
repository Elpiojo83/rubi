//
//  RatinImagesViewController.h
//  rubi
//
//  Created by David Krachler on 22.04.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//


#import "CoreDataTableViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>




@interface RatingImagesViewController : CoreDataTableViewController  <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITableViewDelegate>{
    NSMutableArray *assets;
}

typedef void (^ALAssetsLibraryAssetForURLResultBlock)(ALAsset *asset);
typedef void (^ALAssetsLibraryAccessFailureBlock)(NSError *error);

@property (nonatomic, strong) Section *section;
@property (nonatomic, strong) RatingImage *ratingimage;
@property (nonatomic, strong) Ratingsection *ratingsection;

@property (strong, atomic) ALAssetsLibrary* Mylibrary;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) UIImage *chosenImage;
@property (nonatomic, strong) NSData *theImage;


- (IBAction)takePictureTouchUpInside:(id)sender;


@end
