    //
//  GameDetailViewController.m
//  UserInterface
//
//  Created by Joe Bonniwell on 9/7/10.
//  Copyright 2010 Joe Bonniwell. All rights reserved.
//

#import "GameDetailViewController.h"

@implementation GameDetailViewController

- (void)loadView 
{
	// Navigation Bar Setup
	[[self navigationItem] setTitle:NSLocalizedString(@"Game Detail", @"Game Detail")];
	UIBarButtonItem *chartAndRulesNavigationButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Rules", @"Rules") style:UIBarButtonItemStylePlain target:self action:@selector(displayRules)];
	[[self navigationItem] setRightBarButtonItem:chartAndRulesNavigationButton];
	// Container View
	UIView *tempGameDetailContainerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 230.0)];
	[tempGameDetailContainerView setBackgroundColor:[UIColor kAppYellowColor]];
	[self setView:tempGameDetailContainerView];
	[tempGameDetailContainerView release];
	// GameDetailPlayerView Setup
	GameDetailPlayerView *tempGameDetailPlayerView = [[GameDetailPlayerView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 230.0f)];
	[tempGameDetailPlayerView setTag:kGameDetailPlayerView];
	[tempGameDetailPlayerView setDelegate:self];
	[[tempGameDetailPlayerView player1TextField] setDelegate:self];
	[[tempGameDetailPlayerView player2TextField] setDelegate:self];
	[[tempGameDetailPlayerView player3TextField] setDelegate:self];
	[[tempGameDetailPlayerView player4TextField] setDelegate:self];
	[self setGameDetailPlayerView:tempGameDetailPlayerView];
	[[self view] addSubview:tempGameDetailPlayerView];
	[tempGameDetailPlayerView release];
	// GameDetailHistoryView Setup
	UITableView *tempGameDetailHistoryTableView = [[UITableView alloc] initWithFrame:CGRectMake(10.0f, 234.0f, 300.0f, 176.0f) style:UITableViewStylePlain];
	[tempGameDetailHistoryTableView setDelegate:self];
	[tempGameDetailHistoryTableView	setDataSource:self];
	[tempGameDetailHistoryTableView setTag:kGameDetailHistoryView];
	[tempGameDetailHistoryTableView setBackgroundColor:[UIColor kAppYellowColor]];
	[tempGameDetailHistoryTableView setSeparatorColor:[UIColor darkGrayColor]];
	[tempGameDetailHistoryTableView setAllowsSelection:NO];
	[self setGameDetailHistoryView:tempGameDetailHistoryTableView];
	[tempGameDetailHistoryTableView release];
	[[self view] addSubview:[self gameDetailHistoryView]];
	// Shadow View
	CurvedShadow *curvedShadow = [[CurvedShadow alloc] initWithFrame:CGRectMake(10.0f, 230.0, 300.0f, 10.0f)];
	[self setShadowHolder:curvedShadow];
	[curvedShadow release];
	[[self view] addSubview:[self shadowHolder]];
	[[self shadowHolder] setHidden:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
	if ([self recordBidsViewController])
		[[self recordBidsViewController] setCurrentHand:nil];
	if ([self recordTricksViewController])
		[[self recordTricksViewController] setCurrentHand:nil];
	// If this causes problems, could put a conditional check for game finished
	NSMutableSet *hands = [[self currentGame] mutableSetValueForKey:@"hands"];
	[self updateOrderedHandsWithHandSet:hands];
	[self refreshNames];
	[gameDetailHistoryView reloadData];
	switch ([[[self currentHand] valueForKey:@"dealer"] integerValue]) 
	{
		case 1:
			[[self gameDetailPlayerView] moveDealerToPlayer:1];
			break;
		case 2:
			[[self gameDetailPlayerView] moveDealerToPlayer:2];
			break;
		case 3:
			[[self gameDetailPlayerView] moveDealerToPlayer:3];
			break;
		case 4:
			[[self gameDetailPlayerView] moveDealerToPlayer:4];
			break;
		default:
			break;
	}
	[self refreshMainActionButton];
}

- (void)viewDidAppear:(BOOL)animated
{
	if ([self newGameFlag] && gFirstRun == YES && hintWasDisplayed == NO)
	{
		UIAlertView *hintAlertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Welcome!", @"Welcome!") message:[NSString stringWithFormat:@"%@\n%@\n\n%@\n%@\n\n%@", NSLocalizedString(@"To change a player name,", @"To change a player name,"), NSLocalizedString(@"tap on the name", @"tap on the name"), NSLocalizedString(@"To change the dealer,", @"To change the dealer,"), NSLocalizedString(@"double tap on the player icon", @"double tap on the player icon"), NSLocalizedString(@"Find more hints on the info screen", @"Find more hints on the info screen")] delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil];
		[hintAlertView show];
		[hintAlertView release];
		hintWasDisplayed = YES;
	}
}

