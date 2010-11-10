//
//  GamesTableViewController.m
//  UserInterface
//
//  Created by Joe Bonniwell on 9/7/10.
//  Copyright 2010 Joe Bonniwell. All rights reserved.
//



#import "GamesViewController.h"
#import "CardScore500AppDelegate.h"
@implementation GamesViewController

- (void)loadView
{
	// FetchResultsController
	NSFetchRequest *gamesFetchRequest = [[NSFetchRequest alloc] init];
	[gamesFetchRequest setEntity:[NSEntityDescription entityForName:@"Game" inManagedObjectContext:[self managedObjectContext]]];
	NSSortDescriptor *gameFinishedSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"gameFinished" ascending:YES];
	NSSortDescriptor *dateCreatedSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"dateStarted" ascending:NO];
	NSArray *sortDescriptors = [[NSArray alloc]  initWithObjects:gameFinishedSortDescriptor, dateCreatedSortDescriptor, nil];
	[gamesFetchRequest setSortDescriptors:sortDescriptors];
	[gamesFetchRequest setFetchBatchSize:20];
	NSFetchedResultsController *tempGamesFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:gamesFetchRequest managedObjectContext:[self managedObjectContext] sectionNameKeyPath:@"gameFinished" cacheName:nil];
	[tempGamesFetchedResultsController setDelegate:self];
	[self setGamesFetchedResultsController:tempGamesFetchedResultsController];
	NSError *error;
	if (![[self gamesFetchedResultsController] performFetch:&error])
	{
		// TODO: Error handling
		NSLog(@"Initial Fetch Error: %@", [error localizedDescription]);
	}
	[tempGamesFetchedResultsController release];
	[gamesFetchRequest release];
	[gameFinishedSortDescriptor release];
	[dateCreatedSortDescriptor release];
	[sortDescriptors release];
	// Main View
	UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 460.0f)];
	[self setView:mainView];
	[mainView release];
	// Navigation Items
	[[self navigationItem] setTitle:NSLocalizedString(@"Games", @"Games")];
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createNewGame)];
	[[self navigationItem] setRightBarButtonItem:addButton];
	// Toolbar
	UIToolbar *bottomToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 376.0f, 320.0f, 44.0f)];
	[bottomToolbar setTintColor:[UIColor brownColor]];
	// Toolbar Info Button
	UIBarButtonItem *infoButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Info", @"Info") style:UIBarButtonItemStyleBordered target:self action:@selector(showInformation)];
	// Toolbar flexible space
	UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	// Toolbar Settings Button
	UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Settings", @"Settings") style:UIBarButtonItemStyleBordered target:self action:@selector(showSettings)];
	// Toolbar Items Setup
	[bottomToolbar setItems:[NSArray arrayWithObjects:settingsButton, flexibleSpace, infoButton, nil]];	 
	[[self view] addSubview:bottomToolbar];
	[bottomToolbar release];
	[infoButton release];
	[settingsButton release];
	[flexibleSpace release];
	// TableView
	gamesTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 376.0f) style:UITableViewStyleGrouped];
	[gamesTableView setDelegate:self];
	[gamesTableView setDataSource:self];
	[gamesTableView setBackgroundColor:[UIColor kAppYellowColor]];
	[[self view] addSubview:gamesTableView];
	[gamesTableView release];
}

- (void)viewWillAppear:(BOOL)animated
{
	// Save
	NSError *error;
	if (![[self managedObjectContext] save:&error])
	{
		// Handle the error
		NSLog(@"Save new game error: %@", [error localizedDescription]);
	}
	[gamesTableView reloadData];
	if ([[[self gamesFetchedResultsController] sections] count] == 0)
	{
		[[self navigationItem] setLeftBarButtonItem:nil];
	}
	else 
	{
		[[self navigationItem] setLeftBarButtonItem:[self editButtonItem]];
	}
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
	[gameDetailViewController release];
	gameDetailViewController = nil;
	[gamesFetchedResultsController release];
	gamesFetchedResultsController = nil;
	[managedObjectContext release];
	managedObjectContext = nil;
}

- (void)dealloc 
{
	[gameDetailViewController release];
	[gamesFetchedResultsController release];
	[managedObjectContext release];
    [super dealloc];
}

#pragma mark -
#pragma mark Other Methods

