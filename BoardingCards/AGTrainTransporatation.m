//
//  AGTrainTransporatation.m
//  BoardingCards
//
//  Created by Hellrider on 5/20/13.
//  Copyright (c) 2013 Andrea Giavatto. All rights reserved.
//

#import "AGTrainTransporatation.h"

@implementation AGTrainTransporatation

- (void)encodeWithCoder:(NSCoder *)encoder
{
	[encoder encodeObject:self.seatNumber forKey:@"seat"];
	[encoder encodeObject:self.trainNumber forKey:@"train"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    
    if (self) {
		self.seatNumber = [decoder decodeObjectForKey:@"seat"];
		self.trainNumber = [decoder decodeObjectForKey:@"train"];
    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"train: %@, seat: %@", self.trainNumber, self.seatNumber];
}

@end