- (void)viewWillDisappear:(BOOL)animated
{
	[[self view] endEditing:YES];
}

- (void)viewDidUnload 
{
    [super viewDidUnload];
	[self setGameDetailHistoryView:nil];
	[self setRecordBidsViewController:nil];
	[self setManagedObjectContext:nil];
	[self setCurrentGame:nil];
	[self setPlayer1:nil];
	[self setPlayer2:nil];
	[self setPlayer3:nil];
	[self setPlayer4:nil];
	[self setOrderedHands:nil];
	[self setShadowHolder:nil];
}

- (void)dealloc 
{
	[gameDetailHistoryView release];
	[recordBidsViewController release];
	[managedObjectContext release];
	[currentGame release];
	[player1 release];
	[player2 release];
	[player3 release];
	[player4 release];
	[orderedHands release];
	[shadowHolder release];
    [super dealloc];
}

#pragma mark -
#pragma mark Other Methods

- (NSManagedObject*)currentHand
{
	return [[self orderedHands] objectAtIndex:0];
}

- (void)displayRules
{
	if (!rulesViewController)
		rulesViewController = [[RulesViewController alloc] init];
	[[self navigationController] pushViewController:rulesViewController animated:YES];
}

- (void)refreshNames
{
	[[[self gameDetailPlayerView] player1TextField] setText:[[self player1] valueForKey:@"name"]];
	[[[self gameDetailPlayerView] player2TextField] setText:[[self player2] valueForKey:@"name"]];
	[[[self gameDetailPlayerView] player3TextField] setText:[[self player3] valueForKey:@"name"]];
	[[[self gameDetailPlayerView] player4TextField] setText:[[self player4] valueForKey:@"name"]];
	[[[self gameDetailPlayerView] team13ScoreNameLabel] setText:[NSString stringWithFormat:@"%@\n%@", [[self player1] valueForKey:@"name"], [[self player3] valueForKey:@"name"]]];
	[[[self gameDetailPlayerView] team24ScoreNameLabel] setText:[NSString stringWithFormat:@"%@\n%@", [[self player2] valueForKey:@"name"], [[self player4] valueForKey:@"name"]]];
	[[self gameDetailHistoryView] reloadData];
}

- (NSString*)formatScores:(int)argScore
{
	if (argScore < 0)
	{
		int tempNegativeScore = (-1.0 * argScore);
		return [[[NSString alloc] initWithFormat:@"(%d)", tempNegativeScore] autorelease];
	}
	return [[[NSString alloc] initWithFormat:@"%d", argScore] autorelease];
}

- (void)addNewHandWithDealer:(int)argDealer
{
	NSMutableSet *hands = [[self currentGame] mutableSetValueForKey:@"hands"];
	NSManagedObject *newHand = [NSEntityDescription insertNewObjectForEntityForName:@"Hand" inManagedObjectContext:[self managedObjectContext]];
	int newIndex;
	if ([[self orderedHands] count] == 0)
		newIndex = 0;
	else
		newIndex = [[[self currentHand] valueForKey:@"index"] integerValue] + 1;
	[newHand setValue:[NSNumber numberWithInt:newIndex] forKey:@"index"];
	[newHand setValue:[NSNumber numberWithBool:NO] forKey:@"biddingComplete"];
	[newHand setValue:[NSNumber numberWithBool:NO] forKey:@"handComplete"];
	[newHand setValue:[NSNumber numberWithInt:argDealer] forKey:@"dealer"];
	[newHand setValue:[[self currentGame] valueForKey:@"team13Score"] forKey:@"team13ScoreTotal"];
	[newHand setValue:[[self currentGame] valueForKey:@"team24Score"] forKey:@"team24ScoreTotal"];
	[newHand setValue:[[self currentGame] valueForKey:@"team13BidScore"] forKey:@"team13ScoreBidPoints"];
	[newHand setValue:[[self currentGame] valueForKey:@"team24BidScore"] forKey:@"team24ScoreBidPoints"];
	[hands addObject:newHand];
	[[self currentGame] setValue:hands forKey:@"hands"];
	[self updateOrderedHandsWithHandSet:hands];
	[[self managedObjectContext] save:NULL];
}

