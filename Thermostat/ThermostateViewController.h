//
//  ViewController.h
//  Thermostat
//
//  Created by Ryan Cortez on 6/16/16.
//  Copyright © 2016 Ryan Cortez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Weather.h"

@interface ThermostateViewController : UIViewController <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;

@end

