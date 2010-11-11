//
//  GameDetailViewController.h
//  UserInterface
//
//  Created by Joe Bonniwell on 9/7/10.
//  Copyright 2010 Joe Bonniwell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameDetailPlayerView.h"
#import "RecordBidsViewController.h"
#import "RecordTricksViewController.h"
#import "RulesViewController.h"

@class CardScore500AppDelegate;

@interface GameDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, GameDetailPlayerViewDelegate, UITextFieldDelegate, RecordBidsDelegate, RecordTricksDelegate>
{
	// Data Model
	NSManagedObjectContext *managedObjectContext;
	NSManagedObject *currentGame;
	NSManagedObject *player1;
	NSManagedObject *player2;
	NSManagedObject *player3;
	NSManagedObject *player4;
	NSArray *orderedHands;
	// View Controllers
	RecordBidsViewController *recordBidsViewController;
	RecordTricksViewController *recordTricksViewController;
	RulesViewController *rulesViewController;
	// Controller Components
	UITableView *gameDetailHistoryView;
	GameDetailPlayerView *gameDetailPlayerView;
	BOOL newGameFlag;
	int switchDealerRequested;
	BOOL hintWasDisplayed;
}

@property (nonatomic, retain) UITableView *gameDetailHistoryView;
@property (nonatomic, retain) GameDetailPlayerView *gameDetailPlayerView;
@property (nonatomic, retain) RecordBidsViewController *recordBidsViewController;
@property (nonatomic, retain) RecordTricksViewController *recordTricksViewController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSManagedObject *currentGame;
@property (nonatomic, retain) NSManagedObject *player1;
@property (nonatomic, retain) NSManagedObject *player2;
@property (nonatomic, retain) NSManagedObject *player3;
@property (nonatomic, retain) NSManagedObject *player4;
@property (nonatomic, retain) NSArray *orderedHands;
@property BOOL newGameFlag;

- (void)refreshNames;
- (NSString*)formatScores:(int)argScore;
- (void)addNewHandWithDealer:(int)argDealer;
- (void)refreshMainActionButton;
- (NSManagedObject*)currentHand;
- (void)updateOrderedHandsWithHandSet:(NSMutableSet*)argHandSet;
@end