- (void)updateOrderedHandsWithHandSet:(NSMutableSet*)argHandSet
{
	// Update the ordered hands array	
	NSSortDescriptor *handsSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"index" ascending:NO];
	NSArray *handsSortDescriptors = [[NSArray alloc] initWithObjects:handsSortDescriptor, nil];
	NSArray *tempOrderedHands = [[NSArray alloc] initWithArray:[argHandSet sortedArrayUsingDescriptors:handsSortDescriptors]];
	[self setOrderedHands:tempOrderedHands];
	[handsSortDescriptor release];
	[handsSortDescriptors release];
	[tempOrderedHands release];
}

- (void)refreshMainActionButton
{
	if ([[[self currentGame] valueForKey:@"gameFinished"] boolValue])
	{
		[[[self gameDetailPlayerView] mainActionButton] setTitle:NSLocalizedString(@"Game\nFinished", @"Game\nFinished") forState:UIControlStateDisabled];
		[[[self gameDetailPlayerView] mainActionButton] setEnabled:NO];
	}
	else 
	{
		[[[self gameDetailPlayerView] mainActionButton] setEnabled:YES];
		if ([[[self currentHand] valueForKey:@"biddingComplete"] boolValue] == YES)
		{
			[[[self gameDetailPlayerView] mainActionButton] setTitle:NSLocalizedString(@"Record\nTricks", @"Record\nTricks") forState:UIControlStateNormal];
		}
		else 
		{
			[[[self gameDetailPlayerView] mainActionButton] setTitle:NSLocalizedString(@"Enter\nBids", @"Enter\nBids") forState:UIControlStateNormal];
		}
	}
}
#pragma mark -
#pragma mark TableView Delegate Methods

- (void)scrollViewDidScroll:(UIScrollView*)argScrollView
{
	[[self shadowHolder] setHidden:NO];
}

- (void)scrollViewDidEndDragging:(UIScrollView*)argScrollView willDecelerate:(BOOL)argDecelerate
{
	if (argDecelerate == NO)
	{
		NSArray *indexes = [[self gameDetailHistoryView] indexPathsForVisibleRows];
		BOOL zeroShown = NO;
		BOOL cancel = NO;
		for (NSIndexPath *index in indexes)
		{
			if ([index row] == 0)
				zeroShown = YES;
				if ([index row] == 4)
					cancel = YES;
		}
		if (zeroShown == YES && cancel == NO)
			[[self shadowHolder] setHidden:YES];
	}
}

