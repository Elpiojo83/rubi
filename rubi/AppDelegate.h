//
//  AppDelegate.h
//  rubi
//
//  Created by David Krachler on 27.03.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#define uniqueDeviceID @"TG7e636edf28ac3fb4a23087fsdefc129dbe54313cb5758DavidsIpad2"

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) CLLocationManager *locationManager;


- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
