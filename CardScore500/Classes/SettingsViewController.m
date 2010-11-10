    //
//  SettingsViewController.m
//  UserInterface
//
//  Created by Joe Bonniwell on 9/8/10.
//  Copyright 2010 Joe Bonniwell. All rights reserved.
//

#define kBiddingPreferencesSection 0
#define kScoringPreferencesSection 1
#define kGamePlayPreferencesSection 2
#define kNumberOfHandsRow 1
#define kLabel 601
#define kSwitch 602
#define kEnableMisdeals 801
#define kPlaySixBids 802
#define k8SpadesOutbidsNula 803
#define kEnableSlams 804
#define kRequireBidPointsForWin 805
#define kEnableNegativeScoreLoss 806
#define kEnableTournamentMode 807

#import "SettingsViewController.h"

@implementation SettingsViewController

- (void)loadView 
{
	UITableView *tempSettingsTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
	[tempSettingsTableView setDelegate:self];
	[tempSettingsTableView setDataSource:self];
	[tempSettingsTableView setBackgroundColor:[UIColor kAppYellowColor]];
	[self setSettingsTableView:tempSettingsTableView];
	[self setView:[self settingsTableView]];
	[tempSettingsTableView release];
	// Navigation Items
	[[self navigationItem] setTitle:NSLocalizedString(@"Settings", @"Settings")];
	UIBarButtonItem *helpButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Help", @"Help") style:UIBarButtonItemStylePlain target:self action:@selector(toggleHelp)];
	[[self navigationItem] setRightBarButtonItem:helpButton];
	[helpButton release];
	// Notification Registration
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedApplicationBecameActiveNotification) name:UIApplicationDidBecomeActiveNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedUserDefaultChangeNotification) name:NSUserDefaultsDidChangeNotification object:[NSUserDefaults standardUserDefaults]];
}

- (void)viewWillAppear:(BOOL)argAnimated
{
	[[self settingsTableView] reloadData];
}

