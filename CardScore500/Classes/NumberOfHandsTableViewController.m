//
//  NumberOfHandsTableViewController.m
//  CardScore500
//
//  Created by Joe Bonniwell on 10/11/10.
//  Copyright 2010 Joe Bonniwell. All rights reserved.
//

#import "NumberOfHandsTableViewController.h"

@implementation NumberOfHandsTableViewController

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
	[[self tableView] setBackgroundColor:[UIColor kAppYellowColor]];
}

- (void)viewWillAppear:(BOOL)argAnimated 
{
    [super viewWillAppear:argAnimated];
	[[NSUserDefaults standardUserDefaults] synchronize];
	[[NSUserDefaults standardUserDefaults] boolForKey:@"numberOfHands"];
	[self setCheckedIndexPath:[NSIndexPath indexPathForRow:(gTournamentModeNumberOFHands - 4) inSection:0]];
	[[self tableView] reloadData];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)argTableView 
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)argTableView numberOfRowsInSection:(NSInteger)argSection 
{
    return 9;
}

- (UITableViewCell *)tableView:(UITableView*)argTableView cellForRowAtIndexPath:(NSIndexPath*)argIndexPath 
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [argTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
	{
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		[cell setBackgroundColor:[UIColor kAppYellowColor]];
    }
    [[cell textLabel] setText:[NSString stringWithFormat:@"%d", ([argIndexPath row] + 4)]];
	if ([argIndexPath isEqual:[self checkedIndexPath]])
	{
		[cell setAccessoryType:UITableViewCellAccessoryCheckmark];
	}
	else 
	{
		[cell setAccessoryType:UITableViewCellAccessoryNone];
	}
    return cell;
}

- (BOOL)tableView:(UITableView*)argTableView canEditRowAtIndexPath:(NSIndexPath*)argIndexPath 
{
    return NO;
}

- (BOOL)tableView:(UITableView*)argTableView canMoveRowAtIndexPath:(NSIndexPath*)argIndexPath 
{
    return NO;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView*)argTableView didSelectRowAtIndexPath:(NSIndexPath*)argIndexPath 
{
	gTournamentModeNumberOFHands = ([argIndexPath row] + 4);
	[[NSUserDefaults standardUserDefaults] setInteger:gTournamentModeNumberOFHands forKey:@"numberOfHands"];
	[self setCheckedIndexPath:argIndexPath];
	[argTableView deselectRowAtIndexPath:argIndexPath animated:YES];
	[argTableView reloadData];
}

#pragma mark -
#pragma mark Memory management

- (void)viewDidUnload
{
	[self setCheckedIndexPath:nil];
}

- (void)dealloc 
{
	[checkedIndexPath release];
    [super dealloc];
}

@synthesize checkedIndexPath;
@end

