//
//  SettingsViewController.h
//  UserInterface
//
//  Created by Joe Bonniwell on 9/8/10.
//  Copyright 2010 Joe Bonniwell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NumberOfHandsTableViewController.h"

@interface SettingsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
	UITableView *settingsTableView;
	BOOL helpEnabled;
}
@property (nonatomic, retain) UITableView *settingsTableView;

- (UITableViewCell*)getHelpCellWithTableView:(UITableView*)argTableView;
- (UITableViewCell*)getSwitchSettingCellWithTableView:(UITableView*)argTableView;
- (UITableViewCell*)getNumberOfHandsCellWithTableView:(UITableView*)argTableView;
- (void)syncFromGlobalsToStandardDefaults;
@end