- (void)scrollViewDidEndDecelerating:(UIScrollView*)argScrollView
{
	NSArray *indexes = [[self gameDetailHistoryView] indexPathsForVisibleRows];
	BOOL zeroShown = NO;
	BOOL cancel = NO;
	for (NSIndexPath *index in indexes)
	{
		if ([index row] == 0)
			zeroShown = YES;
		if ([index row] == 4)
			cancel = YES;
	}
	if (zeroShown == YES && cancel == NO)
		[[self shadowHolder] setHidden:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView*)argTableView editingStyleForRowAtIndexPath:(NSIndexPath*)argIndexPath
{
	if ([argIndexPath row] == 0)
		return UITableViewCellEditingStyleDelete;
	return UITableViewCellEditingStyleNone;
}

#pragma mark -
#pragma mark TableView DataSource Methods

- (void)tableView:(UITableView*)argTableView commitEditingStyle:(UITableViewCellEditingStyle)argEditingStyle forRowAtIndexPath:(NSIndexPath*)argIndexPath
{
	int dealer;
	if ([[[self currentHand] valueForKey:@"handComplete"] boolValue] == NO && [[[self currentHand] valueForKey:@"winningBidder"] integerValue] < 1)
	{
		NSMutableSet *hands;
		[[self managedObjectContext] deleteObject:[[self orderedHands] objectAtIndex:0]];
		[[self managedObjectContext] save:NULL];
		hands = [[self currentGame] mutableSetValueForKey:@"hands"];
		[self updateOrderedHandsWithHandSet:hands];
		// subtract the last hand's score from the game scores
		int oldGameTeam13BidScore = [[[self currentGame] valueForKey:@"team13BidScore"] integerValue];
		int oldGameTeam13Score = [[[self currentGame] valueForKey:@"team13Score"] integerValue];
		int oldGameTeam24BidScore = [[[self currentGame] valueForKey:@"team24BidScore"] integerValue];
		int oldGameTeam24Score = [[[self currentGame] valueForKey:@"team24Score"] integerValue];
		int newGameTeam13BidScore = oldGameTeam13BidScore - [[[self currentHand] valueForKey:@"team13BidPoints"] integerValue];
		int newGameTeam13Score = oldGameTeam13Score - ([[[self currentHand] valueForKey:@"team13BidPoints"] integerValue] + [[[self currentHand] valueForKey:@"team13OppositionPoints"] integerValue]);
		int newGameTeam24BidScore = oldGameTeam24BidScore - [[[self currentHand] valueForKey:@"team24BidPoints"] integerValue];
		int newGameTeam24Score = oldGameTeam24Score - ([[[self currentHand] valueForKey:@"team24BidPoints"] integerValue] + [[[self currentHand] valueForKey:@"team24OppositionPoints"] integerValue]);
		[[self currentGame] setValue:[NSNumber numberWithInt:newGameTeam13BidScore] forKey:@"team13BidScore"];
		[[self currentGame] setValue:[NSNumber numberWithInt:newGameTeam13Score] forKey:@"team13Score"];
		[[self currentGame] setValue:[NSNumber numberWithInt:newGameTeam24BidScore] forKey:@"team24BidScore"];
		[[self currentGame] setValue:[NSNumber numberWithInt:newGameTeam24Score] forKey:@"team24Score"];
		// record the hand's dealer and delete the hand
		dealer = [[[self currentHand] valueForKey:@"dealer"] integerValue];
		[[self managedObjectContext] deleteObject:[[self orderedHands] objectAtIndex:0]];
		[[self managedObjectContext] save:NULL];
		hands = [[self currentGame] mutableSetValueForKey:@"hands"];
		[self updateOrderedHandsWithHandSet:hands];
	}
	else if ([[[self currentGame] valueForKey:@"gameFinished"] boolValue] == YES)
	{
		NSMutableSet *hands;
		[[self currentGame] setValue:[NSNumber numberWithBool:NO] forKey:@"gameFinished"];
		int oldGameTeam13BidScore = [[[self currentGame] valueForKey:@"team13BidScore"] integerValue];
		int oldGameTeam13Score = [[[self currentGame] valueForKey:@"team13Score"] integerValue];
		int oldGameTeam24BidScore = [[[self currentGame] valueForKey:@"team24BidScore"] integerValue];
		int oldGameTeam24Score = [[[self currentGame] valueForKey:@"team24Score"] integerValue];
		int newGameTeam13BidScore = oldGameTeam13BidScore - [[[self currentHand] valueForKey:@"team13BidPoints"] integerValue];
		int newGameTeam13Score = oldGameTeam13Score - ([[[self currentHand] valueForKey:@"team13BidPoints"] integerValue] + [[[self currentHand] valueForKey:@"team13OppositionPoints"] integerValue]);
		int newGameTeam24BidScore = oldGameTeam24BidScore - [[[self currentHand] valueForKey:@"team24BidPoints"] integerValue];
		int newGameTeam24Score = oldGameTeam24Score - ([[[self currentHand] valueForKey:@"team24BidPoints"] integerValue] + [[[self currentHand] valueForKey:@"team24OppositionPoints"] integerValue]);
		[[self currentGame] setValue:[NSNumber numberWithInt:newGameTeam13BidScore] forKey:@"team13BidScore"];
		[[self currentGame] setValue:[NSNumber numberWithInt:newGameTeam13Score] forKey:@"team13Score"];
		[[self currentGame] setValue:[NSNumber numberWithInt:newGameTeam24BidScore] forKey:@"team24BidScore"];
		[[self currentGame] setValue:[NSNumber numberWithInt:newGameTeam24Score] forKey:@"team24Score"];
		// record the hand's dealer and delete the hand
		dealer = [[[self currentHand] valueForKey:@"dealer"] integerValue];
		[[self managedObjectContext] deleteObject:[[self orderedHands] objectAtIndex:0]];
		[[self managedObjectContext] save:NULL];
		hands = [[self currentGame] mutableSetValueForKey:@"hands"];
		[self updateOrderedHandsWithHandSet:hands];
	}
	else 
	{
		dealer = [[[self currentHand] valueForKey:@"dealer"] integerValue];
		// delete the hand
		[[self managedObjectContext] deleteObject:[self currentHand]];
		[[self managedObjectContext] save:NULL];
		// get the remaining hands
		NSMutableSet *hands = [[self currentGame] mutableSetValueForKey:@"hands"];
		[self updateOrderedHandsWithHandSet:hands];
	}
	[self addNewHandWithDealer:dealer];
	[[self managedObjectContext] save:NULL];
	NSArray *deletePathArray = [NSArray arrayWithObject:argIndexPath];
	[argTableView deleteRowsAtIndexPaths:deletePathArray withRowAnimation:UITableViewRowAnimationFade];
	[[self gameDetailPlayerView] moveDealerToPlayer:dealer];
	[self refreshMainActionButton];
}

- (BOOL)tableView:(UITableView*)argTableView canEditRowAtIndexPath:(NSIndexPath*)argIndexPath
{
	if ([argIndexPath row] == 0)
		return YES;
	return NO;
}

- (NSInteger)tableView:(UITableView*)argTableView numberOfRowsInSection:(NSInteger)argSection
{
	if ([[[self currentGame] valueForKey:@"gameFinished"] boolValue] == NO & [[[self currentHand] valueForKey:@"winningBidder"] integerValue] < 1)
		return ([[self orderedHands] count] - 1);
	return [[self orderedHands] count];
}

- (UITableViewCell*)tableView:(UITableView*)argTableView cellForRowAtIndexPath:(NSIndexPath*)argIndexPath
{
	static NSString *GameDetailHistoryTableViewCellIdentifier = @"GameDetailHistoryTableViewCellIdentifier";
	UITableViewCell *cell = [argTableView dequeueReusableCellWithIdentifier:GameDetailHistoryTableViewCellIdentifier];
	if (!cell)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GameDetailHistoryTableViewCellIdentifier] autorelease];
		[cell setBackgroundColor:[UIColor kAppYellowColor]];
		// Team Label
		UILabel *tempTeamLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 150.0f, 20.0f)];
		[tempTeamLabel setTag:kTeamLabel];
		[tempTeamLabel setFont:[UIFont systemFontOfSize:14.0f]];
		[tempTeamLabel setBackgroundColor:[UIColor clearColor]];
		[[cell contentView] addSubview:tempTeamLabel];
		[tempTeamLabel release];
		// Bid
		UILabel *tempBidLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 20.0f, 150.0f, 20.0f)];
		[tempBidLabel setTag:kBidLabel];
		[tempBidLabel setFont:[UIFont systemFontOfSize:14.0f]];
		[tempBidLabel setBackgroundColor:[UIColor clearColor]];
		[[cell contentView] addSubview:tempBidLabel];
		[tempBidLabel release];
		// Team13 Score
		UILabel *tempTeam13ScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(150.0f, 0.0f, 75.0f, 40.0f)];
		[tempTeam13ScoreLabel setTag:kTeam13ScoreLabel];
		[tempTeam13ScoreLabel setBackgroundColor:[UIColor clearColor]];
		[[cell contentView] addSubview:tempTeam13ScoreLabel];
		[tempTeam13ScoreLabel release];
		// Team24 Score
		UILabel *tempTeam24ScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(225.0f, 0.0f, 75.0f, 40.0f)];
		[tempTeam24ScoreLabel setTag:kTeam24ScoreLabel];
		[tempTeam24ScoreLabel setBackgroundColor:[UIColor clearColor]];
		[[cell contentView] addSubview:tempTeam24ScoreLabel];
		[tempTeam24ScoreLabel release];
	}
	UILabel *teamLabel = (UILabel*)[cell viewWithTag:kTeamLabel];
	UILabel *bidLabel = (UILabel*)[cell viewWithTag:kBidLabel];
	NSManagedObject *handForCell;
	if ([[[self currentGame] valueForKey:@"gameFinished"] boolValue] == NO && [[[self currentHand] valueForKey:@"winningBidder"] integerValue] < 1)
	{
		handForCell = [[self orderedHands] objectAtIndex:([argIndexPath row] + 1)];
	}
	else
	{
		handForCell = [[self orderedHands] objectAtIndex:[argIndexPath row]];
	}	
	switch ([[handForCell valueForKey:@"winningBidder"] integerValue]) 
	{
		case 1:
			if (gPlaySixBids == NO && [[handForCell valueForKey:@"player1Bid"] integerValue] < k_7Spades)
			{
				[teamLabel setText:@""];
				[bidLabel setText:NSLocalizedString(@"No Winning Bid", @"No Winning Bid")];
			}
			else 
			{
				[teamLabel setText:[[self player1] valueForKey:@"name"]];
				[bidLabel setText:bidNames([[handForCell valueForKey:@"player1Bid"] integerValue])];
				
			}
			break;
		case 2:
			if (gPlaySixBids == NO && [[handForCell valueForKey:@"player2Bid"] integerValue] < k_7Spades)
			{
				[teamLabel setText:@""];
				[bidLabel setText:NSLocalizedString(@"No Winning Bid", @"No Winning Bid")];
			}
			else 
			{
				[teamLabel setText:[[self player2] valueForKey:@"name"]];
				[bidLabel setText:bidNames([[handForCell valueForKey:@"player2Bid"] integerValue])];
			}
			break;
		case 3:
			if (gPlaySixBids == NO && [[handForCell valueForKey:@"player3Bid"] integerValue] < k_7Spades)
			{
				[teamLabel setText:@""];
				[bidLabel setText:NSLocalizedString(@"No Winning Bid", @"No Winning Bid")];
			}
			else 
			{
				[teamLabel setText:[[self player3] valueForKey:@"name"]];
				[bidLabel setText:bidNames([[handForCell valueForKey:@"player3Bid"] integerValue])];
			}
			break;
		case 4:
			if (gPlaySixBids == NO && [[handForCell valueForKey:@"player4Bid"] integerValue] < k_7Spades)
			{
				[teamLabel setText:@""];
				[bidLabel setText:NSLocalizedString(@"No Winning Bid", @"No Winning Bid")];
			}
			else 
			{
				[teamLabel setText:[[self player4] valueForKey:@"name"]];
				[bidLabel setText:bidNames([[handForCell valueForKey:@"player4Bid"] integerValue])];
			}
			break;
		case kNoWinner:
			[teamLabel setText:@""];
			[bidLabel setText:NSLocalizedString(@"No Winning Bid", @"No Winning Bid")];
			break;
		case kMisdeal:
			[teamLabel setText:@""];
			[bidLabel setText:NSLocalizedString(@"Misdeal", @"Misdeal")];
			break;
		default:
			[teamLabel setText:@""];
			[bidLabel setText:@""];
			break;
	}
	UILabel *team13ScoreLabel = (UILabel*)[cell viewWithTag:kTeam13ScoreLabel];
	UILabel *team24ScoreLabel = (UILabel*)[cell viewWithTag:kTeam24ScoreLabel];
	if ([argIndexPath row] == 0 && [[handForCell valueForKey:@"handComplete"] boolValue] == NO)
	{
		[team13ScoreLabel setText:@""];
		[team24ScoreLabel setText:@""];
	}
	else 
	{
		int tempTeam13Score = [[handForCell valueForKey:@"team13ScoreTotal"] integerValue];
		int tempTeam24Score = [[handForCell valueForKey:@"team24ScoreTotal"] integerValue];
		[team13ScoreLabel setText:[self formatScores:tempTeam13Score]];
		[team24ScoreLabel setText:[self formatScores:tempTeam24Score]];
	}
	handForCell = nil;
	return cell;
}

