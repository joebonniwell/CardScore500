//
//  GamesViewController.h
//  CardScore500
//
//  Created by Joe Bonniwell on 9/30/10.
//  Copyright 2010 Joe Bonniwell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameDetailViewController.h"
#import "SettingsViewController.h"
#import "GamesTableViewCell.h"
#import "InformationViewController.h"
@interface GamesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>
{
	GameDetailViewController *gameDetailViewController;
	SettingsViewController *settingsViewController;
	InformationViewController *informationViewController;
	NSManagedObjectContext *managedObjectContext;
	NSFetchedResultsController *gamesFetchedResultsController;
	@private
	UITableView *gamesTableView;
}
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *gamesFetchedResultsController;
@property (nonatomic, retain) GameDetailViewController *gameDetailViewController;
@end
