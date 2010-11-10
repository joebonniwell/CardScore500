//
//  GamesTableViewCell.m
//  UserInterface
//
//  Created by Joe Bonniwell on 9/29/10.
//  Copyright 2010 Joe Bonniwell. All rights reserved.
//

#import "GamesTableViewCell.h"


@implementation GamesTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier 
{
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) 
	{
        // Initialization code
		[self setBackgroundColor:[UIColor kAppYellowColor]];
		// Team 13 Name Label
		UILabel *tempTeam13NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.0f, 0.0f, 125.0f, 20.0f)];
		[tempTeam13NameLabel setTag:kTeam13NameLabel];
		[tempTeam13NameLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[[self contentView] addSubview:tempTeam13NameLabel];
		[tempTeam13NameLabel release];
		// Team 24 Name Label
		UILabel *tempTeam24NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.0f, 20.0f, 125.0f, 20.0f)];
		[tempTeam24NameLabel setTag:kTeam24NameLabel];
		[tempTeam24NameLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[[self contentView] addSubview:tempTeam24NameLabel];
		[tempTeam24NameLabel release];
		// Team 13 Score Label
		UILabel *tempTeam13ScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(160.0f, 0.0f, 30.0f, 20.0f)];
		[tempTeam13ScoreLabel setTag:kTeam13ScoreLabel];
		[tempTeam13ScoreLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[tempTeam13ScoreLabel setTextAlignment:UITextAlignmentCenter];
		[[self contentView] addSubview:tempTeam13ScoreLabel];
		[tempTeam13ScoreLabel release];
		// Team 24 Score Label
		UILabel *tempTeam24ScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(160.0f, 20.0f, 30.0f, 20.0f)];
		[tempTeam24ScoreLabel setTag:kTeam24ScoreLabel];
		[tempTeam24ScoreLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[tempTeam24ScoreLabel setTextAlignment:UITextAlignmentCenter];
		[[self contentView] addSubview:tempTeam24ScoreLabel];
		[tempTeam24ScoreLabel release];
		// Game Date Label
		UILabel *tempGameDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(200.0f, 0.0f, 80.0f, 40.0f)];
		[tempGameDateLabel setTag:kGameDateLabel];
		[tempGameDateLabel setFont:[UIFont systemFontOfSize:14.0f]];
		[tempGameDateLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[tempGameDateLabel setTextAlignment:UITextAlignmentRight];
		[[self contentView] addSubview:tempGameDateLabel];
		[tempGameDateLabel release];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated 
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setEditing:(BOOL)argEditing animated:(BOOL)argAnimated
{
	[super setEditing:argEditing animated:argAnimated];
	if (argEditing)
	{
		UILabel *team13ScoreLabel = (UILabel*)[[self contentView] viewWithTag:kTeam13ScoreLabel];
		UILabel *team24ScoreLabel = (UILabel*)[[self contentView] viewWithTag:kTeam24ScoreLabel];
		UILabel *gameDateLabel = (UILabel*)[[self contentView] viewWithTag:kGameDateLabel];		
		[UIView animateWithDuration:0.3 animations:^{
			[team13ScoreLabel setFrame:CGRectMake(133.0f, 0.0f, 40.0f, 20.0f)];
			[team24ScoreLabel setFrame:CGRectMake(133.0f, 20.0f, 40.0f, 20.0f)];
			[gameDateLabel setFrame:CGRectMake(170.0f, 0.0f, 80.0f, 40.0f)];
		}];	
	}
	else 
	{
		UILabel *team13ScoreLabel = (UILabel*)[[self contentView] viewWithTag:kTeam13ScoreLabel];
		UILabel *team24ScoreLabel = (UILabel*)[[self contentView] viewWithTag:kTeam24ScoreLabel];
		UILabel *gameDateLabel = (UILabel*)[[self contentView] viewWithTag:kGameDateLabel];
		[UIView animateWithDuration:0.3 animations:^{
			[team13ScoreLabel setFrame:CGRectMake(150.0f, 0.0f, 40.0f, 20.0f)];
			[team24ScoreLabel setFrame:CGRectMake(150.0f, 20.0f, 40.0f, 20.0f)];
			[gameDateLabel setFrame:CGRectMake(200.0f, 0.0f, 80.0f, 40.0f)];
		}];
	}
}

- (void)dealloc 
{
    [super dealloc];
}

@end