#pragma mark -
#pragma mark GameDetailPlayerView Delegate Methods

- (void)mainActionButtonPressed
{
	if ([[[self currentHand] valueForKey:@"biddingComplete"] boolValue] == YES)
	{
		if (![self recordTricksViewController])
		{
			RecordTricksViewController *tempRecordTricksViewController = [[RecordTricksViewController alloc] init];
			[tempRecordTricksViewController setDelegate:self];
			[self setRecordTricksViewController:tempRecordTricksViewController];
			[tempRecordTricksViewController release];
		}
		[[self recordTricksViewController] setCurrentHand:[self currentHand]];
		[[self navigationController] pushViewController:[self recordTricksViewController] animated:YES];
	}
	else 
	{
		if (![self recordBidsViewController])
		{
			RecordBidsViewController *tempRecordBidsViewController = [[RecordBidsViewController	alloc] init];
			[tempRecordBidsViewController setDelegate:self];
			[self setRecordBidsViewController:tempRecordBidsViewController];
			[tempRecordBidsViewController release];
		}	
		[[self recordBidsViewController] setCurrentHand:[self currentHand]];
		[[self navigationController] pushViewController:[self recordBidsViewController] animated:YES];
	}
}

- (BOOL)shouldChangeDealerToPlayer:(NSInteger)argPlayer
{
	if ([[[self currentGame] valueForKey:@"gameFinished"] boolValue] == YES || argPlayer == [[[self currentHand] valueForKey:@"dealer"] integerValue] || [[[self currentHand] valueForKey:@"biddingComplete"] boolValue] == YES)
		return NO;
	else if ([[[self currentHand] valueForKey:@"biddingComplete"] boolValue] == NO && ([[[self currentHand] valueForKey:@"player1Bid"] integerValue] >= 0 || [[[self currentHand] valueForKey:@"player2Bid"] integerValue] >= 0 || [[[self currentHand] valueForKey:@"player3Bid"] integerValue] >= 0 || [[[self currentHand] valueForKey:@"player4Bid"] integerValue] >= 0 ))
	{
		UIAlertView *existingBidAlertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Warning - Existing Bids", @"Warning - Existing Bids") message:NSLocalizedString(@"There are existing bids, would you like to clear the bids and change the dealer?", @"There are existing bids, would you like to clear teh bids and change the dealer?") delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"Cancel") otherButtonTitles:NSLocalizedString(@"OK", @"OK"), nil];	
		[existingBidAlertView show];
		[existingBidAlertView release];
		switchDealerRequested = argPlayer;
		return NO;
	}
	[[self currentHand] setValue:[NSNumber numberWithInt:argPlayer] forKey:@"dealer"];
	[[self managedObjectContext] save:NULL];
	return YES;
}