- (void)createNewGame
{
	NSManagedObject *mostRecentGame = nil;
	NSUInteger firstIndex[2] = {0, 0};
	NSUInteger secondIndex[2] = {1, 0};
	NSIndexPath *mostRecentInProgressIndexPath = [NSIndexPath indexPathWithIndexes:firstIndex length:2];
	NSIndexPath *mostRecentFinishedIndexPath = [NSIndexPath indexPathWithIndexes:secondIndex length:2];
	if ([[[self gamesFetchedResultsController] sections] count])
	{
		if ([[[self gamesFetchedResultsController] sections] count] == 2)
		{
			NSManagedObject *mostRecentInProgressGame = [[self gamesFetchedResultsController] objectAtIndexPath:mostRecentInProgressIndexPath];
			NSManagedObject *mostRecentFinishedGame = [[self gamesFetchedResultsController] objectAtIndexPath:mostRecentFinishedIndexPath];
			if ([[mostRecentFinishedGame valueForKey:@"dateStarted"] compare:[mostRecentInProgressGame valueForKey:@"dateStarted"]] == NSOrderedAscending)
			{
				mostRecentGame = mostRecentFinishedGame;
			}
			else 
			{
				mostRecentGame = mostRecentInProgressGame;
			}
		}
		else 
		{
			mostRecentGame = [[self gamesFetchedResultsController] objectAtIndexPath:[NSIndexPath indexPathWithIndexes:firstIndex length:2]];
		}
	}
	NSManagedObject *newGame = [[NSEntityDescription insertNewObjectForEntityForName:@"Game" inManagedObjectContext:[self managedObjectContext]] retain];
	[newGame setValue:[NSDate date] forKey:@"dateStarted"];
	[newGame setValue:[NSNumber numberWithBool:NO] forKey:@"gameFinished"];
	[newGame setValue:[NSNumber numberWithInt:0] forKey:@"team13Score"];
	[newGame setValue:[NSNumber numberWithInt:0] forKey:@"team24Score"];
	// Create the players
	NSManagedObject *player1 = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:[self managedObjectContext]];
	NSManagedObject *player2 = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:[self managedObjectContext]];
	NSManagedObject *player3 = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:[self managedObjectContext]];
	NSManagedObject *player4 = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:[self managedObjectContext]];
	// Configure the players
	if (mostRecentGame)
	{
		NSManagedObject *recentPlayer1 = [mostRecentGame valueForKey:@"player1"];
		NSManagedObject *recentPlayer2 = [mostRecentGame valueForKey:@"player2"];
		NSManagedObject *recentPlayer3 = [mostRecentGame valueForKey:@"player3"];
		NSManagedObject *recentPlayer4 = [mostRecentGame valueForKey:@"player4"];
		[player1 setValue:[recentPlayer1 valueForKey:@"name"] forKey:@"name"];
		[player2 setValue:[recentPlayer2 valueForKey:@"name"] forKey:@"name"];
		[player3 setValue:[recentPlayer3 valueForKey:@"name"] forKey:@"name"];
		[player4 setValue:[recentPlayer4 valueForKey:@"name"] forKey:@"name"];		
	}
	else 
	{
		[player1 setValue:NSLocalizedString(@"Player 1", @"Player 1") forKey:@"name"];
		[player2 setValue:NSLocalizedString(@"Player 2", @"Player 2") forKey:@"name"];
		[player3 setValue:NSLocalizedString(@"Player 3", @"Player 3") forKey:@"name"];
		[player4 setValue:NSLocalizedString(@"Player 4", @"Player 4") forKey:@"name"];
	}
	// Set the players
	[newGame setValue:player1 forKey:@"player1"];
	[newGame setValue:player2 forKey:@"player2"];
	[newGame setValue:player3 forKey:@"player3"];
	[newGame setValue:player4 forKey:@"player4"];
	// Create the hands
	NSMutableSet *hands = [newGame mutableSetValueForKey:@"hands"];
	NSManagedObject *initialHand = [NSEntityDescription insertNewObjectForEntityForName:@"Hand" inManagedObjectContext:[self managedObjectContext]];
	[initialHand setValue:0 forKey:@"index"];
	[initialHand setValue:[NSNumber numberWithInt:1] forKey:@"dealer"];
	[initialHand setValue:[NSNumber numberWithBool:NO] forKey:@"biddingComplete"];
	[initialHand setValue:[NSNumber numberWithBool:NO] forKey:@"handComplete"];
	[initialHand setValue:[NSNumber numberWithInt:0] forKey:@"team13ScoreTotal"];
	[initialHand setValue:[NSNumber numberWithInt:0] forKey:@"team24ScoreTotal"];
	[initialHand setValue:[NSNumber numberWithInt:0] forKey:@"team13BidPoints"];
	[initialHand setValue:[NSNumber numberWithInt:0] forKey:@"team24BidPoints"];
	[initialHand setValue:[NSNumber numberWithInt:0] forKey:@"team13ScoreBidPoints"];
	[initialHand setValue:[NSNumber numberWithInt:0] forKey:@"team24ScoreBidPoints"];
	[initialHand setValue:[NSNumber numberWithInt:0] forKey:@"team13OppositionPoints"];
	[initialHand setValue:[NSNumber numberWithInt:0] forKey:@"team24OppositionPoints"];
	[hands addObject:initialHand];
	[newGame setValue:hands forKey:@"hands"];
	// Save
	NSError *error;
	if (![[self managedObjectContext] save:&error])
	{
		// Handle the error
		NSLog(@"Save new game error: %@", [error localizedDescription]);
	}
	
	if (![self gameDetailViewController])
	{
		GameDetailViewController *tempGameDetailViewController = [[GameDetailViewController alloc] init];
		[self setGameDetailViewController:tempGameDetailViewController];
		[[self gameDetailViewController] setManagedObjectContext:[self managedObjectContext]];
		[tempGameDetailViewController release];
	}
	// Set the game
	[[self gameDetailViewController] setNewGameFlag:YES];
	[[self gameDetailViewController] setCurrentGame:newGame];
	// Set the players
	[[self gameDetailViewController] setPlayer1:player1];
	[[self gameDetailViewController] setPlayer2:player2];
	[[self gameDetailViewController] setPlayer3:player3];
	[[self gameDetailViewController] setPlayer4:player4];
	// Set the hands
	NSSortDescriptor *handsSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"index" ascending:NO];
	NSArray *handsSortDescriptors = [[NSArray alloc] initWithObjects:handsSortDescriptor, nil];
	NSArray *orderedHands = [[NSArray alloc] initWithArray:[hands sortedArrayUsingDescriptors:handsSortDescriptors]];
	[[self gameDetailViewController] setOrderedHands:orderedHands];
	[handsSortDescriptor release];
	[handsSortDescriptors release];
	[orderedHands release];
	// Push
	[[self navigationController] pushViewController:[self gameDetailViewController] animated:YES];
}

