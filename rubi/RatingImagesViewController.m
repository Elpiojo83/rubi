//
//  RatinImagesViewController.m
//  rubi
//
//  Created by David Krachler on 22.04.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import "RatingImagesViewController.h"
#import "RatingImage.h"
#import "Ratingsection.h"



@interface RatingImagesViewController ()

@end

@implementation RatingImagesViewController


-(void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    
    _managedObjectContext = managedObjectContext;
    if (managedObjectContext) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"RatingImage"];
        request.sortDescriptors = @[[ NSSortDescriptor  sortDescriptorWithKey: @"imagePath" ascending:YES ]];
        request.predicate = [NSPredicate predicateWithFormat: @" ratingsection == %@" , self.ratingsection];
        
        
    //    NSLog(@"Curr. Images: %@", request);
        
      //  NSLog(@"images: %@", self.ratingimage.imagePath);
        
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest: request managedObjectContext:managedObjectContext sectionNameKeyPath: nil cacheName: nil];
        
        
    }
    else {
        self.fetchedResultsController = nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ImageCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    RatingImage *image = [[self.ratingsection.ratingimage allObjects] objectAtIndex:indexPath.row];
    
    //NSString* imagetitle = [NSString stringWithFormat:@"%@", image.imagePath];
    
    NSURL* imageUrl = [NSURL URLWithString:image.imagePath];
    
    //cell.textLabel.text = imagetitle;

    
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        //ALAssetRepresentation *rep = [myasset defaultRepresentation];
        //CGImageRef iref = [rep fullScreenImage];
        if (myasset != NULL) {
            UIImage *largeimage = [UIImage imageWithCGImage:[myasset thumbnail]];
                cell.imageView.frame = CGRectMake(15, 0, 44, 44);
                [cell.imageView setImage:largeimage];
         //   NSLog(@"LARGEIMAGE: %@", largeimage);
        }
    };
    
    ALAssetsLibraryAccessFailureBlock failureblock  = ^(NSError *myerror)
    {
        NSLog(@"Can't get image - %@",[myerror localizedDescription]);
    };
    
     
     ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init] ;
     [assetslibrary assetForURL:imageUrl
                    resultBlock:resultblock
                   failureBlock:failureblock];
    
    
    return cell;
    
}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    
}


- (IBAction)takePictureTouchUpInside:(id)sender {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;


    [self presentViewController:imagePicker animated:YES completion:nil];
    
}


#pragma mark Image picker delegate methdos

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
 
    
    [self.Mylibrary writeImageToSavedPhotosAlbum: image.CGImage metadata:nil completionBlock:^(NSURL *assetURL, NSError *error2)
     {
         //             report_memory(@"After writing to library");
         if (error2) {
             NSLog(@"ERROR: the image failed to be written");
         }
         else {
             NSLog(@"PHOTO SAVED - assetURL: %@", assetURL);
             self.ratingimage = [NSEntityDescription insertNewObjectForEntityForName:@"RatingImage" inManagedObjectContext: self.managedObjectContext];
             
             self.ratingimage.imagePath = [NSString stringWithFormat:@"%@", assetURL];
             
             self.ratingimage.deviceID = uniqueDeviceID;
             
             
             
 
            // self.chosenImage = editingInfo[UIImagePickerControllerOriginalImage];
             
             self.chosenImage = image;
             
             int randX = arc4random() % 9999;
             
             //NSData *data = UIImagePNGRepresentation(self.chosenImage);
             
             NSData *data = UIImageJPEGRepresentation(self.chosenImage, 0.7);
             
             NSString *myNewImage = [NSString stringWithFormat:@"image-%i.jpeg", randX, nil];
             
             NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
             NSString *documentDirectory = [path objectAtIndex:0];
             
             
             NSString *fullPathToFile = [documentDirectory stringByAppendingPathComponent:myNewImage];
             [data writeToFile:fullPathToFile atomically:YES];
             
             
             
             self.ratingimage.imagePathFilesystem = fullPathToFile;
             self.ratingimage.filename = myNewImage;
             
             
             
              
             [self.ratingsection addRatingimageObject: self.ratingimage];
             
             
             
         }
         
     }];
    
    
    
    
    
    
    
    [picker dismissModalViewControllerAnimated:NO];
}



/*

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info didFinishPickingImage:(UIImage *)image{
    
    
    [self.Mylibrary writeImageToSavedPhotosAlbum: image.CGImage metadata:nil completionBlock:^(NSURL *assetURL, NSError *error2)
     {
         //             report_memory(@"After writing to library");
         if (error2) {
             NSLog(@"ERROR: the image failed to be written");
         }
         else {
             NSLog(@"PHOTO SAVED - assetURL: %@", assetURL);
             self.ratingimage = [NSEntityDescription insertNewObjectForEntityForName:@"RatingImage" inManagedObjectContext: self.managedObjectContext];
             
             self.ratingimage.imagePath = [NSString stringWithFormat:@"%@", assetURL];
             
             self.ratingimage.deviceID = uniqueDeviceID;
             
             self.chosenImage = info[UIImagePickerControllerOriginalImage];
             
             int randX = arc4random() % 9999;
             
             NSData *data = UIImagePNGRepresentation(self.chosenImage);
             
             NSString *myGrabbedImage = [NSString stringWithFormat:@"image-%i.png",randX, nil];// @"SiGe.png";
             
             
             
             NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
             NSString *documentDirectory = [path objectAtIndex:0];
             
             
             [self dismissViewControllerAnimated:YES completion:nil];
             NSString *fullPathToFile = [documentDirectory stringByAppendingPathComponent:myGrabbedImage];
             [data writeToFile:fullPathToFile atomically:YES];
             
             
             if(!self.ratingimage){
                 //  self.ratingsectionsafetyhazard = [NSEntityDescription insertNewObjectForEntityForName:@"RatingsectionSafetyHazard" inManagedObjectContext: self.managedObjectContext];
                 
                 // [self.ratingsection addHazardsObject:self.ratingsectionsafetyhazard];
                 
             }
             
             
             self.ratingimage.imagePathFilesystem = [NSString stringWithFormat:@"%@", fullPathToFile];
             
             
             
             //self.ratingsectionsafetyhazard.safetyHazardNote = [NSString stringWithFormat:@"%@", self.HazardNote.text];
             
             
             
             NSLog(@"Path: %@", self.ratingimage);
             
             
             
             
             [self.ratingsection addRatingimageObject: self.ratingimage];
             
         //    [picker dismissModalViewControllerAnimated:NO];
             
             
         }
         
     }];
    
    
    
}
*/


- (void)assetForURL:(NSURL *)assetURL resultBlock:(ALAssetsLibraryAssetForURLResultBlock)resultBlock failureBlock:(ALAssetsLibraryAccessFailureBlock)failureBlock{
    
}





#pragma mark images from album


-(void)viewDidAppear:(BOOL)animated{
    
    self.Mylibrary = [[ALAssetsLibrary alloc] init];
    
    
    
    
}

@end
