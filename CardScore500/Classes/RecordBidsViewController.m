    //
//  RecordBidsViewController.m
//  UserInterface
//
//  Created by Joe Bonniwell on 9/9/10.
//  Copyright 2010 Joe Bonniwell. All rights reserved.
//
#define kFirstBidPlayerView 4001
#define kSecondBidPlayerView 4002
#define kThirdBidPlayerView 4003
#define kFourthBidPlayerView 4004
#define kFirstBidder 1
#define kSecondBidder 2
#define kThirdBidder 3
#define kRecordBidButton 3

#import "RecordBidsViewController.h"

@implementation RecordBidsViewController

- (void)loadView 
{
	// Navigation Bar Setup
	[[self navigationItem] setTitle:@"Record Bids"];
	UIBarButtonItem *chartAndRulesNavigationButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Rules", @"Rules") style:UIBarButtonItemStylePlain target:self action:@selector(displayRules)];
	[[self navigationItem] setRightBarButtonItem:chartAndRulesNavigationButton];
	// Container View
	UIView *recordBidsContainerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 480.0f)];
	[recordBidsContainerView setBackgroundColor:[UIColor kAppYellowColor]];
	[self setView:recordBidsContainerView];
	[recordBidsContainerView release];
	// Bottom Toolbar
	UIToolbar *tempRecordBidsToolbar = [[UIToolbar	alloc] initWithFrame:CGRectMake(0.0f, 372.0f, 320.0f, 44.0f)];
	[tempRecordBidsToolbar setBarStyle:UIBarStyleDefault];
	[tempRecordBidsToolbar setTintColor:[UIColor brownColor]];
	UIBarButtonItem *tempFlexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	UIBarButtonItem *tempFixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
	[tempFixedSpace setWidth:150.0f];
	// Enter Bids Button
	UIBarButtonItem *tempRecordBidButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Record Bid", @"Record Bid") style:UIBarButtonItemStyleBordered target:self action:@selector(recordBid)];
	[tempRecordBidButton setWidth:150.0f];
	// Undo Button
	UIBarButtonItem *tempClearLastBidButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Previous Bid", @"Previous Bid") style:UIBarButtonItemStyleBordered target:self action:@selector(clearBid)];
	[tempClearLastBidButton setWidth:150.0f];
	[tempClearLastBidButton setTag:kClearLastBidButton];
	// Add Buttons
	NSArray *singleButtonArray = [[NSArray alloc] initWithObjects:tempFlexSpace, tempFixedSpace, tempFlexSpace, tempRecordBidButton, tempFlexSpace, nil];
	NSArray *doubleButtonArray = [[NSArray alloc] initWithObjects:tempFlexSpace, tempClearLastBidButton, tempFlexSpace, tempRecordBidButton, tempFlexSpace, nil];
	[self setToolbarSingleButtonItems:singleButtonArray];
	[self setToolbarDoubleButtonItems:doubleButtonArray];	
	[self setBottomToolbar:tempRecordBidsToolbar];
	[[self view] addSubview:tempRecordBidsToolbar];
	[tempRecordBidsToolbar release];
	[tempFlexSpace release];
	[tempFixedSpace release];
	[singleButtonArray release];
	[doubleButtonArray release];
	// Bids TableView
	UITableView *tempBidsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 152.0f, 320.0f, 220.0f) style:UITableViewStylePlain];
	[tempBidsTableView setDelegate:self];
	[tempBidsTableView setDataSource:self];
	[tempBidsTableView setBackgroundColor:[UIColor kAppYellowColor]];
	[self setBidsTableView:tempBidsTableView];
	[tempBidsTableView release];
	[[self view] addSubview:[self bidsTableView]];
	// Shadow Holder
	CurvedShadow *curvedShadow = [[CurvedShadow alloc] initWithFrame:CGRectMake(0.0f, 152.0f, 320.0f, 10.0f)];
	[self setShadowHolder:curvedShadow];
	[curvedShadow release];
	[[self view] addSubview:[self shadowHolder]];
	[[self shadowHolder] setHidden:YES];
	// First Bid Player View
	RecordBidsPlayerView *tempPlayer1View = [[RecordBidsPlayerView alloc] initWithLabelPosition:kLabelPositionLeft andFrame:CGRectMake(10.0f, 13.0f, 120.0f, 50.0f)];
	[tempPlayer1View setAlpha:0.25f];
	[self setPlayer1View:tempPlayer1View];
	[[self view] addSubview:tempPlayer1View];
	[tempPlayer1View release];
	// Second Bid Player View
	RecordBidsPlayerView *tempPlayer2View = [[RecordBidsPlayerView alloc] initWithLabelPosition:kLabelPositionRight andFrame:CGRectMake(190.0f, 13.0f, 120.0f, 50.0f)];
	[tempPlayer2View setAlpha:0.25f];
	[self setPlayer2View:tempPlayer2View];
	[[self view] addSubview:tempPlayer2View];
	[tempPlayer2View release];
	// Third Bid Player View
	RecordBidsPlayerView *tempPlayer3View = [[RecordBidsPlayerView alloc] initWithLabelPosition:kLabelPositionRight andFrame:CGRectMake(190.0f, 81.0f, 120.0f, 50.0f)];
	[tempPlayer3View setAlpha:0.25f];
	[self setPlayer3View:tempPlayer3View];
	[[self view] addSubview:tempPlayer3View];
	[tempPlayer3View release];
	// Fourth Bid Player View
	RecordBidsPlayerView *tempPlayer4View = [[RecordBidsPlayerView alloc] initWithLabelPosition:kLabelPositionLeft andFrame:CGRectMake(10.0f, 81.0f, 120.0f, 50.0f)];
	[tempPlayer4View setAlpha:0.25f];
	[self setPlayer4View:tempPlayer4View];
	[[self view] addSubview:tempPlayer4View];
	[tempPlayer4View release];
	// Set up the availableBids arrays
	[self setAllBidsScores:[NSArray arrayWithObjects:
						   [NSNumber numberWithInt:bidPoints[0]],
						   [NSNumber numberWithInt:bidPoints[1]],
						   [NSNumber numberWithInt:bidPoints[2]],
						   [NSNumber numberWithInt:bidPoints[3]],
						   [NSNumber numberWithInt:bidPoints[4]],
						   [NSNumber numberWithInt:bidPoints[5]],
						   [NSNumber numberWithInt:bidPoints[6]],
						   [NSNumber numberWithInt:bidPoints[7]],
						   [NSNumber numberWithInt:bidPoints[8]],
						   [NSNumber numberWithInt:bidPoints[9]],
						   [NSNumber numberWithInt:bidPoints[10]],
						   [NSNumber numberWithInt:bidPoints[11]],
						   [NSNumber numberWithInt:bidPoints[12]],
						   [NSNumber numberWithInt:bidPoints[13]],
						   [NSNumber numberWithInt:bidPoints[14]],
						   [NSNumber numberWithInt:bidPoints[15]],
						   [NSNumber numberWithInt:bidPoints[16]],
						   [NSNumber numberWithInt:bidPoints[17]],
						   [NSNumber numberWithInt:bidPoints[18]],
						   [NSNumber numberWithInt:bidPoints[19]],
						   [NSNumber numberWithInt:bidPoints[20]],
						   [NSNumber numberWithInt:bidPoints[21]],
						   [NSNumber numberWithInt:bidPoints[22]],
						   [NSNumber numberWithInt:bidPoints[23]],
						   [NSNumber numberWithInt:bidPoints[24]],
						   [NSNumber numberWithInt:bidPoints[25]],
						   [NSNumber numberWithInt:bidPoints[26]],
						   [NSNumber numberWithInt:bidPoints[27]],
						   nil]];
	[self setAllBidsNames:[NSArray arrayWithObjects:
							bidNames(0),
							bidNames(1),
							bidNames(2),
							bidNames(3),
							bidNames(4),
							bidNames(5),
							bidNames(6),
							bidNames(7),
							bidNames(8),
							bidNames(9),
							bidNames(10),
							bidNames(11),
							bidNames(12),
							bidNames(13),
							bidNames(14),
							bidNames(15),
							bidNames(16),
							bidNames(17),
							bidNames(18),
							bidNames(19),
							bidNames(20),
							bidNames(21),
							bidNames(22),
							bidNames(23),
							bidNames(24),
							bidNames(25),
							bidNames(26),
							bidNames(27),
							nil]];
	[self setAllBidsKeys:[NSArray arrayWithObjects:
						  [NSNumber numberWithInt:k_NoBid],
						  [NSNumber numberWithInt:k_6Spades],
						  [NSNumber numberWithInt:k_6Clubs],
						  [NSNumber numberWithInt:k_6Diamonds],
						  [NSNumber numberWithInt:k_6Hearts],
						  [NSNumber numberWithInt:k_6NoTrump],
						  [NSNumber numberWithInt:k_7Spades],
						  [NSNumber numberWithInt:k_7Clubs],
						  [NSNumber numberWithInt:k_7Diamonds],
						  [NSNumber numberWithInt:k_7Hearts],
						  [NSNumber numberWithInt:k_7NoTrump],
						  [NSNumber numberWithInt:k_8Spades],
						  [NSNumber numberWithInt:k_SingleLow],
						  [NSNumber numberWithInt:k_8Clubs],
						  [NSNumber numberWithInt:k_8Diamonds],
						  [NSNumber numberWithInt:k_8Hearts],
						  [NSNumber numberWithInt:k_8NoTrump],
						  [NSNumber numberWithInt:k_9Spades],
						  [NSNumber numberWithInt:k_9Clubs],
						  [NSNumber numberWithInt:k_9Diamonds],
						  [NSNumber numberWithInt:k_9Hearts],
						  [NSNumber numberWithInt:k_9NoTrump],
						  [NSNumber numberWithInt:k_10Spades],
						  [NSNumber numberWithInt:k_10Clubs],
						  [NSNumber numberWithInt:k_10Diamonds],
						  [NSNumber numberWithInt:k_10Hearts],
						  [NSNumber numberWithInt:k_DoubleLow],
						  [NSNumber numberWithInt:k_10NoTrump],
						  nil]];
}

