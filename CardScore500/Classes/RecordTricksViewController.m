    //
//  RecordTricksViewController.m
//  UserInterface
//
//  Created by Joe Bonniwell on 9/29/10.
//  Copyright 2010 Joe Bonniwell. All rights reserved.
//

#import "RecordTricksViewController.h"
#import "StickPersonView.h"
#import "CurvedShadow.h"

@implementation RecordTricksViewController

- (void)loadView 
{
	// Navigation Item
	[[self navigationItem] setTitle:NSLocalizedString(@"Record Tricks", @"Record Tricks")];
	// Main View
	UIView *tempMainView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 480.0f)];
	[tempMainView setBackgroundColor:[UIColor kAppYellowColor]];
	[self setView:tempMainView];
	[tempMainView release];
	// TableView
	UITableView *tempTricksTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 152.0f, 320.0f, 220.0f) style:UITableViewStylePlain];
	[tempTricksTableView setDelegate:self];
	[tempTricksTableView setDataSource:self];
	[tempTricksTableView setBackgroundColor:[UIColor kAppYellowColor]];
	[self setTricksTableView:tempTricksTableView];
	[[self view] addSubview:[self tricksTableView]];
	[tempTricksTableView release];
	// Shadow
	CurvedShadow *curvedShadow = [[CurvedShadow alloc] initWithFrame:CGRectMake(0.0f, 152.0f, 320.0f, 10.0f)];
	[self setShadowHolder:curvedShadow];
	[curvedShadow release];
	[[self view] addSubview:[self shadowHolder]];
	[[self shadowHolder] setHidden:YES];
	// Toolbar with record tricks button
	UIToolbar *tempBottomToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 372.0f, 320.0f, 44.0f)];
	[tempBottomToolbar setBarStyle:UIBarStyleDefault];
	[tempBottomToolbar setTintColor:[UIColor brownColor]];
	[self setBottomToolbar:tempBottomToolbar];
	[[self view] addSubview:[self bottomToolbar]];
	[tempBottomToolbar release];
	// RecordTricks toolbar button
	UIBarButtonItem *tempRecordTricksButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Record Tricks", @"Record Tricks") style:UIBarButtonItemStyleBordered target:self action:@selector(recordTricks)];
	[tempRecordTricksButton setWidth:300.0f];
	[tempRecordTricksButton setEnabled:NO];
	UIBarButtonItem *tempFlexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	NSArray *tempToolbarItems = [NSArray arrayWithObjects:tempFlexibleSpace, tempRecordTricksButton, tempFlexibleSpace, nil];
	[[self bottomToolbar] setItems:tempToolbarItems];
	// Header view with teams
	StickPersonView *tempPlayerA = [[StickPersonView alloc] initWithFrame:CGRectMake(10.0f, 18.0f, 30.0f, 60.0f)];
	[[self view] addSubview:tempPlayerA];
	[tempPlayerA release];
	StickPersonView *tempPlayerB = [[StickPersonView alloc] initWithFrame:CGRectMake(30.0, 76.0f, 30.0f, 60.0f)];
	[[self view] addSubview:tempPlayerB];
	[tempPlayerB release];
	// Labels
	UILabel *tempRecordTricksLabel = [[UILabel alloc] initWithFrame:CGRectMake(60.0f, 13.0f, 260.0f, 50.0f)];
	[tempRecordTricksLabel setText:NSLocalizedString(@"Record tricks taken by:", @"Record tricks taken by:")];
	[tempRecordTricksLabel setBackgroundColor:[UIColor kAppYellowColor]];
	[[self view] addSubview:tempRecordTricksLabel];
	[tempRecordTricksLabel release];
	UILabel *tempTeamNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80.0f, 76.0f, 240.0f, 50.0f)];
	[tempTeamNameLabel setBackgroundColor:[UIColor kAppYellowColor]];
	[self setTeamNameLabel:tempTeamNameLabel];
	[[self view] addSubview:[self teamNameLabel]];
	[tempTeamNameLabel release];
	// Reset selectedTricks
	selectedTricks = -1;
}

- (void)viewWillAppear:(BOOL)argAnimated
{
	[[self teamNameLabel] setText:[delegate winningTeamName]];
}

