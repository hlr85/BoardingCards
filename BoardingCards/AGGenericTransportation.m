//
//  AGGenericTransportation.m
//  BoardingCards
//
//  Created by Hellrider on 5/20/13.
//  Copyright (c) 2013 Andrea Giavatto. All rights reserved.
//

#import "AGGenericTransportation.h"

@implementation AGGenericTransportation

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:[NSNumber numberWithInteger:self.type] forKey:@"type"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    
    if (self) {
		NSNumber *numberType = [decoder decodeObjectForKey:@"type"];
        self.type = numberType.integerValue;
    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Transportation type: %@", self.readableType];
}

- (NSString *)readableType
{
	NSString *type;
	switch (_type) {
		case AGTransportationTypeBus:
			type = @"Bus";
			break;
			
		case AGTransportationTypePlane:
			type = @"Plane";
			break;
			
		case AGTransportationTypeTrain:
			type = @"Train";
			break;
			
		case AGTransportationTypeCar:
			type = @"Car";
			break;
			
		default:
			type = @"Unrecognized transportation type";
			break;
	}
	
	return type;
}

@end