- (void)viewDidLoad
{
	scrollingToTop = NO;
}

- (void)viewWillAppear:(BOOL)animated
{	
	// TODO: Check for newGame flag and make a new hand here....
	[self updateWinningBidder];
	[self updateAvailableBids];
	[bidsTableView reloadData];
	NSUInteger zeroIndex[2] = {0, 0};
	[[self bidsTableView] scrollToRowAtIndexPath:[NSIndexPath indexPathWithIndexes:zeroIndex length:2] atScrollPosition:UITableViewScrollPositionTop animated:NO];
	[[self player1View] attachPlayerName:[[self delegate] player1Name]];
	[[self player2View] attachPlayerName:[[self delegate] player2Name]];
	[[self player3View] attachPlayerName:[[self delegate] player3Name]];
	[[self player4View] attachPlayerName:[[self delegate] player4Name]];
	[self updateBidLabels];
	[self updateAvatars];
}

- (void)viewDidUnload 
{
    [super viewDidUnload];
	// Views
	[self setBidsTableView:nil];
	[self setPlayer1View:nil];
	[self setPlayer2View:nil];
	[self setPlayer3View:nil];
	[self setPlayer4View:nil];
	[self setBottomToolbar:nil];
	[self setShadowHolder:nil];
	// Controllers
	[self setRulesViewController:nil];
	// Data
	[self setCurrentHand:nil];
	[self setAllBidsNames:nil];
	[self setAllBidsScores:nil];
	[self setAllBidsKeys:nil];
	[self setAvailableBidsNames:nil];
	[self setAvailableBidsScores:nil];
	[self setAvailableBidsKeys:nil];
	[self setSelectedBidIndexPath:nil];
}

