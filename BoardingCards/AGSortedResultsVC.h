//
//  AGSortedResultsVC.h
//  BoardingCards
//
//  Created by Hellrider on 5/20/13.
//  Copyright (c) 2013 Andrea Giavatto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AGSortedResultsVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *sortedBoardingCards;

@end
