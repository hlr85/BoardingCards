//
//  AGBoardingCard.m
//  BoardingCards
//
//  Created by Hellrider on 5/20/13.
//  Copyright (c) 2013 Andrea Giavatto. All rights reserved.
//

#import "AGBoardingCard.h"

@implementation AGBoardingCard

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p> from: %@ to: %@, via: %@", [self class], self, self.departure, self.destination, self.transportation];
}

@end