- (void)showSettings
{
	if (!settingsViewController)
		settingsViewController = [[SettingsViewController alloc] init];
	[[self navigationController] pushViewController:settingsViewController animated:YES];
	//[self setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
	//[self presentModalViewController:settingsViewController animated:YES];
}

- (void)showInformation
{
	if (!informationViewController)
		informationViewController = [[InformationViewController alloc] init];
	[[self navigationController] pushViewController:informationViewController animated:YES];
}

- (void)setEditing:(BOOL)argEditing animated:(BOOL)argAnimated
{
	[super setEditing:argEditing animated:argAnimated];
	[gamesTableView setEditing:argEditing animated:argAnimated];
}

#pragma mark -
#pragma mark TableView DataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)argTableView
{
	return [[[self gamesFetchedResultsController] sections] count];
}

- (NSInteger)tableView:(UITableView*)argTableView numberOfRowsInSection:(NSInteger)argSection
{
	id <NSFetchedResultsSectionInfo> sectionInfo = [[[self gamesFetchedResultsController] sections] objectAtIndex:argSection];
	return [sectionInfo numberOfObjects];
}

- (NSString*)tableView:(UITableView *)argTableView titleForHeaderInSection:(NSInteger)argSection
{
	switch (argSection) 
	{
		case 0:
			if ([[[self gamesFetchedResultsController] sections] count] == 2 || [[[[self gamesFetchedResultsController] objectAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] valueForKey:@"gameFinished"] boolValue] == NO)
				return NSLocalizedString(@"In Progress Games", @"In Progress Games");
			else
				return NSLocalizedString(@"Finished Games", @"Finished Games");
			break;
		case kFinishedGamesSection:
			return NSLocalizedString(@"Finished Games", @"Finished Games");
			break;
		default:
			return @"Error";
			break;
	}
}