- (void)dealloc 
{
	// Views
	[bidsTableView release];
	[player1View release];
	[player2View release];
	[player3View release];
	[player4View release];
	[shadowHolder release];
	// Controllers
	[rulesViewController release];	
	// Data
	[bottomToolbar release];
	[currentHand release];
	[allBidsNames release];
	[allBidsScores release];
	[allBidsKeys release];
	[availableBidsNames release];
	[availableBidsScores release];
	[availableBidsKeys release];
	[selectedBidIndexPath release];
    [super dealloc];
}

#pragma mark -
#pragma mark TableView Delegate Methods

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView*)argScrollView
{
	if (scrollingToTop == YES)
	{
		[[self shadowHolder] setHidden:YES];
		scrollingToTop = NO;
	}
}

- (void)scrollViewDidScroll:(UIScrollView*)argScrollView
{
	[[self shadowHolder] setHidden:NO];
}

- (void)scrollViewDidEndDragging:(UIScrollView*)argScrollView willDecelerate:(BOOL)argDecelerate
{
	if (argDecelerate == NO)
	{
		NSArray *indexes = [[self bidsTableView] indexPathsForVisibleRows];
		BOOL zeroShown = NO;
		BOOL cancel = NO;
		for (NSIndexPath *index in indexes)
		{
			if ([index row] == 0)
				zeroShown = YES;
			if ([index row] == 5)
				cancel = YES;
		}
		if (zeroShown == YES && cancel == NO)
			[[self shadowHolder] setHidden:YES];
	}
}

