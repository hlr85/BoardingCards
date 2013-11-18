//
//  AGPlaneTransportation.h
//  BoardingCards
//
//  Created by Hellrider on 5/20/13.
//  Copyright (c) 2013 Andrea Giavatto. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AGGenericTransportation.h"

@interface AGPlaneTransportation : AGGenericTransportation <NSCoding>

@property (nonatomic, strong) NSString *flightNumber;
@property (nonatomic, strong) NSString *seatNumber;
@property (nonatomic, strong) NSString *gateNumber;
@property (nonatomic, strong) NSString *notes;

@end
