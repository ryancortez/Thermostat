//
//  WeatherForecastHandler.h
//  Thermostat
//
//  Created by Ryan on 6/19/16.
//  Copyright © 2016 Ryan Cortez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weather.h"
#import "JSONHandler.h"

@interface WeatherForecastHandler : JSONHandler

- (Weather *) parseJSONForCurrentWeather: (NSDictionary *) json;
- (NSURL *) weatherForecastAPICallFromLocation: (CLLocation *) location;

@end