- (void)scrollViewDidEndDecelerating:(UIScrollView*)argScrollView
{
	NSArray *indexes = [[self bidsTableView] indexPathsForVisibleRows];
	BOOL zeroShown = NO;
	BOOL cancel = NO;
	for (NSIndexPath *index in indexes)
	{
		if ([index row] == 0)
			zeroShown = YES;
		if ([index row] == 5)
			cancel = YES;
	}
	if (zeroShown == YES && cancel == NO)
		[[self shadowHolder] setHidden:YES];
}

- (void)tableView:(UITableView*)argTableView didSelectRowAtIndexPath:(NSIndexPath*)argIndexPath
{
	[self setSelectedBidIndexPath:argIndexPath];
	[[[[self bottomToolbar] items] objectAtIndex:kRecordBidButton] setEnabled:YES];
	[[self bidsTableView] reloadData];
}

#pragma mark -
#pragma mark TableView DataSource Methods

- (NSInteger)tableView:(UITableView*)argTableView numberOfRowsInSection:(NSInteger)argSection
{
	return [[self availableBidsNames] count];
}

- (UITableViewCell*)tableView:(UITableView *)argTableView cellForRowAtIndexPath:(NSIndexPath *)argIndexPath
{
	static NSString *BidsTableViewCellIdentifier = @"BidsTableViewCellIdentifier";
	UITableViewCell *cell = [argTableView dequeueReusableCellWithIdentifier:BidsTableViewCellIdentifier];
	if (!cell)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:BidsTableViewCellIdentifier] autorelease];
		[cell setBackgroundColor:[UIColor kAppYellowColor]];
	}
	[cell setAccessoryType:UITableViewCellAccessoryNone];
	if ([argIndexPath isEqual:[self selectedBidIndexPath]])
		[cell setAccessoryType:UITableViewCellAccessoryCheckmark];
	[[cell textLabel] setText:[[self availableBidsNames] objectAtIndex:[argIndexPath row]]];
	[[cell detailTextLabel] setText:[NSString stringWithFormat:@"%d",[[[self availableBidsScores] objectAtIndex:[argIndexPath row]] integerValue]]];
	return cell;	
}

#pragma mark -
#pragma mark Other Methods

- (void)displayRules
{
	if (!rulesViewController)
		rulesViewController = [[RulesViewController alloc] init];
	[[self navigationController] pushViewController:rulesViewController animated:YES];
}