- (UITableViewCell*)tableView:(UITableView*)argTableView cellForRowAtIndexPath:(NSIndexPath*)argIndexPath
{
	static NSString *GamesTableViewCellIdentifier = @"GamesTableViewCellIdentifier";
	GamesTableViewCell *cell = (GamesTableViewCell*)[argTableView dequeueReusableCellWithIdentifier:GamesTableViewCellIdentifier];
	if (!cell)
	{
		cell = [[[GamesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GamesTableViewCellIdentifier] autorelease];
	}
	NSManagedObject *aGame = [[self gamesFetchedResultsController] objectAtIndexPath:argIndexPath];
	NSManagedObject *player1 = [aGame valueForKey:@"player1"];	
	NSManagedObject *player2 = [aGame valueForKey:@"player2"];
	NSManagedObject *player3 = [aGame valueForKey:@"player3"];	
	NSManagedObject *player4 = [aGame valueForKey:@"player4"];
	UILabel *team13NameLabel = (UILabel*)[[cell contentView] viewWithTag:kTeam13NameLabel];
	UILabel *team24NameLabel = (UILabel*)[[cell contentView] viewWithTag:kTeam24NameLabel];
	UILabel *team13ScoreLabel = (UILabel*)[[cell contentView] viewWithTag:kTeam13ScoreLabel];
	UILabel *team24ScoreLabel = (UILabel*)[[cell contentView] viewWithTag:kTeam24ScoreLabel];
	if ([[aGame valueForKey:@"gameFinished"] boolValue] == YES)
	{
		if ([[aGame valueForKey:@"team13Score"] integerValue] > [[aGame valueForKey:@"team24Score"] integerValue])
		{
			[team13NameLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];
			[team24NameLabel setFont:[UIFont systemFontOfSize:12.0f]];
			[team13ScoreLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];
			[team24ScoreLabel setFont:[UIFont systemFontOfSize:12.0f]];	
		}
		else 
		{
			[team13NameLabel setFont:[UIFont systemFontOfSize:12.0f]];
			[team24NameLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];
			[team13ScoreLabel setFont:[UIFont systemFontOfSize:12.0f]];
			[team24ScoreLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];	
		}
	}
	else 
	{
		[team13NameLabel setFont:[UIFont systemFontOfSize:12.0f]];
		[team24NameLabel setFont:[UIFont systemFontOfSize:12.0f]];
		[team13ScoreLabel setFont:[UIFont systemFontOfSize:12.0f]];
		[team24ScoreLabel setFont:[UIFont systemFontOfSize:12.0f]];		
	}
	[team13NameLabel setText:[NSString stringWithFormat:@"%@ & %@", [player1 valueForKey:@"name"], [player3 valueForKey:@"name"]]];
	[team24NameLabel setText:[NSString stringWithFormat:@"%@ & %@", [player2 valueForKey:@"name"], [player4 valueForKey:@"name"]]];
	NSString *tempScoreString;
	// Team 13
	int tempTeam13Score = [[aGame valueForKey:@"team13Score"] integerValue];
	if (tempTeam13Score < 0)
	{
		tempTeam13Score = -1.0 * tempTeam13Score;
		tempScoreString = [NSString stringWithFormat:@"(%d)", tempTeam13Score];
	}
	else
		tempScoreString = [NSString stringWithFormat:@"%d", tempTeam13Score];
	[team13ScoreLabel setText:tempScoreString];
	// Team 24
	int tempTeam24Score = [[aGame valueForKey:@"team24Score"] integerValue];
	if (tempTeam24Score < 0)
	{
		tempTeam24Score = -1.0 * tempTeam24Score;
		tempScoreString = [NSString stringWithFormat:@"(%d)", tempTeam24Score];
	}
	else
		tempScoreString = [NSString stringWithFormat:@"%d", tempTeam24Score];
	[team24ScoreLabel setText:tempScoreString];
	UILabel *gameDateLabel = (UILabel*)[[cell contentView] viewWithTag:kGameDateLabel];
	[gameDateLabel setText:[NSDateFormatter localizedStringFromDate:[aGame valueForKey:@"dateStarted"] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle]];
	return cell;	
}

#pragma mark -
#pragma mark TableView Delegate Methods

- (void)tableView:(UITableView*)argTableView didSelectRowAtIndexPath:(NSIndexPath*)argIndexPath
{
	[argTableView deselectRowAtIndexPath:argIndexPath animated:YES];
	if (![self gameDetailViewController])
	{
		GameDetailViewController *tempGameDetailViewController = [[GameDetailViewController alloc] init];
		[self setGameDetailViewController:tempGameDetailViewController];
		[[self gameDetailViewController] setManagedObjectContext:[self managedObjectContext]];
		[tempGameDetailViewController release];
	}
	// Set Game
	NSManagedObject *tempCurrentGame = [[self gamesFetchedResultsController] objectAtIndexPath:argIndexPath];
	[[self gameDetailViewController] setCurrentGame:tempCurrentGame];
	// Set Players
	[[self gameDetailViewController] setPlayer1:[tempCurrentGame valueForKey:@"player1"]];
	[[self gameDetailViewController] setPlayer2:[tempCurrentGame valueForKey:@"player2"]];
	[[self gameDetailViewController] setPlayer3:[tempCurrentGame valueForKey:@"player3"]];
	[[self gameDetailViewController] setPlayer4:[tempCurrentGame valueForKey:@"player4"]];
	// Set Hands
	NSSet *hands = [tempCurrentGame valueForKey:@"hands"];
	NSSortDescriptor *handsSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"index" ascending:NO];
	NSArray *handsSortDescriptors = [[NSArray alloc] initWithObjects:handsSortDescriptor, nil];
	NSArray *orderedHands = [[NSArray alloc] initWithArray:[hands sortedArrayUsingDescriptors:handsSortDescriptors]];
	[[self gameDetailViewController] setOrderedHands:orderedHands];
	[handsSortDescriptor release];
	[handsSortDescriptors release];
	[orderedHands release];
	// Push gameDetailViewController
	[[self navigationController] pushViewController:gameDetailViewController animated:YES];
}

