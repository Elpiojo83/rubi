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
        //request.predicate = [NSPredicate predicateWithFormat: @" ratingsection == %@" , ratingsection];
        
        
        NSLog(@"Curr. Images: %@", request);
        
        NSLog(@"imaes: %@", self.ratingimage.imagePath);
        
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
    
    NSString* imagetitle = [NSString stringWithFormat:@"%@", image.imagePath];
    
    NSURL* imageUrl = [NSURL URLWithString:image.imagePath];
    
    cell.textLabel.text = imagetitle;
    //cell.imageView.image = [UIImage imageNamed:image.imagePath];
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:image.imagePath]];
    NSLog(@"ImageData %@", imageData);
    cell.imageView.image = [UIImage imageWithData:imageData];
    
    [self.Mylibrary assetForURL:(NSURL *)imageUrl resultBlock:^(ALAsset *asset) {
        NSLog(@"URL %@", imageUrl);
        
        //cell.imageView.image = [UIImage imageWithContentsOfFile:image.imagePath];
        
    } failureBlock:^(NSError *error) {
        NSLog(@"Errror");
    }];
    
    
    //cell.imageView.image = [UIImage imageWithContentsOfFile:@"street.png"];
    
    
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
             [self.ratingsection addRatingimageObject: self.ratingimage];
             
             
             
         }
         
     }];
    
    /*
    NSData *pngData = UIImagePNGRepresentation(image);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"image.png"]; //Add the file name
    [pngData writeToFile:filePath atomically:YES]; //Write the file
    */
    
    
    [picker dismissModalViewControllerAnimated:NO];
}


- (void)assetForURL:(NSURL *)assetURL resultBlock:(ALAssetsLibraryAssetForURLResultBlock)resultBlock failureBlock:(ALAssetsLibraryAccessFailureBlock)failureBlock{
    
}





#pragma mark images from album


-(void)viewDidAppear:(BOOL)animated{
    
    self.Mylibrary = [[ALAssetsLibrary alloc] init];
    
}

@end
