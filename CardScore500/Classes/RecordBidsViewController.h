//
//  RecordBidsViewController.h
//  UserInterface
//
//  Created by Joe Bonniwell on 9/9/10.
//  Copyright 2010 Joe Bonniwell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StickPersonView.h"
#import "RecordBidsPlayerView.h"
#import "RulesViewController.h"
#import "CurvedShadow.h"

#define kClearLastBidButton 90

@class GameDetailViewController;

@protocol RecordBidsDelegate

- (NSString*)player1Name;
- (NSString*)player2Name;
- (NSString*)player3Name;
- (NSString*)player4Name;
- (void)handCompletedAsMisdeal;
@end


@interface RecordBidsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
	// Views
	UITableView *bidsTableView;
	RecordBidsPlayerView *player1View;
	RecordBidsPlayerView *player2View;
	RecordBidsPlayerView *player3View;
	RecordBidsPlayerView *player4View;
	UIToolbar *bottomToolbar;
	NSArray *toolbarSingleButtonItems;
	NSArray *toolbarDoubleButtonItems;
	CurvedShadow *shadowHolder;
	// Controllers
	RulesViewController *rulesViewController;
	GameDetailViewController *delegate;
	// Data
	NSManagedObject *currentHand;
	NSArray *allBidsNames;
	NSArray *allBidsScores;
	NSArray *allBidsKeys;
	NSMutableArray *availableBidsNames;
	NSMutableArray *availableBidsScores;
	NSMutableArray *availableBidsKeys;
	NSIndexPath *selectedBidIndexPath;
	BOOL scrollingToTop;
}
// Views
@property (nonatomic, retain) UITableView *bidsTableView;
@property (nonatomic, retain) RecordBidsPlayerView *player1View;
@property (nonatomic, retain) RecordBidsPlayerView *player2View;
@property (nonatomic, retain) RecordBidsPlayerView *player3View;
@property (nonatomic, retain) RecordBidsPlayerView *player4View;
@property (nonatomic, retain) UIToolbar *bottomToolbar;
@property (nonatomic, retain) NSArray *toolbarDoubleButtonItems;
@property (nonatomic, retain) NSArray *toolbarSingleButtonItems;
@property (nonatomic, retain) CurvedShadow *shadowHolder;
// Controllers
@property (nonatomic, retain) RulesViewController *rulesViewController;
@property (nonatomic, assign) GameDetailViewController *delegate;
// Data
@property (nonatomic, retain) NSManagedObject *currentHand;
@property (nonatomic, retain) NSArray *allBidsNames;
@property (nonatomic, retain) NSArray *allBidsScores;
@property (nonatomic, retain) NSArray *allBidsKeys;
@property (nonatomic, retain) NSMutableArray *availableBidsNames;
@property (nonatomic, retain) NSMutableArray *availableBidsScores;
@property (nonatomic, retain) NSMutableArray *availableBidsKeys;
@property (nonatomic, retain) NSIndexPath *selectedBidIndexPath;

- (int)currentWinningBid;
- (void)updateAvatars;
- (void)updateAvailableBids;
- (int)currentDealer;
- (int)currentBidder;
- (int)previousBidder;
- (int)bidder:(int)argBidder;
- (int)bidForPlayer:(int)argPlayer;
- (void)updateWinningBidder;
- (void)updateBidLabels;
@end
