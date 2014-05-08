//
//  ProjectLocationViewController.h
//  rubi
//
//  Created by David Krachler on 08.05.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ProjectLocationViewController : UIViewController <CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end
