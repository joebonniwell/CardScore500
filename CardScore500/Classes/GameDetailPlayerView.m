//
//  GameDetailPlayerView.m
//  UserInterface
//
//  Created by Joe Bonniwell on 9/7/10.
//  Copyright 2010 Joe Bonniwell. All rights reserved.
//

#define kGameHistoryScrollView 305

#import "GameDetailPlayerView.h"

@implementation GameDetailPlayerView

- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) 
	{
		[self setBackgroundColor:[UIColor kAppYellowColor]];
		// Main Action Button
		CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
		CGContextRef bitmapContext = CGBitmapContextCreate(NULL, 100.0f, 100.0f, 8, 0, rgbColorSpace, kCGImageAlphaPremultipliedFirst);
		// Draw the circle
		CGContextSetLineWidth(bitmapContext, 2.0f);
		CGContextSetStrokeColorWithColor(bitmapContext, [[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f] CGColor]);
		CGContextStrokeEllipseInRect(bitmapContext, CGRectMake(6.0f, 6.0f, 88.0f, 88.0f));
		// Save the normal state image
		CGImageRef normalStateCGImage = CGBitmapContextCreateImage(bitmapContext);
		UIImage *normalStateUIImage = [UIImage imageWithCGImage:normalStateCGImage];
		CGImageRelease(normalStateCGImage);
		// Add the gradient
		CGColorRef radialColors[2] = {[[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0] CGColor], [[UIColor clearColor] CGColor]};
		CFArrayRef radialColorsArray = CFArrayCreate(kCFAllocatorDefault, (const void **)radialColors, 2, &kCFTypeArrayCallBacks);
		CGGradientRef radialGradient = CGGradientCreateWithColors(rgbColorSpace, radialColorsArray, NULL);
		CGContextDrawRadialGradient(bitmapContext, radialGradient, CGPointMake(50.0f, 50.0f), 0.0f, CGPointMake(50.0f, 50.0f), 30.0f, 0);
		// Save the highlighted state image
		CGImageRef highlightedStateCGImage = CGBitmapContextCreateImage(bitmapContext);
		UIImage *highlightedStateUIImage = [UIImage imageWithCGImage:highlightedStateCGImage];
		CGImageRelease(highlightedStateCGImage);
		// Main Action Button
		UIButton *tempMainActionButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
		[tempMainActionButton setFrame:CGRectMake(110.0f, 47.0f, 100.0f, 100.0f)];
		[tempMainActionButton setTitle:@"Record\nTricks" forState:UIControlStateNormal];
		[tempMainActionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[tempMainActionButton setBackgroundImage:normalStateUIImage forState:UIControlStateNormal];
		[tempMainActionButton setBackgroundImage:highlightedStateUIImage forState:UIControlStateHighlighted];
		[tempMainActionButton addTarget:[self delegate] action:@selector(mainActionButtonPressed) forControlEvents:UIControlEventTouchUpInside];
		[[tempMainActionButton titleLabel] setNumberOfLines:2];
		[[tempMainActionButton titleLabel] setLineBreakMode:UILineBreakModeWordWrap];
		[[tempMainActionButton titleLabel]setTextAlignment:UITextAlignmentCenter];
		[self setMainActionButton:tempMainActionButton];
		[self addSubview:[self mainActionButton]];
		CGColorSpaceRelease(rgbColorSpace);
		CGContextRelease(bitmapContext);
		[tempMainActionButton release];
		// Player 1 Name Field
		UITextField *tempPlayer1TextField = [[UITextField alloc] initWithFrame:CGRectMake(5.0f, 5.0f, 75.0f, 70.0f)];
		[tempPlayer1TextField setBackgroundColor:[UIColor kAppYellowColor]];
		[tempPlayer1TextField setTextAlignment:UITextAlignmentRight];
		[tempPlayer1TextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
		[tempPlayer1TextField setReturnKeyType:UIReturnKeyDone];
		[self setPlayer1TextField:tempPlayer1TextField];
		[tempPlayer1TextField release];
		[self addSubview:[self player1TextField]];
		// Player 2 Name Field
		UITextField *tempPlayer2TextField = [[UITextField alloc] initWithFrame:CGRectMake(240.0f, 5.0f, 75.0f, 70.0f)];
		[tempPlayer2TextField setBackgroundColor:[UIColor kAppYellowColor]];
		[tempPlayer2TextField setReturnKeyType:UIReturnKeyDone];
		[tempPlayer2TextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
		[self setPlayer2TextField:tempPlayer2TextField];
		[tempPlayer2TextField release];
		[self addSubview:[self player2TextField]];
		// Player 3 Name Field
		UITextField *tempPlayer3TextField = [[UITextField alloc] initWithFrame:CGRectMake(240.0f, 120.0f, 75.0f, 70.0f)];
		[tempPlayer3TextField setBackgroundColor:[UIColor kAppYellowColor]];
		[tempPlayer3TextField setReturnKeyType:UIReturnKeyDone];
		[tempPlayer3TextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
		[self setPlayer3TextField:tempPlayer3TextField];
		[tempPlayer3TextField release];
		[self addSubview:[self player3TextField]];
		// Player 4 Name Field
		UITextField *tempPlayer4TextField = [[UITextField alloc] initWithFrame:CGRectMake(5.0f, 120.0f, 75.0f, 70.0f)];
		[tempPlayer4TextField setBackgroundColor:[UIColor kAppYellowColor]];
		[tempPlayer4TextField setTextAlignment:UITextAlignmentRight];
		[tempPlayer4TextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
		[tempPlayer4TextField setReturnKeyType:UIReturnKeyDone];
		[self setPlayer4TextField:tempPlayer4TextField];
		[tempPlayer4TextField release];
		[self addSubview:[self player4TextField]];
		//Player 1 Avatar View
		StickPersonView *tempPlayer1AvatarView = [[StickPersonView alloc] initWithOutterFrame:CGRectMake(0.0, 0.0f, 44.0f, 60.0f) innerFrame:CGRectMake(5.0f, 0.0f, 30.0f, 60.0f)];
		[tempPlayer1AvatarView setCenter:CGPointMake(102.0f, 40.0f)];
		[tempPlayer1AvatarView setTag:kPlayer1Avatar];
		[tempPlayer1AvatarView setExclusiveTouch:YES];
		UITapGestureRecognizer *player1DoubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(assignDealerToPlayer1:)];
		[player1DoubleTapGestureRecognizer setNumberOfTapsRequired:2];
		[tempPlayer1AvatarView addGestureRecognizer:player1DoubleTapGestureRecognizer];
		[player1DoubleTapGestureRecognizer release];
		[self addSubview:tempPlayer1AvatarView];
		[tempPlayer1AvatarView release];
		//Player 2 Avatar View
		StickPersonView *tempPlayer2AvatarView = [[StickPersonView alloc] initWithOutterFrame:CGRectMake(0.0, 0.0f, 44.0f, 60.0f) innerFrame:CGRectMake(9.0f, 0.0f, 30.0f, 60.0f)];
		[tempPlayer2AvatarView setCenter:CGPointMake(218.0f, 40.0f)];
		[tempPlayer2AvatarView setTag:kPlayer2Avatar];
		UITapGestureRecognizer *player2DoubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(assignDealerToPlayer2:)];
		[player2DoubleTapGestureRecognizer setNumberOfTapsRequired:2];
		[tempPlayer2AvatarView addGestureRecognizer:player2DoubleTapGestureRecognizer];
		[player2DoubleTapGestureRecognizer release];
		[self addSubview:tempPlayer2AvatarView];
		[tempPlayer2AvatarView release];
		//Player 3 Avatar View
		StickPersonView *tempPlayer3AvatarView = [[StickPersonView alloc] initWithOutterFrame:CGRectMake(0.0, 0.0f, 44.0f, 60.0f) innerFrame:CGRectMake(9.0f, 0.0f, 30.0f, 60.0f)];
		[tempPlayer3AvatarView setCenter:CGPointMake(218.0f, 155.0f)];
		[tempPlayer3AvatarView setTag:kPlayer3Avatar];
		UITapGestureRecognizer *player3DoubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(assignDealerToPlayer3:)];
		[player3DoubleTapGestureRecognizer setNumberOfTapsRequired:2];
		[tempPlayer3AvatarView addGestureRecognizer:player3DoubleTapGestureRecognizer];
		[player3DoubleTapGestureRecognizer release];
		[self addSubview:tempPlayer3AvatarView];
		[tempPlayer3AvatarView release];
		//Player 4 Avatar View
		StickPersonView *tempPlayer4AvatarView = [[StickPersonView alloc] initWithOutterFrame:CGRectMake(0.0, 0.0f, 44.0f, 60.0f) innerFrame:CGRectMake(5.0f, 0.0f, 30.0f, 60.0f)];
		[tempPlayer4AvatarView setCenter:CGPointMake(102.0f, 155.0f)];
		[tempPlayer4AvatarView setTag:kPlayer4Avatar];
		UITapGestureRecognizer *player4DoubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(assignDealerToPlayer4:)];
		[player4DoubleTapGestureRecognizer setNumberOfTapsRequired:2];
		[tempPlayer4AvatarView addGestureRecognizer:player4DoubleTapGestureRecognizer];
		[player4DoubleTapGestureRecognizer release];
		[self addSubview:tempPlayer4AvatarView];
		[tempPlayer4AvatarView release];
		// Team13 ScoreName Label
		UILabel *tempTeam13ScoreNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(155.0f, 190.0f, 75.0f, 40.0f)];
		[tempTeam13ScoreNameLabel setNumberOfLines:2];
		[tempTeam13ScoreNameLabel setLineBreakMode:UILineBreakModeWordWrap];
		[tempTeam13ScoreNameLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[tempTeam13ScoreNameLabel setFont:[UIFont systemFontOfSize:12.0f]];
		[self setTeam13ScoreNameLabel:tempTeam13ScoreNameLabel];
		[self addSubview:[self team13ScoreNameLabel]];
		[tempTeam13ScoreNameLabel release];
		// Team24 ScoreName Label
		UILabel *tempTeam24ScoreNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(230.0f, 190.0f, 75.0f, 40.0f)];
		[tempTeam24ScoreNameLabel setNumberOfLines:2];
		[tempTeam24ScoreNameLabel setLineBreakMode:UILineBreakModeWordWrap];
		[tempTeam24ScoreNameLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[tempTeam24ScoreNameLabel setFont:[UIFont systemFontOfSize:12.0f]];
		[self setTeam24ScoreNameLabel:tempTeam24ScoreNameLabel];
		[self addSubview:[self team24ScoreNameLabel]];
		[tempTeam24ScoreNameLabel release];
		// Dealer Button
		UILabel *tempDealerLabel = [[UILabel alloc] initWithFrame:CGRectMake(114.0f, 35.0f, 20.0f, 20.0f)];
		[tempDealerLabel setBackgroundColor:[UIColor clearColor]];
		[tempDealerLabel setOpaque:NO];
		[tempDealerLabel setTextAlignment:UITextAlignmentCenter];
		[tempDealerLabel setFont:[UIFont systemFontOfSize:12.0f]];
		[tempDealerLabel setText:NSLocalizedString(@"D", @"D for dealer")];
		DealerButtonView *dealerButton = [[DealerButtonView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 20.0f, 20.0f)];
		[tempDealerLabel addSubview:dealerButton];
		[self setDealerLabel:tempDealerLabel];
		[self addSubview:[self dealerLabel]];
		[tempDealerLabel release];
    }
    return self;
}