- (void)tableView:(UITableView*)argTableView commitEditingStyle:(UITableViewCellEditingStyle)argEditingStyle forRowAtIndexPath:(NSIndexPath *)argIndexPath
{
	if (argEditingStyle == UITableViewCellEditingStyleDelete)
	{
		[[self managedObjectContext] deleteObject:[[self gamesFetchedResultsController] objectAtIndexPath:argIndexPath]];
		NSError *error;
		if (![[self managedObjectContext] save:&error])
		{
			// TODO: Error Handling
		}
	}
}

#pragma mark -
#pragma mark NSFetchedResultsControllerDelegate Methods

- (void)controllerWillChangeContent:(NSFetchedResultsController*)argController
{
	[gamesTableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController*)argController didChangeSection:(id <NSFetchedResultsSectionInfo>)argSectionInfo atIndex:(NSUInteger)argSectionIndex forChangeType:(NSFetchedResultsChangeType)argType
{
	switch (argType) 
	{
		case NSFetchedResultsChangeInsert:
			[gamesTableView insertSections:[NSIndexSet indexSetWithIndex:argSectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;
		case NSFetchedResultsChangeDelete:
			[gamesTableView deleteSections:[NSIndexSet indexSetWithIndex:argSectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;
		default:
			break;
	}
}

- (void)controller:(NSFetchedResultsController*)argController didChangeObject:(id)argObject atIndexPath:(NSIndexPath*)argIndexPath forChangeType:(NSFetchedResultsChangeType)argType newIndexPath:(NSIndexPath*)argNewIndexPath 
{	
    switch(argType) 
	{
        case NSFetchedResultsChangeInsert:
            [gamesTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:argNewIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [gamesTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:argIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
			[gamesTableView reloadData];
            break;
        case NSFetchedResultsChangeMove:
            [gamesTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:argIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            [gamesTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:argNewIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController*)argController
{
	[gamesTableView endUpdates];
	if ([[[self gamesFetchedResultsController] sections] count] == 0)
	{
		[self setEditing:NO];
		[[self navigationItem] setLeftBarButtonItem:nil animated:YES];
	}
}

@synthesize managedObjectContext;
@synthesize gamesFetchedResultsController;
@synthesize gameDetailViewController;
@end
