//
//  Weather.h
//  Thermostat
//
//  Created by Ryan on 6/19/16.
//  Copyright © 2016 Ryan Cortez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Weather : NSObject

@property CLLocation *location;
@property NSNumber *temperature;

- (instancetype) initWithTemperature: (NSNumber *) temperature;

@end
