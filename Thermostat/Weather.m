//
//  Weather.m
//  Thermostat
//
//  Created by Ryan on 6/19/16.
//  Copyright © 2016 Ryan Cortez. All rights reserved.
//

#import "Weather.h"

@implementation Weather

- (instancetype) initWithTemperature: (NSNumber *) temperature {
    self = [super init];
    
    self.temperature = temperature;
    
    return self;
}

@end
