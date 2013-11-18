//
//  AGBoardingCard.h
//  BoardingCards
//
//  Created by Hellrider on 5/20/13.
//  Copyright (c) 2013 Andrea Giavatto. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AGGenericTransportation.h"

@interface AGBoardingCard : NSObject

@property (nonatomic, strong) AGGenericTransportation *transportation;
@property (nonatomic, strong) NSString *departure;
@property (nonatomic, strong) NSString *destination;
@property (nonatomic, strong) NSString *notes;

@end