#pragma mark -
#pragma mark RecordBidsDelegate Methods

- (NSString*)player1Name
{
	return [[self player1] valueForKey:@"name"];
}

- (NSString*)player2Name
{
	return [[self player2] valueForKey:@"name"];
}

- (NSString*)player3Name
{
	return [[self player3] valueForKey:@"name"];
}

- (NSString*)player4Name
{
	return [[self player4] valueForKey:@"name"];
}

- (void)handCompletedAsMisdeal
{
	if ([[self orderedHands] count] >= 3 && [[[[self orderedHands] objectAtIndex:1] valueForKey:@"winningBidder"] integerValue] == kMisdeal && [[[[self orderedHands] objectAtIndex:2] valueForKey:@"winningBidder"] integerValue] == kMisdeal)
	{
		int tempDealer = [[[self currentHand] valueForKey:@"dealer"] integerValue] + 1;
		if (tempDealer > 4)
			tempDealer = tempDealer - 4;
		[self addNewHandWithDealer:tempDealer];
	 }
	 else
		[self addNewHandWithDealer:[[[self currentHand] valueForKey:@"dealer"] integerValue]];
}

#pragma mark -
#pragma mark RecordTricksDelegate Methods

- (NSString*)winningTeamName
{
	switch ([[[self currentHand] valueForKey:@"winningBidder"] integerValue]) 
	{
		case 1:
			return [NSString stringWithFormat:@"%@ / %@", [[self player1] valueForKey:@"name"], [[self player3] valueForKey:@"name"]];
			break;
		case 2:
			return [NSString stringWithFormat:@"%@ / %@", [[self player2] valueForKey:@"name"], [[self player4] valueForKey:@"name"]];
			break;
		case 3:
			return [NSString stringWithFormat:@"%@ / %@", [[self player3] valueForKey:@"name"], [[self player1] valueForKey:@"name"]];
			break;
		case 4:
			return [NSString stringWithFormat:@"%@ / %@", [[self player4] valueForKey:@"name"], [[self player2] valueForKey:@"name"]];
			break;
		default:
			return [NSString stringWithFormat:@"%@ / %@", [[self player1] valueForKey:@"name"], [[self player3] valueForKey:@"name"]];
			break;
	}
}

