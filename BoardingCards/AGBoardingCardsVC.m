//
//  AGBoardingCardsVC.m
//  BoardingCards
//
//  Created by Hellrider on 5/20/13.
//  Copyright (c) 2013 Andrea Giavatto. All rights reserved.
//

#import "AGBoardingCardsVC.h"

#import "AGSortedResultsVC.h"

#import "AGBoardingCard.h"
#import "AGPlaneTransportation.h"
#import "AGTrainTransporatation.h"

@interface AGBoardingCardsVC () <UITableViewDelegate, UITableViewDataSource> {
	// -- Queue used to sort the boarding cards
	NSOperationQueue *_sortingQueue;
	
	NSMutableArray *_unsortedBoardingCards;
	NSArray *_sortedBoardingCards;
	NSMutableDictionary *_cardsByDeparture;	
}

@end

@implementation AGBoardingCardsVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		_sortingQueue = [[NSOperationQueue alloc] init];
		_sortingQueue.maxConcurrentOperationCount = kMaxConcurrentSortingAlgorithms;
		
		_unsortedBoardingCards = [NSMutableArray array];
		_cardsByDeparture = [NSMutableDictionary dictionary];		
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	self.title = @"WAM Code Test";
	
	AGBoardingCard *girLon = [[AGBoardingCard alloc] init];
	girLon.departure = @"Girona";
	girLon.destination = @"London";
	AGPlaneTransportation *plane1 = [[AGPlaneTransportation alloc] init];
	plane1.type = AGTransportationTypePlane;
	plane1.flightNumber = @"SK455";
	plane1.seatNumber = @"Seat 3A";
	plane1.gateNumber = @"Gate 45B";
	plane1.notes = @"Baggage drop at ticket counter 344.";
	girLon.transportation = plane1;
	[_unsortedBoardingCards addObject:girLon];
	
	AGBoardingCard *madBar = [[AGBoardingCard alloc] init];
	madBar.departure = @"Madrid";
	madBar.destination = @"Barcelona";
	AGTrainTransporatation *train = [[AGTrainTransporatation alloc] init];
	train.type = AGTransportationTypeTrain;
	train.trainNumber = @"78A";
	train.seatNumber = @"45B";
	madBar.transportation = train;
	[_unsortedBoardingCards addObject:madBar];
	
	AGBoardingCard *lonnyc = [[AGBoardingCard alloc] init];
	lonnyc.departure = @"London";
	lonnyc.destination = @"New York City";
	AGPlaneTransportation *plane2 = [[AGPlaneTransportation alloc] init];
	plane2.type = AGTransportationTypePlane;
	plane2.flightNumber = @"SK22";
	plane2.seatNumber = @"Seat 7B";
	plane2.gateNumber = @"Gate 22";
	plane2.notes = @"Baggage will be automatically transferred from your last leg.";
	lonnyc.transportation = plane2;
	[_unsortedBoardingCards addObject:lonnyc];
	
	AGBoardingCard *barGir = [[AGBoardingCard alloc] init];
	barGir.departure = @"Barcelona";
	barGir.destination = @"Girona";
	AGGenericTransportation *bus = [[AGGenericTransportation alloc] init];
	bus.type = AGTransportationTypeBus;
	barGir.transportation = bus;
	[_unsortedBoardingCards addObject:barGir];

	for (AGBoardingCard *bc in _unsortedBoardingCards) {
		[_cardsByDeparture setObject:bc forKey:bc.departure];
	}
	
	//DLog(@"%@", _cardsByDeparture);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _unsortedBoardingCards.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return @"Unsorted Boarding Cards:";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"BoardingCardCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
	AGBoardingCard *bc = [_unsortedBoardingCards objectAtIndex:indexPath.row];
	
    cell.textLabel.text = bc.transportation.readableType;
	cell.detailTextLabel.text = [NSString stringWithFormat:@"From: %@ to: %@", bc.departure, bc.destination];
    
    return cell;
}


#pragma mark - Helper methods

- (IBAction)sortBoardingCards:(id)sender
{
	//NSInvocationOperation *doneOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(finishedAllOperations:) object:nil];
	
	for (AGBoardingCard *bc in _unsortedBoardingCards) {
		__weak typeof(_sortingQueue) weakQueue = _sortingQueue;
		NSBlockOperation *sortOperation = [NSBlockOperation blockOperationWithBlock:^(){
			NSArray *route = [self findRouteStartingFrom:bc.departure toPossibleDestinations:_cardsByDeparture];
			if (route.count == _unsortedBoardingCards.count) {
				// -- We stop at the first valid route
				__strong typeof(_sortingQueue) strongQueue = weakQueue;
				if (strongQueue) {
					[strongQueue cancelAllOperations];
					[self displaySortedResults:route];
				}
			}
		}];
		//[doneOperation addDependency:sortOperation];
		[_sortingQueue addOperation:sortOperation];
	}
}

- (NSArray *)findRouteStartingFrom:(NSString *)departure toPossibleDestinations:(NSDictionary *)destinations
{
	NSMutableArray *currentPath = [NSMutableArray array];
	NSMutableDictionary *citiesLeft = [NSMutableDictionary dictionaryWithDictionary:destinations];

	if ([citiesLeft objectForKey:departure]) {
		// -- Trip can continue to the next destination
		AGBoardingCard *currentHop = [citiesLeft objectForKey:departure];
		[currentPath addObject:currentHop];
		[citiesLeft removeObjectForKey:departure];

		NSArray *restOfTheTrip = [self findRouteStartingFrom:currentHop.destination toPossibleDestinations:citiesLeft];
		if (restOfTheTrip.count) {
			[currentPath addObjectsFromArray:restOfTheTrip];
		}
	}
	
	return currentPath;
}

- (void)finishedAllOperations:(id)sender
{
	// -- No routes found :-(
	
}

- (void)displaySortedResults:(NSArray *)route
{
	AGSortedResultsVC *resultsVC = [[AGSortedResultsVC alloc] initWithNibName:@"AGSortedResultsVC" bundle:nil];
	resultsVC.sortedBoardingCards = route;
	[self.navigationController pushViewController:resultsVC animated:YES];
}


@end