- (void)viewDidUnload 
{
    [super viewDidUnload];
	[settingsTableView release];
	[self setSettingsTableView:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dealloc 
{
	[settingsTableView release];
    [super dealloc];
}

#pragma mark -
#pragma mark TableView DataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView*)argTableView
{
	return 3;	// Bidding, Scoring & Gameplay preferences
}

- (NSInteger)tableView:(UITableView*)argTableView numberOfRowsInSection:(NSInteger)argSection
{
	switch (argSection) 
	{
		case kBiddingPreferencesSection:
			if (helpEnabled)
				return 6;
			return 3;
			break;
		case kScoringPreferencesSection:
			if (helpEnabled)
				return 6;
			return 3;
			break;
		case kGamePlayPreferencesSection:
			if (helpEnabled)
				return 3;
			return 2;	
			break;
		default:
			return 0;	// Error
			break;
	}
}

- (UITableViewCell*)tableView:(UITableView*)argTableView cellForRowAtIndexPath:(NSIndexPath*)argIndexPath
{
	UITableViewCell *cell;	
	UILabel *settingLabel;
	UISwitch *settingSwitch;
	switch ([argIndexPath section]) 
	{
		case kBiddingPreferencesSection:
		{
			switch ([argIndexPath row]) 
			{
				case 0:
					cell = [self getSwitchSettingCellWithTableView:argTableView];
					settingLabel = (UILabel*)[[cell contentView] viewWithTag:kLabel];
					settingSwitch = (UISwitch*)[[cell contentView] viewWithTag:kSwitch];
					[settingLabel setText:NSLocalizedString(@"Enable Misdeals", @"Enable Misdeals")];
					[[cell contentView] setTag:801];
					[settingSwitch setOn:gEnableMisdeals];
					return cell;
					break;
				case 1:
					if (helpEnabled)
					{
						cell = [self getHelpCellWithTableView:argTableView];
						[[cell textLabel] setText:NSLocalizedString(@"When enable misdeals is set to ON, a bidding round that concludes without a playable winning bid will be classified as a misdeal and a new hand should be dealt. When OFF, a bidding round that concludes without a playable winning bid will be played as a no trump hand, with each trick won being worth 10 points.", @"When enable misdeals is set to ON, a bidding round that concludes without a playable winning bid will be classified as a misdeal and a new hand should be dealt. When OFF, a bidding round that concludes without a playable winning bid will be played as a no trump hand, with each trick won being worth 10 points.")];
						return cell;
					}
					cell = [self getSwitchSettingCellWithTableView:argTableView];
					settingLabel = (UILabel*)[[cell contentView] viewWithTag:kLabel];
					settingSwitch = (UISwitch*)[[cell contentView] viewWithTag:kSwitch];
					[settingLabel setText:NSLocalizedString(@"Play Six Bids", @"Play Six Bids")];
					[[cell contentView] setTag:802];
					[settingSwitch setOn:gPlaySixBids];
					return cell;
					break;
				case 2:
					if (helpEnabled)
					{
						cell = [self getSwitchSettingCellWithTableView:argTableView];
						settingLabel = (UILabel*)[[cell contentView] viewWithTag:kLabel];
						settingSwitch = (UISwitch*)[[cell contentView] viewWithTag:kSwitch];
						[settingLabel setText:NSLocalizedString(@"Play Six Bids", @"Play Six Bids")];
						[[cell contentView] setTag:802];
						[settingSwitch setOn:gPlaySixBids];
						return cell;
					}
					cell = [self getSwitchSettingCellWithTableView:argTableView];
					settingLabel = (UILabel*)[[cell contentView] viewWithTag:kLabel];
					settingSwitch = (UISwitch*)[[cell contentView] viewWithTag:kSwitch];
					[settingLabel setText:NSLocalizedString(@"8 Spades Outbids Misere", @"8 Spades Outbids Misere")];
					[[cell contentView] setTag:803];
					[settingSwitch setOn:g8SpadesOutbidsNula];
					return cell;
					break;
				case 3:
					cell = [self getHelpCellWithTableView:argTableView];
					[[cell textLabel] setText:NSLocalizedString(@"When play six bids is set to ON, a winning bid of six tricks will be played for the bid points. When OFF, a winning bid of six tricks will be considered a misdeal and action will be taken according to the status of enable misdeals.", @"When play six bids is set to ON, a winning bid of six tricks will be played for the bid points. When OFF, a winning bid of six tricks will be considered a misdeal and action will be taken according to the status of enable misdeals.")];
					return cell;
					break;
				case 4:
					cell = [self getSwitchSettingCellWithTableView:argTableView];
					settingLabel = (UILabel*)[[cell contentView] viewWithTag:kLabel];
					settingSwitch = (UISwitch*)[[cell contentView] viewWithTag:kSwitch];
					[settingLabel setText:NSLocalizedString(@"8 Spades Outbids Misere", @"8 Spades Outbids Misere")];
					[[cell contentView] setTag:803];
					[settingSwitch setOn:g8SpadesOutbidsNula];
					return cell;
					break;
				case 5:
					cell = [self getHelpCellWithTableView:argTableView];
					[[cell textLabel] setText:NSLocalizedString(@"When 8 spades outbids Misere is set to ON, a bid of 8 spades can be bid after a bid of Misere. When OFF, the bidding hierarchy is strictly according to points, with 8 spades (240 points) being outbid by Misere (250 points).", @"When 8 spades outbids Misere is set to ON, a bid of 8 spades can be bid after a bid of Misere. When OFF, the bidding hierarchy is strictly according to points, with 8 spades (240 points) being outbid by Misere (250 points).")];
					return cell;
					break;
				default:
					break;
			}
			break;
		}
		case kScoringPreferencesSection:
		{
			switch ([argIndexPath row]) 
			{
				case 0:
					cell = [self getSwitchSettingCellWithTableView:argTableView];
					settingLabel = (UILabel*)[[cell contentView] viewWithTag:kLabel];
					settingSwitch = (UISwitch*)[[cell contentView] viewWithTag:kSwitch];
					[settingLabel setText:NSLocalizedString(@"Enable Slams", @"Enable Slams")];
					[[cell contentView] setTag:kEnableSlams];
					[settingSwitch setOn:gEnableSlams];
					return cell;
					break;
				case 1:
					if (helpEnabled)
					{
						cell = [self getHelpCellWithTableView:argTableView];
						[[cell textLabel] setText:NSLocalizedString(@"When enable slams is set to ON, any bid of less than 250 points will be awarded 250 points if the winning team takes all 10 tricks. When OFF, all bids are awarded the normal point amount regardless of excess tricks taken.", @"When enable slams is set to ON, any bid of less than 250 points will be awarded 250 points if the winning team takes all 10 tricks. When OFF, all bids are awarded the normal point amount regardless of excess tricks taken.")];
						return cell;
					}
					cell = [self getSwitchSettingCellWithTableView:argTableView];
					settingLabel = (UILabel*)[[cell contentView] viewWithTag:kLabel];
					settingSwitch = (UISwitch*)[[cell contentView] viewWithTag:kSwitch];
					[settingLabel setText:NSLocalizedString(@"Require Bid Points for Win", @"Require Bid Points for Win")];
					[[cell contentView] setTag:kRequireBidPointsForWin];
					[settingSwitch setOn:gRequireBidPointsForWin];
					return cell;
					break;
				case 2:
					cell = [self getSwitchSettingCellWithTableView:argTableView];
					settingLabel = (UILabel*)[[cell contentView] viewWithTag:kLabel];
					settingSwitch = (UISwitch*)[[cell contentView] viewWithTag:kSwitch];
					if (helpEnabled)
					{
						[settingLabel setText:NSLocalizedString(@"Require Bid Points for Win", @"Require Bid Points for Win")];
						[[cell contentView] setTag:kRequireBidPointsForWin];
						[settingSwitch setOn:gRequireBidPointsForWin];
						return cell;
					}
					[settingLabel setText:NSLocalizedString(@"Enable Negative Score Loss", @"Enable Negative Score Loss")];
					[[cell contentView] setTag:kEnableNegativeScoreLoss];
					[settingSwitch setOn:gEnableNegativeScoreLoss];
					return cell;
					break;
				case 3:
					cell = [self getHelpCellWithTableView:argTableView];
					[[cell textLabel] setText:NSLocalizedString(@"When require bid points for win is set to ON, a team can win the game only if the points accumulated through successfully completing bids reach 500 or greater. When OFF, a team can win the game once their total points (including points awarded in opposition) reach 500 or greater.", @"When require bid points for win is set to ON, a team can win the game only if the points accumulated through successfully completing bids reach 500 or greater. When OFF, a team can win the game once their total points (including points awarded in opposition) reach 500 or greater.")];
					return cell;
					break;
				case 4:
					cell = [self getSwitchSettingCellWithTableView:argTableView];
					settingLabel = (UILabel*)[[cell contentView] viewWithTag:kLabel];
					settingSwitch = (UISwitch*)[[cell contentView] viewWithTag:kSwitch];
					[settingLabel setText:NSLocalizedString(@"Enable Negative Score Loss", @"Enable Negative Score Loss")];
					[[cell contentView] setTag:kEnableNegativeScoreLoss];
					[settingSwitch setOn:gRequireBidPointsForWin];
					return cell;
					break;
				case 5:
					cell = [self getHelpCellWithTableView:argTableView];
					[[cell textLabel] setText:NSLocalizedString(@"When enable negative score loss is set to ON, a team that reaches -500 points will lose the game. When OFF, there is no loss triggered for negative points.", @"When enable negative score loss is set to ON, a team that reaches -500 points will lose the game. When OFF, there is no loss triggered for negative points.")];
					return cell;
					break;
				default:
					break;
			}
			break;
		}
		case kGamePlayPreferencesSection:
		{
			switch ([argIndexPath row]) 
			{
				case 0:
					cell = [self getSwitchSettingCellWithTableView:argTableView];
					UILabel *settingLabel = (UILabel*)[[cell contentView] viewWithTag:kLabel];
					UISwitch *settingSwitch = (UISwitch*)[[cell contentView] viewWithTag:kSwitch];
					[settingLabel setText:NSLocalizedString(@"Enable Tournament Mode", @"Enable Tournament Mode")];
					[[cell contentView] setTag:807];
					[settingSwitch setOn:gEnableTournamentMode];
					return cell;
					break;
				case 1:
					cell = [self getNumberOfHandsCellWithTableView:argTableView];
					[[cell textLabel] setText:@"Number of Hands"];
					[[cell textLabel] setText:NSLocalizedString(@"Number of Hands", @"Number of Hands")];
					[[cell detailTextLabel] setText:[NSString stringWithFormat:@"%d", gTournamentModeNumberOFHands]];
					return cell;
					break;
				case 2:
					cell = [self getHelpCellWithTableView:argTableView];
					[[cell textLabel] setText:NSLocalizedString(@"When tournament mode is set to ON, the game is finished after the number of hands selected is played, regardless of score.", @"When tournament mode is set to ON, the game is finished after the number of hands selected is played, regardless of score.")];
					return cell;
					break;
				default:
					break;
			}
			break;
		}
		default:
			break;
	}
	return nil;
}

#pragma mark -
#pragma mark TableView DataSource Helper Methods

- (UITableViewCell*)getHelpCellWithTableView:(UITableView*)argTableView
{
	static NSString *HelpTableViewCellIdentifier = @"HelpTableViewCellIdentifier";
	UITableViewCell *cell = [argTableView dequeueReusableCellWithIdentifier:HelpTableViewCellIdentifier];
	if (!cell)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HelpTableViewCellIdentifier] autorelease];
		[cell setContentMode:UIViewContentModeTopLeft];
		[cell setBackgroundColor:[UIColor kAppYellowColor]];
		[[cell textLabel] setNumberOfLines:0];
		[[cell textLabel] setFont:[UIFont systemFontOfSize:12.0f]];
		[[cell textLabel] setBaselineAdjustment:UIBaselineAdjustmentNone];
	}
	return cell;
}