- (void)assignDealerToPlayer1:(id)sender
{
	//[[sender setEnabled:NO];
	if ([sender state] == UIGestureRecognizerStateCancelled)
		return;
	if ([[self delegate] shouldChangeDealerToPlayer:1])
		[self moveDealerToPlayer:1];
	//[[sender setEnabled:YES];
}

- (void)assignDealerToPlayer2:(id)sender
{
	if ([sender state] == UIGestureRecognizerStateCancelled)
		return;
	if ([[self delegate] shouldChangeDealerToPlayer:2])
		[self moveDealerToPlayer:2];
}

- (void)assignDealerToPlayer3:(id)sender
{
	if ([sender state] == UIGestureRecognizerStateCancelled)
		return;
	if ([[self delegate] shouldChangeDealerToPlayer:3])
		[self moveDealerToPlayer:3];
}

- (void)assignDealerToPlayer4:(id)sender
{
	if ([sender state] == UIGestureRecognizerStateCancelled)
		return;
	if ([[self delegate] shouldChangeDealerToPlayer:4])
		[self moveDealerToPlayer:4];
}

- (void)moveDealerToPlayer:(NSInteger)argPlayer
{	
	switch (argPlayer) 
	{
		case 1:
			[UIView animateWithDuration:0.25 animations:^{[[self dealerLabel] setCenter:CGPointMake(124.0f, 45.0f)];}];
			break;
		case 2:
			[UIView animateWithDuration:0.25 animations:^{[[self dealerLabel] setCenter:CGPointMake(200.0f, 45.0f)];}];
			break;
		case 3:
			[UIView animateWithDuration:0.25 animations:^{[[self dealerLabel] setCenter:CGPointMake(200.0f, 159.0f)];}];
			break;
		case 4:
			[UIView animateWithDuration:0.25f animations:^{[[self dealerLabel] setCenter:CGPointMake(124.0f, 159.0f)];}];
			break;
		default:
			break;
	}
}

- (void)dealloc 
{
	[player1TextField release];
	[player2TextField release];
	[player3TextField release];
	[player4TextField release];
	[team13ScoreNameLabel release];
	[team24ScoreNameLabel release];
    [super dealloc];
}

@synthesize player1TextField;
@synthesize player2TextField;
@synthesize player3TextField;
@synthesize player4TextField;
@synthesize mainActionButton;
@synthesize team13ScoreNameLabel;
@synthesize team24ScoreNameLabel;
@synthesize dealerLabel;
@synthesize delegate;
@end
