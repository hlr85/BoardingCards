//
//  AGBoardingCardsVC.h
//  BoardingCards
//
//  Created by Hellrider on 5/20/13.
//  Copyright (c) 2013 Andrea Giavatto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AGBoardingCardsVC : UIViewController

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIButton *sortButton;

- (IBAction)sortBoardingCards:(id)sender;

@end
