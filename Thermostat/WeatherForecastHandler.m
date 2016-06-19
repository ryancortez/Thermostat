//
//  WeatherForecastHandler
//  Thermostat
//
//  Created by Ryan on 6/19/16.
//  Copyright © 2016 Ryan Cortez. All rights reserved.
//

#import "WeatherForecastHandler.h"


@implementation WeatherForecastHandler

- (NSURL *)getForecastAPIURL {
    
    return [[NSURL alloc]initWithString: @"https://api.forecast.io/forecast/ee590865b8cf07d544c96463ae5d47c5/"];
}

- (Weather *) parseJSONForCurrentWeather: (NSDictionary *) json {
    
    NSNumber *currentTemperature = (NSNumber *) json[@"currently"][@"temperature"];
    NSString *string = [NSString stringWithFormat:@"%@", currentTemperature.stringValue];
    NSLog(@"Current temperature outside pulled from Forecast.io : %@", string);
    
    Weather *currentWeather = [[Weather alloc]initWithTemperature:currentTemperature];
    return currentWeather;
}

- (NSURL *) weatherForecastAPICallFromLocation: (CLLocation *) location {
    NSURL *url = [[NSURL alloc]initWithString: [NSString stringWithFormat:@"%@%f,%f", [self getForecastAPIURL], location.coordinate.latitude, location.coordinate.longitude]];
    NSLog(@"%@", url.absoluteString);
    return url;
}

@end
