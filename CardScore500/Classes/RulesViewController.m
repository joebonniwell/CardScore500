    //
//  RulesViewController.m
//  UserInterface
//
//  Created by Joe Bonniwell on 9/18/10.
//  Copyright 2010 Joe Bonniwell. All rights reserved.
//
#define kShowHideChartButton 707

#import "RulesViewController.h"

@implementation RulesViewController

- (void)loadView 
{
	UIView *tempRulesView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 460.0f)];
	[self setView:tempRulesView];
	[tempRulesView release];
	[[self view] setBackgroundColor:[UIColor kAppYellowColor]];
	// Show/Hide Chart Button
	UIBarButtonItem *showHideChartButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(showHideChart)];
	[showHideChartButton setTag:kShowHideChartButton];
	[[self navigationItem] setRightBarButtonItem:showHideChartButton];
	// Score Chart
	theScoreChart = [[ScoreChart alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 200.0f)];
	[[self view] addSubview:theScoreChart];
	[theScoreChart release];
	// Show Score Chart
	showChart = YES;	// TODO: Read this from NSUserDefaults
	// Rules View
	UIWebView *tempRulesWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0f, 220.0f, 320.0f, 194.0f)];
	[tempRulesWebView setBackgroundColor:[UIColor kAppYellowColor]];
	[self setRulesWebView:tempRulesWebView];
	[[self view] addSubview:[self rulesWebView]];
	[tempRulesWebView release];
}

- (void)viewDidLoad 
{
    [super viewDidLoad];
	if (!showChart)
	{
		[[[self navigationItem] rightBarButtonItem] setTitle:NSLocalizedString(@"Show Chart", @"Show Chart")];
		[theScoreChart setHidden:YES];
	}
	else 
	{
		[[[self navigationItem] rightBarButtonItem] setTitle:NSLocalizedString(@"Hide Chart", @"Hide Chart")];
		[theScoreChart setHidden:NO];
	}	
	// TODO: Get rid of this garbarge
	NSString *htmlString = @"<html><body bgcolor=\"#FFFFB3\"><h4>Setup</h4><p>The standard deck contains 45 cards, including 1 joker and excluding all 2s and 3s.</p><h4>Deal</h4><p>Deal, bidding and play proceed clockwise. Each player is dealt 10 cards and 5 cards are placed face down in the middle of the table to form the kitty.</p><h4>Bidding</h4><p>Bidding begins with the player to the dealer's left. Each player in turn must choose a bid higher than those previously bid, or pass. If there is no winning bid after all players have bid, the hand can be declared a misdeal and immediately re-dealt, or played as a no trump hand with 10 points awarded per trick taken.</p><p>The winning player is allowed to trade cards with the kitty, retaining 10 cards for his or her hand, and the others remaining facedown on the table for the duration of the hand. If the winning bid is Double Misere, then first the player that placed the bid has the opportunity to exchange cards in the kitty. The new kitty is then passed to the player's partner who has a change to exchange cards.</p><h4>GamePlay</h4><p>Play begins usually begins with the winning player (except in the case of Misere or Double Misere, see below). Each player plays a card, and the player playing the highest card wins the hand. The winner of the previous hand now leads the next hand, and play continues until all 10 hands have been played.</p><p>For a winning bid of Misere or Double Misere, the goal of the contracting team is to avoid taking any tricks. For Misere gameplay starts with the player immediately behind(counterclockwise) the contracting player. For double Misere gameplay starts with the player behind the bidder of Double Misere.</p><h4>ScoreKeeping</h4><p>If the contracting team is successful in taking the amount of tricks bid or more, they are awarded the value of the bid. If they are unsuccessful the value of the bid is subtracted from their current score. The opposing team is awarded 10 points per trick taken, or in the case of Misere, 10 points per trick taken by the contracting team.</p><h4>Variations</h4><p>There are many variations of rules for 500. If you have variations to include or suggestions for changes to this set of rules, please contact us via the email link in the information screen from the games table.</p></body></html>";
	[[self rulesWebView] loadHTMLString:htmlString baseURL:NULL];
}


- (void)didReceiveMemoryWarning 
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload 
{
    [super viewDidUnload];
    [self setRulesWebView:nil];
}

- (void)dealloc 
{
	[rulesWebView release];
    [super dealloc];
}

#pragma mark -
#pragma mark Other Methods

- (void)showHideChart
{
	if (showChart)
	{
		// Hide the chart
		[[[self navigationItem] rightBarButtonItem] setTitle:NSLocalizedString(@"Show Chart", @"Show Chart")];
		[theScoreChart setHidden:YES];
		[[self rulesWebView] setFrame:CGRectMake(0.0f, 0.0f, 320.0f, 416.0f)];
	}
	else 
	{
		// Show the chart
		[[[self navigationItem] rightBarButtonItem] setTitle:NSLocalizedString(@"Hide Chart", @"Hide Chart")];
		[theScoreChart setHidden:NO];
		[[self rulesWebView] setFrame:CGRectMake(0.0f, 220.0f, 320.0f, 194.0f)];
	}
	showChart = !showChart;
}

@synthesize rulesWebView;

@end


