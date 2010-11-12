//
//  RecordTricksViewController.h
//  UserInterface
//
//  Created by Joe Bonniwell on 9/29/10.
//  Copyright 2010 Joe Bonniwell. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GameDetailViewController;
@class CurvedShadow;

@protocol RecordTricksDelegate
- (NSString*)winningTeamName;
- (void)handCompleted;
@end

@interface RecordTricksViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> 
{
	GameDetailViewController *delegate;
	UILabel *teamNameLabel;
	NSManagedObject *currentHand;
	UITableView *tricksTableView;
	UIToolbar *bottomToolbar;
	int selectedTricks;
	CurvedShadow *shadowHolder;
}
@property (nonatomic, retain) UILabel *teamNameLabel;
@property (nonatomic, assign) GameDetailViewController *delegate;
@property (nonatomic, retain) NSManagedObject *currentHand;
@property (nonatomic, retain) UITableView *tricksTableView;
@property (nonatomic, retain) UIToolbar *bottomToolbar;
@property (nonatomic, retain) CurvedShadow *shadowHolder;

- (void)recordTricks;
@end
