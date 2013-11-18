//
//  AGTrainTransporatation.h
//  BoardingCards
//
//  Created by Hellrider on 5/20/13.
//  Copyright (c) 2013 Andrea Giavatto. All rights reserved.
//

#import "AGGenericTransportation.h"

@interface AGTrainTransporatation : AGGenericTransportation <NSCoding>

@property (nonatomic, strong) NSString *trainNumber;
@property (nonatomic, strong) NSString *seatNumber;

//- (id)initWitDictionary:(NSDictionary *)inDictionary;

@end