- (void)viewDidAppear:(BOOL)animated
{
	[[self tricksTableView] scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

- (void)viewDidUnload 
{
	[self setTeamNameLabel:nil];
	[self setDelegate:nil];
	[self setTricksTableView:nil];
    [super viewDidUnload];
}

- (void)dealloc 
{
	[teamNameLabel release];
	[tricksTableView release];
    [super dealloc];
}

- (void)recordTricks
{
	if (selectedTricks < 0)
		return;
	[[self currentHand] setValue:[NSNumber numberWithInt:selectedTricks] forKey:@"winningBidTeamTricksTaken"];
	int tempWinningBidder = [[[self currentHand] valueForKey:@"winningBidder"] integerValue];
	if (tempWinningBidder == kNoWinner)	// No winning bidder
	{
		[[self currentHand] setValue:[NSNumber numberWithInt:(selectedTricks * 10.0)] forKey:@"team13OppositionPoints"];
		[[self currentHand] setValue:[NSNumber numberWithInt:((10 - selectedTricks) * 10.0)] forKey:@"team24OppositionPoints"];
	}
	else if (gPlaySixBids == NO && ([[[self currentHand] valueForKey:[NSString stringWithFormat:@"player%dBid", tempWinningBidder]] integerValue] < k_7Spades))	// 6 Bid winner, but playSixBids is NO
	{
		[[self currentHand] setValue:[NSNumber numberWithInt:(selectedTricks * 10.0)] forKey:@"team13OppositionPoints"];
		[[self currentHand] setValue:[NSNumber numberWithInt:((10 - selectedTricks) * 10.0)] forKey:@"team24OppositionPoints"];
	}
	else 
	{
		int tempWinningBid = [[[self currentHand] valueForKey:[NSString stringWithFormat:@"player%dBid", tempWinningBidder]] integerValue];
		if (selectedTricks >= bidMinTricks[tempWinningBid] && selectedTricks <= bidMaxTricks[tempWinningBid])
		{	
			if (tempWinningBidder == 1 || tempWinningBidder == 3)
			{
				if (gEnableSlams == YES && selectedTricks == 10 && tempWinningBid < k_SingleLow)
					[[self currentHand] setValue:[NSNumber numberWithInt:250] forKey:@"team13BidPoints"];
				else // Higher bid, or incomplete slam
					[[self currentHand] setValue:[NSNumber numberWithInt:bidPoints[tempWinningBid]] forKey:@"team13BidPoints"];
				// Award opposition points
				if (tempWinningBid == k_SingleLow || tempWinningBid == k_DoubleLow)
				{
					[[self currentHand] setValue:[NSNumber numberWithInt:0] forKey:@"team24OppositionPoints"];
					[[self currentHand] setValue:[NSNumber numberWithInt:0] forKey:@"team24BidPoints"];
				}
				else 
					[[self currentHand] setValue:[NSNumber numberWithInt:((10 - selectedTricks) * 10.0)] forKey:@"team24OppositionPoints"];
			}
			else 
			{
				if (gEnableSlams == YES && selectedTricks == 10 && tempWinningBid < k_SingleLow)
					[[self currentHand] setValue:[NSNumber numberWithInt:250] forKey:@"team24BidPoints"];
				else // Higher bid, or incomplete slam
					[[self currentHand] setValue:[NSNumber numberWithInt:bidPoints[tempWinningBid]] forKey:@"team24BidPoints"];
				// Award opposition points
				if (tempWinningBid == k_SingleLow || tempWinningBid == k_DoubleLow)
				{
					[[self currentHand] setValue:[NSNumber numberWithInt:0] forKey:@"team13OppositionPoints"];
					[[self currentHand] setValue:[NSNumber numberWithInt:0] forKey:@"team13BidPoints"];
				}
				else
					[[self currentHand] setValue:[NSNumber numberWithInt:((10 - selectedTricks) * 10.0)] forKey:@"team13OppositionPoints"];
			}
		}
		else // Bid Failure
		{
			if (tempWinningBidder == 1 || tempWinningBidder == 3)
			{
				[[self currentHand] setValue:[NSNumber numberWithInt:(-1.0 * bidPoints[tempWinningBid])] forKey:@"team13BidPoints"];
				if (tempWinningBid == k_SingleLow || tempWinningBid == k_DoubleLow)
					[[self currentHand] setValue:[NSNumber numberWithInt:(selectedTricks * 10.0)] forKey:@"team24OppositionPoints"];
				else
					[[self currentHand] setValue:[NSNumber numberWithInt:((10 - selectedTricks) * 10.0)] forKey:@"team24OppositionPoints"];
			}
			else 
			{
				[[self currentHand] setValue:[NSNumber numberWithInt:(-1.0 * bidPoints[tempWinningBid])] forKey:@"team24BidPoints"];
				if (tempWinningBid == k_SingleLow || tempWinningBid == k_DoubleLow)
					[[self currentHand] setValue:[NSNumber numberWithInt:(selectedTricks * 10.0)] forKey:@"team13OppositionPoints"];
				else
					[[self currentHand] setValue:[NSNumber numberWithInt:((10 - selectedTricks) * 10.0)] forKey:@"team13OppositionPoints"];
			}
		}
	}
	// Reset selectedTricks
	selectedTricks = -1;
	// Disable the recordTricksbutton
	UIBarButtonItem *recordTricksButton = [[[self bottomToolbar] items] objectAtIndex:1];
	[recordTricksButton setEnabled:NO];
	// Team13
	int tempTeam13ScoreBidPoints = [[[self currentHand] valueForKey:@"team13BidPoints"] integerValue] + [[[self currentHand] valueForKey:@"team13ScoreBidPoints"] integerValue];
	int tempTeam13ScoreTotal = [[[self currentHand] valueForKey:@"team13BidPoints"] integerValue] + [[[self currentHand] valueForKey:@"team13OppositionPoints"] integerValue] + [[[self currentHand] valueForKey:@"team13ScoreTotal"] integerValue];
	[[self currentHand] setValue:[NSNumber numberWithInt:tempTeam13ScoreBidPoints] forKey:@"team13ScoreBidPoints"];
	[[self currentHand] setValue:[NSNumber numberWithInt:tempTeam13ScoreTotal] forKey:@"team13ScoreTotal"];	
	// Team24
	int tempTeam24ScoreBidPoints = [[[self currentHand] valueForKey:@"team24BidPoints"] integerValue] + [[[self currentHand] valueForKey:@"team24ScoreBidPoints"] integerValue];
	int tempTeam24ScoreTotal = [[[self currentHand] valueForKey:@"team24BidPoints"] integerValue] + [[[self currentHand] valueForKey:@"team24OppositionPoints"] integerValue] + [[[self currentHand] valueForKey:@"team24ScoreTotal"] integerValue];
	[[self currentHand] setValue:[NSNumber numberWithInt:tempTeam24ScoreBidPoints] forKey:@"team24ScoreBidPoints"];
	[[self currentHand] setValue:[NSNumber numberWithInt:tempTeam24ScoreTotal] forKey:@"team24ScoreTotal"];
	// Set Hand Complete
	[[self currentHand] setValue:[NSNumber numberWithBool:YES] forKey:@"handComplete"];
	// Trigger an update to the game scores in the GameDetailViewController, also checks if the game is finished and what not
	[delegate handCompleted];
	[[self navigationController] popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark TableView Delegate

- (void)scrollViewDidScroll:(UIScrollView*)argScrollView
{
	[[self shadowHolder] setHidden:NO];
}

- (void)scrollViewDidEndDragging:(UIScrollView*)argScrollView willDecelerate:(BOOL)argDecelerate
{
	if (argDecelerate == NO)
	{
		NSArray *indexes = [[self tricksTableView] indexPathsForVisibleRows];
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
	NSArray *indexes = [[self tricksTableView] indexPathsForVisibleRows];
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
	selectedTricks = [argIndexPath row];
	[argTableView reloadData];
	[argTableView deselectRowAtIndexPath:argIndexPath animated:YES];
	// Enable the recordTricksButton
	UIBarButtonItem *recordTricksButton = [[[self bottomToolbar] items] objectAtIndex:1];
	[recordTricksButton setEnabled:YES];
}

#pragma mark -
#pragma mark TableView DataSource

- (NSInteger)tableView:(UITableView*)argTableView numberOfRowsInSection:(NSInteger)argSection
{
	return 11;	// 0 through 10 Tricks 
}

- (UITableViewCell*)tableView:(UITableView*)argTableView cellForRowAtIndexPath:(NSIndexPath*)argIndexPath
{
	NSString *RecordTricksTableCellIdentifier = @"RecordTricksTableCellIdentifier";
	UITableViewCell *cell = [argTableView dequeueReusableCellWithIdentifier:RecordTricksTableCellIdentifier];
	if (!cell)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RecordTricksTableCellIdentifier];
		[cell setBackgroundColor:[UIColor kAppYellowColor]];
	}
	[[cell textLabel] setTextAlignment:UITextAlignmentCenter];
	[[cell textLabel] setText:[NSString stringWithFormat:@"%d Tricks", [argIndexPath row]]];
	if ([argIndexPath row] == selectedTricks)
		[cell setAccessoryType:UITableViewCellAccessoryCheckmark];
	else
		[cell setAccessoryType:UITableViewCellAccessoryNone];
	return cell;
}

@synthesize teamNameLabel;
@synthesize delegate;
@synthesize currentHand;
@synthesize tricksTableView;
@synthesize bottomToolbar;
@synthesize shadowHolder;
@end
