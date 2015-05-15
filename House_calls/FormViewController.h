//
//  FormViewController.h
//  House_calls
//
//  Created by Timothy Acorda on 1/26/15.
//  Copyright (c) 2015 Timothy Acorda. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

#import "Doctors.h"
@interface FormViewController : UIViewController <CLLocationManagerDelegate , MKMapViewDelegate, NSURLConnectionDelegate, UIScrollViewDelegate>
@property Doctors* doc;
@property CLLocationManager *locationManager;
@end