- (void)recordBid
{
	int selectedBid = [[[self availableBidsKeys] objectAtIndex:[[self selectedBidIndexPath] row]] integerValue];
	[self setSelectedBidIndexPath:nil];
	[[[[self bottomToolbar] items] objectAtIndex:kRecordBidButton] setEnabled:NO];
	switch ([self currentBidder])
	{
		case 1:
			[[self currentHand] setValue:[NSNumber numberWithInt:selectedBid] forKey:@"player1Bid"];
			if (selectedBid != k_NoBid)
				[[self currentHand] setValue:[NSNumber numberWithInt:1] forKey:@"winningBidder"];
			break;
		case 2:
			[[self currentHand] setValue:[NSNumber numberWithInt:selectedBid] forKey:@"player2Bid"];
			if (selectedBid != k_NoBid)
				[[self currentHand] setValue:[NSNumber numberWithInt:2] forKey:@"winningBidder"];
			break;
		case 3:
			[[self currentHand] setValue:[NSNumber numberWithInt:selectedBid] forKey:@"player3Bid"];
			if (selectedBid != k_NoBid)
				[[self currentHand] setValue:[NSNumber numberWithInt:3] forKey:@"winningBidder"];
			break;
		case 4:
			[[self currentHand] setValue:[NSNumber numberWithInt:selectedBid] forKey:@"player4Bid"];
			if (selectedBid != k_NoBid)
				[[self currentHand] setValue:[NSNumber numberWithInt:4] forKey:@"winningBidder"];
			break;
		default:
			break;
	}
	if ([self currentBidder] == [self currentDealer] && [self bidForPlayer:[self currentDealer]] > -1)	// Everyone has bid
	{
		if ([[[self currentHand] valueForKey:@"winningBidder"] integerValue] == 0)	// No Winning Bidder
		{
			[[self currentHand] setValue:[NSNumber numberWithBool:YES] forKey:@"biddingComplete"];
			if (gEnableMisdeals == YES)
			{
				[[self currentHand] setValue:[NSNumber numberWithInt:kMisdeal] forKey:@"winningBidder"];
				[[self delegate] handCompletedAsMisdeal];
				[[self navigationController] popViewControllerAnimated:YES];
				return;
			}
			else 
			{
				[[self currentHand] setValue:[NSNumber numberWithInt:kNoWinner] forKey:@"winningBidder"];
			}
			[[self navigationController] popViewControllerAnimated:YES];
			return;
		}
		else if ([[[self currentHand] valueForKey:[NSString stringWithFormat:@"player%dBid", [[[self currentHand] valueForKey:@"winningBidder"] integerValue]]] integerValue] < k_7Spades && gPlaySixBids == NO)	// Winning Bidder with a 6 bid and gPlaySixBids is NO
		{
			// TODO: now what?
		}
		[[self currentHand] setValue:[NSNumber numberWithBool:YES] forKey:@"biddingComplete"];
		[[self navigationController] popViewControllerAnimated:YES];
	}
	else if (selectedBid == k_10NoTrump)	// Highest bid made, no other bids can be made
	{
		[[self currentHand] setValue:[NSNumber numberWithBool:YES] forKey:@"biddingComplete"];
		[[self navigationController] popViewControllerAnimated:YES];
	}
	else	// Continue Bidding Process
	{
		[self updateBidLabels];
		[self updateAvatars];
		[self updateAvailableBids];
		[bidsTableView reloadData];
		NSUInteger zeroIndex[2] = {0, 0};
		[[self bidsTableView] scrollToRowAtIndexPath:[NSIndexPath indexPathWithIndexes:zeroIndex length:2] atScrollPosition:UITableViewScrollPositionTop animated:YES];
		scrollingToTop = YES;
		if ([[[self bottomToolbar] items] isEqualToArray:[self toolbarSingleButtonItems]])
			[[self bottomToolbar] setItems:[self toolbarDoubleButtonItems]];
	}
}