- (void)handCompleted
{
	NSNumber *tempTeam13Score = [[self currentHand] valueForKey:@"team13ScoreTotal"];
	[[self currentGame] setValue:tempTeam13Score forKey:@"team13Score"];
	NSNumber *tempTeam13BidScore = [[self currentHand] valueForKey:@"team13ScoreBidPoints"];
	[[self currentGame] setValue:tempTeam13BidScore forKey:@"team13BidScore"];
	NSNumber *tempTeam24Score = [[self currentHand] valueForKey:@"team24ScoreTotal"];
	[[self currentGame] setValue:tempTeam24Score forKey:@"team24Score"];
	NSNumber *tempTeam24BidScore = [[self currentHand] valueForKey:@"team24ScoreBidPoints"];
	[[self currentGame] setValue:tempTeam24BidScore forKey:@"team24BidScore"];
	if (gEnableTournamentMode == YES && gTournamentModeNumberOFHands == [[self orderedHands] count])
	{
		[[self currentGame] setValue:[NSNumber numberWithBool:YES] forKey:@"gameFinished"];
	}
	else if (([[[self currentGame] valueForKey:@"team13BidScore"] integerValue] >= 500 || [[[self currentGame] valueForKey:@"team24BidScore"] integerValue] >= 500) && gEnableTournamentMode == NO && gRequireBidPointsForWin == YES && [[[self currentGame] valueForKey:@"team13BidScore"] integerValue] != [[[self currentGame] valueForKey:@"team24BidScore"] integerValue])
	{
		[[self currentGame] setValue:[NSNumber numberWithBool:YES] forKey:@"gameFinished"];
	}
	else if (([[[self currentGame] valueForKey:@"team13Score"] integerValue] >= 500 || [[[self currentGame] valueForKey:@"team24Score"] integerValue] >= 500) && gEnableTournamentMode == NO && gRequireBidPointsForWin == NO && [[[self currentGame] valueForKey:@"team13BidScore"] integerValue] != [[[self currentGame] valueForKey:@"team24BidScore"] integerValue])
	{
		[[self currentGame] setValue:[NSNumber numberWithBool:YES] forKey:@"gameFinished"];
	}
	else if (gEnableNegativeScoreLoss == YES && (([[[self currentGame] valueForKey:@"team24Score"] integerValue] <= -500 && [[[self currentGame] valueForKey:@"team13Score"] integerValue] >= 0) || ([[[self currentGame] valueForKey:@"team13Score"] integerValue] <= -500 && [[[self currentGame] valueForKey:@"team24Score"] integerValue] >= 0)) && gEnableTournamentMode == NO)
	{
		[[self currentGame] setValue:[NSNumber numberWithBool:YES] forKey:@"gameFinished"];
	}
	else
	{
		int nextDealer = [[[self currentHand] valueForKey:@"dealer"] integerValue] + 1;
		if (nextDealer > 4)
			nextDealer = nextDealer - 4;
		[self addNewHandWithDealer:nextDealer];
	}
	[[self managedObjectContext] save:NULL];
	[self refreshMainActionButton];
	[[self gameDetailHistoryView] reloadData];
}

