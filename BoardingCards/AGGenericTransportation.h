//
//  AGGenericTransportation.h
//  BoardingCards
//
//  Created by Hellrider on 5/20/13.
//  Copyright (c) 2013 Andrea Giavatto. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum AGTransportationType : NSInteger {
	AGTransportationTypeTrain = 0,
	AGTransportationTypeBus,
	AGTransportationTypeCar,
	AGTransportationTypePlane
} AGTransportationType;

@interface AGGenericTransportation : NSObject <NSCoding>

@property (nonatomic, unsafe_unretained) AGTransportationType type;
@property (nonatomic, readonly) NSString *readableType;

@end
