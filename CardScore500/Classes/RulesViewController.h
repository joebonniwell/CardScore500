//
//  RulesViewController.h
//  UserInterface
//
//  Created by Joe Bonniwell on 9/18/10.
//  Copyright 2010 Joe Bonniwell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScoreChart.h"
#import "RulesTextView.h"
@interface RulesViewController : UIViewController 
{
	BOOL showChart;
	ScoreChart *theScoreChart;
	UIWebView *rulesWebView;
}

@property (nonatomic, retain) UIWebView *rulesWebView;

@end
