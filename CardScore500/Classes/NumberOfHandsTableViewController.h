//
//  NumberOfHandsTableViewController.h
//  CardScore500
//
//  Created by Joe Bonniwell on 10/11/10.
//  Copyright 2010 Joe Bonniwell. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NumberOfHandsTableViewController : UITableViewController 
{
	NSIndexPath *checkedIndexPath;
}

@property (nonatomic, retain) NSIndexPath *checkedIndexPath;
@end