- (void)clearBid
{
	int bidToSelect = [[[self currentHand] valueForKey:[NSString stringWithFormat:@"player%dBid", [self previousBidder]]] integerValue];
	[[self currentHand] setValue:[NSNumber numberWithInt:-1] forKey:[NSString stringWithFormat:@"player%dBid", [self currentBidder]]];
	[[self currentHand] setValue:[NSNumber numberWithInt:-1] forKey:[NSString stringWithFormat:@"player%dBid", [self previousBidder]]];
	[self updateWinningBidder];
	[self updateBidLabels];
	[self updateAvatars];
	[self updateAvailableBids];
	int indexToSelect = [[self availableBidsKeys] indexOfObjectPassingTest:^(id obj, NSUInteger idx, BOOL *stop)
	{
		 if ([obj integerValue] == bidToSelect)
			 return YES;
		 return NO;
	}];
	[self setSelectedBidIndexPath:[NSIndexPath indexPathForRow:indexToSelect inSection:0]];
	[bidsTableView reloadData];
	[[self bidsTableView] scrollToRowAtIndexPath:[self selectedBidIndexPath] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
	[[[[self bottomToolbar] items] objectAtIndex:kRecordBidButton] setEnabled:YES];
}

- (int)currentWinningBid
{
	return [self bidForPlayer:[[[self currentHand] valueForKey:@"winningBidder"] integerValue]];
}

- (void)updateAvatars
{
	switch ([self currentBidder]) 
	{
		case 1:
			[UIView animateWithDuration:0.25f animations:^{
				[[self player1View] setAlpha:1.0f];
				[[self player2View] setAlpha:0.25f];
				[[self player3View] setAlpha:0.25f];
				[[self player4View] setAlpha:0.25f];				
			}];
			break;
		case 2:
			[UIView animateWithDuration:0.25f animations:^{
				[[self player1View] setAlpha:0.25f];
				[[self player2View] setAlpha:1.0f];
				[[self player3View] setAlpha:0.25f];
				[[self player4View] setAlpha:0.25f];
			}];
			break;
		case 3:
			[UIView animateWithDuration:0.25f animations:^{
				[[self player1View] setAlpha:0.25f];
				[[self player2View] setAlpha:0.25f];
				[[self player3View] setAlpha:1.0f];
				[[self player4View] setAlpha:0.25f];
			}];
			break;
		case 4:
			[UIView animateWithDuration:0.25f animations:^{
				[[self player1View] setAlpha:0.25f];
				[[self player2View] setAlpha:0.25f];
				[[self player3View] setAlpha:0.25f];
				[[self player4View] setAlpha:1.0f];
			}];
			break;
		default:
			break;
	}
}

- (void)updateAvailableBids
{
	// Reset availableBidNames and Scores to original
	[self setAvailableBidsNames:[allBidsNames mutableCopy]];
	[self setAvailableBidsScores:[allBidsScores mutableCopy]];
	[self setAvailableBidsKeys:[allBidsKeys mutableCopy]];
	if ([self currentWinningBid] == k_10Hearts)
	{
		[[self availableBidsNames] removeObjectsInRange:NSMakeRange(1, 26)];
		[[self availableBidsScores] removeObjectsInRange:NSMakeRange(1, 26)];
		[[self availableBidsKeys] removeObjectsInRange:NSMakeRange(1, 26)];
	}
	else if ([self currentWinningBid] == k_SingleLow && g8SpadesOutbidsNula == YES)
	{
		[[self availableBidsNames] removeObjectsInRange:NSMakeRange(1, 10)];
		[[self availableBidsScores] removeObjectsInRange:NSMakeRange(1, 10)];
		[[self availableBidsKeys] removeObjectsInRange:NSMakeRange(1, 10)];
		// Also remove singleLow
		[[self availableBidsNames] removeObjectAtIndex:2];
		[[self availableBidsScores] removeObjectAtIndex:2];
		[[self availableBidsKeys] removeObjectAtIndex:2];
	}
	else if ([self currentWinningBid] == k_8Spades && g8SpadesOutbidsNula == YES)
	{
		[[self availableBidsNames] removeObjectsInRange:NSMakeRange(1, 12)];
		[[self availableBidsScores] removeObjectsInRange:NSMakeRange(1, 12)];
		[[self availableBidsKeys] removeObjectsInRange:NSMakeRange(1, 12)];
	}
	else 
	{
		[[self availableBidsNames] removeObjectsInRange:NSMakeRange(1, [self currentWinningBid])];
		[[self availableBidsScores] removeObjectsInRange:NSMakeRange(1, [self currentWinningBid])];
		[[self availableBidsKeys] removeObjectsInRange:NSMakeRange(1, [self currentWinningBid])];
	}	
}

- (int)bidForPlayer:(int)argPlayer
{
	if (argPlayer > 0)
		return [[[self currentHand] valueForKey:[NSString stringWithFormat:@"player%dBid", argPlayer]] integerValue];
	return 0;
}

- (int)currentDealer
{
	return [[[self currentHand] valueForKey:@"dealer"] integerValue];
}

- (int)bidder:(int)argBidder
{
	int tempBidder = [self currentDealer] + argBidder;
	if (tempBidder > 4)
		tempBidder = tempBidder - 4;
	return tempBidder;
}

- (int)currentBidder
{
	if ([self bidForPlayer:[self bidder:kFirstBidder]] == -1)
		return [self bidder:kFirstBidder];
	if ([self bidForPlayer:[self bidder:kSecondBidder]] == -1)
		return [self bidder:kSecondBidder];
	if ([self bidForPlayer:[self bidder:kThirdBidder]] == -1)
		return [self bidder:kThirdBidder];
	return [self currentDealer];
}

- (int)previousBidder
{
	int tempBidder = [self currentBidder] - 1;
	if (tempBidder < 1)
		tempBidder = tempBidder + 4;
	return tempBidder;
}

- (void)updateWinningBidder
{	
	if ([self bidForPlayer:[self bidder:kFirstBidder]] == -1)
	{
		[[self currentHand] setValue:[NSNumber numberWithInt:0] forKey:@"winningBidder"];
		[[self bottomToolbar] setItems:[self toolbarSingleButtonItems] animated:YES];
		return;
	}
	[[self bottomToolbar] setItems:[self toolbarDoubleButtonItems] animated:YES];
	if ([self bidForPlayer:[self bidder:kFirstBidder]] < 1 && [self bidForPlayer:[self bidder:kSecondBidder]] < 1 && [self bidForPlayer:[self bidder:kThirdBidder]] < 1)
	{
		[[self currentHand] setValue:[NSNumber numberWithInt:0] forKey:@"winningBidder"];
		return;
	}
	if ([self bidForPlayer:[self bidder:kThirdBidder]] > [self bidForPlayer:[self bidder:kSecondBidder]] && [self bidForPlayer:[self bidder:kThirdBidder]] > [self bidForPlayer:[self bidder:kFirstBidder]])
	{
		[[self currentHand] setValue:[NSNumber numberWithInt:[self bidder:kThirdBidder]] forKey:@"winningBidder"];
		return;
	}
	if ([self bidForPlayer:[self bidder:kSecondBidder]] > [self bidForPlayer:[self bidder:kFirstBidder]])
	{
		[[self currentHand] setValue:[NSNumber numberWithInt:[self bidder:kSecondBidder]] forKey:@"winningBidder"];
		return;
	}
	[[self currentHand] setValue:[NSNumber numberWithInt:[self bidder:kFirstBidder]] forKey:@"winningBidder"];
}

- (void)updateBidLabels
{
	[[self player1View] attachBidName:bidNames([[[self currentHand] valueForKey:@"player1Bid"] integerValue])];
	[[self player2View] attachBidName:bidNames([[[self currentHand] valueForKey:@"player2Bid"] integerValue])];
	[[self player3View] attachBidName:bidNames([[[self currentHand] valueForKey:@"player3Bid"] integerValue])];
	[[self player4View] attachBidName:bidNames([[[self currentHand] valueForKey:@"player4Bid"] integerValue])];	
}

// Views
@synthesize bidsTableView;
@synthesize player1View;
@synthesize player2View;
@synthesize player3View;
@synthesize player4View;
@synthesize bottomToolbar;
@synthesize toolbarDoubleButtonItems;
@synthesize toolbarSingleButtonItems;
@synthesize shadowHolder;
// Controllers
@synthesize rulesViewController;
@synthesize delegate;
// Data
@synthesize currentHand;
@synthesize allBidsNames;
@synthesize allBidsScores;
@synthesize allBidsKeys;
@synthesize availableBidsNames;
@synthesize availableBidsScores;
@synthesize availableBidsKeys;
@synthesize selectedBidIndexPath;
@end
