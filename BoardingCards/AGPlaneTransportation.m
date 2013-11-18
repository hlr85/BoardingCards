//
//  AGPlaneTransportation.m
//  BoardingCards
//
//  Created by Hellrider on 5/20/13.
//  Copyright (c) 2013 Andrea Giavatto. All rights reserved.
//

#import "AGPlaneTransportation.h"

@implementation AGPlaneTransportation


- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.flightNumber forKey:@"flight"];
	[encoder encodeObject:self.seatNumber forKey:@"seat"];
	[encoder encodeObject:self.gateNumber forKey:@"gate"];
	[encoder encodeObject:self.notes forKey:@"notes"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    
    if (self) {
        self.flightNumber = [decoder decodeObjectForKey:@"flight"];
		self.seatNumber = [decoder decodeObjectForKey:@"seat"];
		self.gateNumber = [decoder decodeObjectForKey:@"gate"];
		self.notes = [decoder decodeObjectForKey:@"notes"];
    }
    
    return self;
}

- (NSString *)description
{	
    return [NSString stringWithFormat:@"flight: %@, seat: %@, gate: %@, notes: %@", self.flightNumber, self.seatNumber, self.gateNumber, self.notes];
}

@end