#pragma mark -
#pragma mark UITextFieldDelegate Methods

- (BOOL)textFieldShouldReturn:(UITextField*)argTextField
{
	[argTextField resignFirstResponder];
	return YES;
}

- (void)textFieldDidEndEditing:(UITextField*)argTextField
{
	if ([[[[self gameDetailPlayerView] player1TextField] text] isEqual:@""])
		[[[self gameDetailPlayerView] player1TextField] setText:NSLocalizedString(@"Player 1", @"Player 1")];	
	[player1 setValue:[[[self gameDetailPlayerView] player1TextField] text] forKey:@"name"];
	if ([[[[self gameDetailPlayerView] player2TextField] text] isEqual:@""])
		[[[self gameDetailPlayerView] player2TextField] setText:NSLocalizedString(@"Player 2", @"Player 2")];
	[player2 setValue:[[[self gameDetailPlayerView] player2TextField] text] forKey:@"name"];
	if ([[[[self gameDetailPlayerView] player3TextField] text] isEqual:@""])
		[[[self gameDetailPlayerView] player3TextField] setText:NSLocalizedString(@"Player 3", @"Player 3")];
	[player3 setValue:[[[self gameDetailPlayerView] player3TextField] text] forKey:@"name"];
	if ([[[[self gameDetailPlayerView] player4TextField] text] isEqual:@""])
		[[[self gameDetailPlayerView] player4TextField] setText:NSLocalizedString(@"Player 4", @"Player 4")];
	[player4 setValue:[[[self gameDetailPlayerView] player4TextField] text] forKey:@"name"];
	NSError *error;
	if (![[self managedObjectContext] save:&error])
		NSLog(@"%@", [error localizedDescription]);
	[self refreshNames];
}

- (void)textFieldDidBeginEditing:(UITextField*)argTextField
{
	if ([[argTextField text] isEqual:NSLocalizedString(@"Player 1", @"Player 1")] || [[argTextField text] isEqual:NSLocalizedString(@"Player 2", @"Player 2")] || [[argTextField text] isEqual:NSLocalizedString(@"Player 3", @"Player 3")] || [[argTextField text] isEqual:NSLocalizedString(@"Player 4", @"Player 4")])
	{
		[argTextField setText:@""];
	}
}

#pragma mark -
#pragma mark UIAlertViewDelegate Methods

- (void)alertView:(UIAlertView*)argAlertView willDismissWithButtonIndex:(NSInteger)argButtonIndex
{
	if (argButtonIndex != [argAlertView cancelButtonIndex])
	{
		if (switchDealerRequested == 0)
			NSLog(@"Error - Trying to switch a dealer without information");
		[[self currentHand] setValue:[NSNumber numberWithInt:switchDealerRequested] forKey:@"dealer"];
		[[self gameDetailPlayerView] moveDealerToPlayer:switchDealerRequested];
		[[self currentHand] setValue:[NSNumber numberWithInt:-1] forKey:@"player1Bid"];
		[[self currentHand] setValue:[NSNumber numberWithInt:-1] forKey:@"player2Bid"];
		[[self currentHand] setValue:[NSNumber numberWithInt:-1] forKey:@"player3Bid"];
		[[self currentHand] setValue:[NSNumber numberWithInt:-1] forKey:@"player4Bid"];
		[[self gameDetailHistoryView] reloadData];
	}
	switchDealerRequested = 0;
}

@synthesize gameDetailHistoryView;
@synthesize gameDetailPlayerView;
@synthesize recordBidsViewController;
@synthesize recordTricksViewController;
@synthesize managedObjectContext;
@synthesize newGameFlag;
@synthesize currentGame;
@synthesize player1;
@synthesize player2;
@synthesize player3;
@synthesize player4;
@synthesize orderedHands;
@synthesize shadowHolder;
@end
