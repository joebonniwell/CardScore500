//
//  GameDetailPlayerView.h
//  UserInterface
//
//  Created by Joe Bonniwell on 9/7/10.
//  Copyright 2010 Joe Bonniwell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StickPersonView.h"
#import "DealerButtonView.h"

@protocol GameDetailPlayerViewDelegate <NSObject>

- (void)mainActionButtonPressed;
- (BOOL)shouldChangeDealerToPlayer:(NSInteger)argPlayer;

@end

@interface GameDetailPlayerView : UIView
{
	UITextField *player1TextField;
	UITextField *player2TextField;
	UITextField *player3TextField;
	UITextField *player4TextField;
	UILabel *team13ScoreNameLabel;
	UILabel *team24ScoreNameLabel;
	UIButton *mainActionButton;
	UILabel *dealerLabel;
	id delegate;
}

@property (nonatomic, retain) UITextField *player1TextField;
@property (nonatomic, retain) UITextField *player2TextField;
@property (nonatomic, retain) UITextField *player3TextField;
@property (nonatomic, retain) UITextField *player4TextField;
@property (nonatomic, retain) UILabel *team13ScoreNameLabel;
@property (nonatomic, retain) UILabel *team24ScoreNameLabel;
@property (nonatomic, retain) UIButton *mainActionButton;
@property (nonatomic, retain) UILabel *dealerLabel;
@property (nonatomic, assign) id delegate;

- (void)assignDealerToPlayer1:(id)sender;
- (void)assignDealerToPlayer2:(id)sender;
- (void)assignDealerToPlayer3:(id)sender;
- (void)assignDealerToPlayer4:(id)sender;
- (void)moveDealerToPlayer:(NSInteger)argPlayer;
@end