- (UITableViewCell*)getSwitchSettingCellWithTableView:(UITableView*)argTableView
{
	static NSString *SwitchSettingTableViewCellIdentifier = @"SwitchSettingTableViewCellIdentifier";
	UITableViewCell *cell = [argTableView dequeueReusableCellWithIdentifier:SwitchSettingTableViewCellIdentifier];
	if (!cell)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SwitchSettingTableViewCellIdentifier] autorelease];
		[cell setBackgroundColor:[UIColor kAppYellowColor]];
		UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 5.0f, 200.0f, 30.0f)];
		[tempLabel setTag:kLabel];
		[tempLabel setFont:[UIFont systemFontOfSize:14.0f]];
		[tempLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[[cell contentView] addSubview:tempLabel];
		[tempLabel release];
		UISwitch *tempSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(200.0f, 8.0f, 80.0f, 30.0f)];
		[tempSwitch setTag:kSwitch];
		[tempSwitch addTarget:self action:@selector(switchToggled:) forControlEvents:UIControlEventValueChanged];
		[tempSwitch setBackgroundColor:[UIColor kAppYellowColor]];
		[[cell contentView] addSubview:tempSwitch];
		[tempSwitch release];
	}
	return cell;
}

- (UITableViewCell*)getNumberOfHandsCellWithTableView:(UITableView*)argTableView
{
	static NSString *NumberOfHandsTableViewCellIdentifier = @"NumberOfHandsTableViewCellIdentifier";
	UITableViewCell *cell = [argTableView dequeueReusableCellWithIdentifier:NumberOfHandsTableViewCellIdentifier];
	if (!cell)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NumberOfHandsTableViewCellIdentifier] autorelease];
		[[cell textLabel] setFont:[UIFont systemFontOfSize:14.0f]];
		[cell setBackgroundColor:[UIColor kAppYellowColor]];
		[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	}
	return cell;
}

