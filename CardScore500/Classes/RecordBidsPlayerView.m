//
//  RecordBidsPlayerView.m
//  UserInterface
//
//  Created by Joe Bonniwell on 9/17/10.
//  Copyright 2010 Joe Bonniwell. All rights reserved.
//
#define kPlayerNameLabel 1
#define kBidNameLabel 2
#import "RecordBidsPlayerView.h"

@implementation RecordBidsPlayerView

- (id)initWithLabelPosition:(NSInteger)argLabelPosition andFrame:(CGRect)argFrame
{
	[self initWithFrame:argFrame];
	// Player Name Label	
	UILabel *tempPlayerNameLabel;
	UILabel *tempBidNameLabel;
	StickPersonView *tempPlayerAvatar;
	if (argLabelPosition == kLabelPositionRight)
	{
		tempPlayerNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(35.0f, 5.0f, 85.0f, 25.0f)];
		tempBidNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(35.0f, 30.0f, 85.0f, 20.0f)];
		tempPlayerAvatar = [[StickPersonView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 25.0f, 50.0f)];
	}
	else // kLabelPositionLeft
	{
		tempPlayerNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 5.0f, 85.0f, 25.0f)];
		[tempPlayerNameLabel setTextAlignment:UITextAlignmentRight];
		tempBidNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 30.0f, 85.0f, 20.0f)];
		[tempBidNameLabel setTextAlignment:UITextAlignmentRight];
		tempPlayerAvatar = [[StickPersonView alloc] initWithFrame:CGRectMake(90.0f, 0.0f, 25.0f, 50.0f)];
	}
	[tempPlayerNameLabel setBackgroundColor:[UIColor kAppYellowColor]];
	[tempPlayerNameLabel setFont:[UIFont systemFontOfSize:18.0f]];
	[tempPlayerNameLabel setTag:kPlayerNameLabel];
	[self addSubview:tempPlayerNameLabel];
	[tempBidNameLabel setBackgroundColor:[UIColor kAppYellowColor]];
	[tempBidNameLabel setFont:[UIFont systemFontOfSize:14.0f]];
	[tempBidNameLabel setTag:kBidNameLabel];
	[self addSubview:tempBidNameLabel];
	// Player Avatar
	[self addSubview:tempPlayerAvatar];
	[tempPlayerAvatar release];
	return self;
}

- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) 
	{
        [self setBackgroundColor:[UIColor kAppYellowColor]];
    }
    return self;
}

- (void)dealloc 
{
	[playerName release];
	[bidName release];
    [super dealloc];
}

- (void)attachPlayerName:(NSString*)argPlayerName
{
	[self setPlayerName:argPlayerName];
	UILabel *playerNameLabel = (UILabel*)[self viewWithTag:kPlayerNameLabel];
	[playerNameLabel setText:[self playerName]];
}

- (void)attachBidName:(NSString *)argBidName
{
	[self setBidName:argBidName];
	UILabel *bidNameLabel = (UILabel*)[self viewWithTag:kBidNameLabel];
	[bidNameLabel setText:[self bidName]];
}

@synthesize playerName;
@synthesize bidName;
@end
