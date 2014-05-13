//
//  SiGeViewController.h
//  rubi
//
//  Created by David Krachler on 13.05.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "RatingsectionSafetyHazard.h"
#import "Project.h"
#import "Ratingsection.h"

@interface SiGeViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate>{
    NSMutableArray *assets;
}

typedef void (^ALAssetsLibraryAssetForURLResultBlock)(ALAsset *asset);
typedef void (^ALAssetsLibraryAccessFailureBlock)(NSError *error);

@property (nonatomic, strong) RatingsectionSafetyHazard *ratingSectionSafetyHazard;
@property (nonatomic, strong) Project *project;
@property (nonatomic, strong) Ratingsection *ratingsection;

@property (strong, atomic) ALAssetsLibrary* Mylibrary;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) IBOutlet UIImageView *SigeImagView;
@property (strong, nonatomic) UIImage *chosenImage;

- (IBAction)takePictureTouchUpInside:(id)sender;

@property (strong, nonatomic) IBOutlet UITextView *HazardNote;

@end