#pragma mark -
#pragma mark TableView Delegate Methods

- (NSIndexPath*)tableView:(UITableView*)argTableView willSelectRowAtIndexPath:(NSIndexPath*)argIndexPath
{
	if ([argIndexPath section] == kGamePlayPreferencesSection && [argIndexPath row] == kNumberOfHandsRow)
		return argIndexPath;
	return nil;
}

- (void)tableView:(UITableView*)argTableView didSelectRowAtIndexPath:(NSIndexPath*)argIndexPath
{
	if ([argIndexPath section] == kGamePlayPreferencesSection && [argIndexPath row] == 1)
	{
		NumberOfHandsTableViewController *numberOfHandsTableViewController = [[NumberOfHandsTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
		[[self navigationController] pushViewController:numberOfHandsTableViewController animated:YES];
		[numberOfHandsTableViewController release];
	}
}

- (CGFloat)tableView:(UITableView*)argTableView heightForRowAtIndexPath:(NSIndexPath*)argIndexPath
{
	if ([argIndexPath section] == kGamePlayPreferencesSection && [argIndexPath row] == 2)
	{
		if (helpEnabled)
			return 110.0f;
	}
	else if (([argIndexPath row] == 1 || [argIndexPath row] == 3 || [argIndexPath row] == 5) && [argIndexPath section] != kGamePlayPreferencesSection)
	{
		if (helpEnabled)
			return 110.0f;
	}
	return 44.0f;
}

#pragma mark -
#pragma mark Other Methods

- (void)switchToggled:(id)sender
{
	UISwitch *activatedSwitch = (UISwitch*)sender;
	switch ([[activatedSwitch superview] tag]) 
	{
		case kEnableMisdeals:
			gEnableMisdeals = [activatedSwitch isOn];
			break;
		case kPlaySixBids:
			gPlaySixBids = [activatedSwitch isOn];
			break;
		case k8SpadesOutbidsNula:
			g8SpadesOutbidsNula = [activatedSwitch isOn];
			break;
		case kEnableSlams:
			gEnableSlams = [activatedSwitch isOn];
			break;
		case kRequireBidPointsForWin:
			gRequireBidPointsForWin = [activatedSwitch isOn];
			break;
		case kEnableNegativeScoreLoss:
			gEnableNegativeScoreLoss = [activatedSwitch isOn];
			break;
		case kEnableTournamentMode:
			gEnableTournamentMode = [activatedSwitch isOn];
			break;
		default:
			break;
	}	
	[self syncFromGlobalsToStandardDefaults];
}

- (void)toggleHelp
{
	helpEnabled = !helpEnabled;
	[settingsTableView reloadData];
}

- (void)syncFromGlobalsToStandardDefaults
{
	[[NSUserDefaults standardUserDefaults] setBool:gEnableMisdeals forKey:@"enableMisdeals"];
	[[NSUserDefaults standardUserDefaults] setBool:gPlaySixBids forKey:@"playSixBids"];
	[[NSUserDefaults standardUserDefaults] setBool:g8SpadesOutbidsNula forKey:@"eightSpadesOutbidsNula"];
	[[NSUserDefaults standardUserDefaults] setBool:gEnableSlams	forKey:@"enableSlams"];
	[[NSUserDefaults standardUserDefaults] setBool:gRequireBidPointsForWin forKey:@"requireBidPointsForWin"];
	[[NSUserDefaults standardUserDefaults] setBool:gEnableNegativeScoreLoss	forKey:@"enableNegativeScoreLoss"];
	[[NSUserDefaults standardUserDefaults] setBool:gEnableTournamentMode forKey:@"enableTournamentMode"];
	[[NSUserDefaults standardUserDefaults] setInteger:gTournamentModeNumberOFHands forKey:@"numberOfHands"];	
	[[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark -
#pragma mark Notification Actions

- (void)receivedApplicationBecameActiveNotification
{
	[[self settingsTableView] reloadData];
}

- (void)receivedUserDefaultChangeNotification
{
	[[self settingsTableView] reloadData];
}

@synthesize settingsTableView;
@end
