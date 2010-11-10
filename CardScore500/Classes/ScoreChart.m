//
//  ScoreChart.m
//  UserInterface
//
//  Created by Joe Bonniwell on 9/18/10.
//  Copyright 2010 Joe Bonniwell. All rights reserved.
//
#define kScoreChartFontSize 12

#import "ScoreChart.h"

@implementation ScoreChart


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) 
	{
        // Spades
		UILabel *spadesLabel = [[UILabel alloc] initWithFrame:CGRectMake(25.0f, 5.0f, 58.0f, 25.0f)];
		[spadesLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[spadesLabel setTextAlignment:UITextAlignmentCenter];
		[spadesLabel setFont:[UIFont systemFontOfSize:kScoreChartFontSize]];
		[spadesLabel setText:NSLocalizedString(@"Spades", @"Spades")];
		[self addSubview:spadesLabel];
		[spadesLabel release];
		// Clubs
		UILabel *clubsLabel = [[UILabel alloc] initWithFrame:CGRectMake(83.0f, 5.0f, 58.0f, 25.0f)];
		[clubsLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[clubsLabel setTextAlignment:UITextAlignmentCenter];
		[clubsLabel setFont:[UIFont systemFontOfSize:kScoreChartFontSize]];
		[clubsLabel setText:NSLocalizedString(@"Clubs", @"Clubs")];
		[self addSubview:clubsLabel];
		[clubsLabel release];
		// Diamonds
		UILabel *diamondsLabel = [[UILabel alloc] initWithFrame:CGRectMake(141.0f, 5.0f, 58.0f, 25.0f)];
		[diamondsLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[diamondsLabel setTextAlignment:UITextAlignmentCenter];
		[diamondsLabel setFont:[UIFont systemFontOfSize:kScoreChartFontSize]];
		[diamondsLabel setText:NSLocalizedString(@"Diamonds", @"Diamonds")];
		[self addSubview:diamondsLabel];
		[diamondsLabel release];
		// Hearts
		UILabel *heartsLabel = [[UILabel alloc] initWithFrame:CGRectMake(199.0f, 5.0f, 58.0f, 25.0f)];
		[heartsLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[heartsLabel setTextAlignment:UITextAlignmentCenter];
		[heartsLabel setFont:[UIFont systemFontOfSize:kScoreChartFontSize]];
		[heartsLabel setText:NSLocalizedString(@"Hearts", @"Hearts")];
		[self addSubview:heartsLabel];
		[heartsLabel release];
		// No Trump
		UILabel *noTrumpLabel = [[UILabel alloc] initWithFrame:CGRectMake(257.0f, 5.0f, 58.0f, 25.0f)];
		[noTrumpLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[noTrumpLabel setTextAlignment:UITextAlignmentCenter];
		[noTrumpLabel setFont:[UIFont systemFontOfSize:kScoreChartFontSize]];
		[noTrumpLabel setText:NSLocalizedString(@"No Trump", @"No Trump")];
		[self addSubview:noTrumpLabel];
		[noTrumpLabel release];
		// 6 Tricks
		UILabel *sixTricks = [[UILabel alloc] initWithFrame:CGRectMake(5.0f, 30.0f, 20.0f, 25.0f)];
		[sixTricks setBackgroundColor:[UIColor kAppYellowColor]];
		[sixTricks setTextAlignment:UITextAlignmentRight];
		[sixTricks setFont:[UIFont systemFontOfSize:kScoreChartFontSize]];
		[sixTricks setText:NSLocalizedString(@"6", @"6")];
		[self addSubview:sixTricks];
		[sixTricks release];
		// 6 Spades
		UILabel *sixSpadesLabel = [[UILabel alloc] initWithFrame:CGRectMake(25.0f, 30.0f, 58.0f, 25.0f)];
		[sixSpadesLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[sixSpadesLabel setTextAlignment:UITextAlignmentCenter];
		[sixSpadesLabel setFont:[UIFont systemFontOfSize:kScoreChartFontSize]];
		[sixSpadesLabel setText:NSLocalizedString(@"40", @"40")];
		[self addSubview:sixSpadesLabel];
		[sixSpadesLabel release];
		// 6 Clubs
		UILabel *sixClubsLabel = [[UILabel alloc] initWithFrame:CGRectMake(83.0f, 30.0f, 58.0f, 25.0f)];
		[sixClubsLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[sixClubsLabel setTextAlignment:UITextAlignmentCenter];
		[sixClubsLabel setFont:[UIFont systemFontOfSize:kScoreChartFontSize]];
		[sixClubsLabel setText:NSLocalizedString(@"60", @"60")];
		[self addSubview:sixClubsLabel];
		[sixClubsLabel release];
		// 6 Diamonds
		UILabel *sixDiamondsLabel = [[UILabel alloc] initWithFrame:CGRectMake(141.0f, 30.0f, 58.0f, 25.0f)];
		[sixDiamondsLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[sixDiamondsLabel setTextAlignment:UITextAlignmentCenter];
		[sixDiamondsLabel setFont:[UIFont systemFontOfSize:kScoreChartFontSize]];
		[sixDiamondsLabel setText:NSLocalizedString(@"80", @"80")];
		[self addSubview:sixDiamondsLabel];
		[sixDiamondsLabel release];
		// 6 Hearts
		UILabel *sixHeartsLabel = [[UILabel alloc] initWithFrame:CGRectMake(199.0f, 30.0f, 58.0f, 25.0f)];
		[sixHeartsLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[sixHeartsLabel setTextAlignment:UITextAlignmentCenter];
		[sixHeartsLabel setFont:[UIFont systemFontOfSize:kScoreChartFontSize]];
		[sixHeartsLabel setText:NSLocalizedString(@"100", @"100")];
		[self addSubview:sixHeartsLabel];
		[sixHeartsLabel release];
		// 6 No Trump
		UILabel *sixNoTrumpLabel = [[UILabel alloc] initWithFrame:CGRectMake(257.0f, 30.0f, 58.0f, 25.0f)];
		[sixNoTrumpLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[sixNoTrumpLabel setTextAlignment:UITextAlignmentCenter];
		[sixNoTrumpLabel setFont:[UIFont systemFontOfSize:kScoreChartFontSize]];
		[sixNoTrumpLabel setText:NSLocalizedString(@"120", @"120")];
		[self addSubview:sixNoTrumpLabel];
		[sixNoTrumpLabel release];
		// 7 Tricks
		UILabel *sevenTricks = [[UILabel alloc] initWithFrame:CGRectMake(5.0f, 55.0f, 20.0f, 25.0f)];
		[sevenTricks setBackgroundColor:[UIColor kAppYellowColor]];
		[sevenTricks setTextAlignment:UITextAlignmentRight];
		[sevenTricks setFont:[UIFont systemFontOfSize:kScoreChartFontSize]];
		[sevenTricks setText:NSLocalizedString(@"7", @"7")];
		[self addSubview:sevenTricks];
		[sevenTricks release];
		// 7 Spades
		UILabel *sevenSpadesLabel = [[UILabel alloc] initWithFrame:CGRectMake(25.0f, 55.0f, 58.0f, 25.0f)];
		[sevenSpadesLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[sevenSpadesLabel setTextAlignment:UITextAlignmentCenter];
		[sevenSpadesLabel setFont:[UIFont systemFontOfSize:kScoreChartFontSize]];
		[sevenSpadesLabel setText:NSLocalizedString(@"140", @"140")];
		[self addSubview:sevenSpadesLabel];
		[sevenSpadesLabel release];
		// 7 Clubs
		UILabel *sevenClubsLabel = [[UILabel alloc] initWithFrame:CGRectMake(83.0f, 55.0f, 58.0f, 25.0f)];
		[sevenClubsLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[sevenClubsLabel setTextAlignment:UITextAlignmentCenter];
		[sevenClubsLabel setFont:[UIFont systemFontOfSize:kScoreChartFontSize]];
		[sevenClubsLabel setText:NSLocalizedString(@"160", @"160")];
		[self addSubview:sevenClubsLabel];
		[sevenClubsLabel release];
		// 7 Diamonds
		UILabel *sevenDiamondsLabel = [[UILabel alloc] initWithFrame:CGRectMake(141.0f, 55.0f, 58.0f, 25.0f)];
		[sevenDiamondsLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[sevenDiamondsLabel setTextAlignment:UITextAlignmentCenter];
		[sevenDiamondsLabel setFont:[UIFont systemFontOfSize:kScoreChartFontSize]];
		[sevenDiamondsLabel setText:NSLocalizedString(@"180", @"180")];
		[self addSubview:sevenDiamondsLabel];
		[sevenDiamondsLabel release];
		// 7 Hearts
		UILabel *sevenHeartsLabel = [[UILabel alloc] initWithFrame:CGRectMake(199.0f, 55.0f, 58.0f, 25.0f)];
		[sevenHeartsLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[sevenHeartsLabel setTextAlignment:UITextAlignmentCenter];
		[sevenHeartsLabel setFont:[UIFont systemFontOfSize:kScoreChartFontSize]];
		[sevenHeartsLabel setText:NSLocalizedString(@"200", @"200")];
		[self addSubview:sevenHeartsLabel];
		[sevenHeartsLabel release];
		// 7 No Trump
		UILabel *sevenNoTrumpLabel = [[UILabel alloc] initWithFrame:CGRectMake(257.0f, 55.0f, 58.0f, 25.0f)];
		[sevenNoTrumpLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[sevenNoTrumpLabel setTextAlignment:UITextAlignmentCenter];
		[sevenNoTrumpLabel setFont:[UIFont systemFontOfSize:kScoreChartFontSize]];
		[sevenNoTrumpLabel setText:NSLocalizedString(@"220", @"220")];
		[self addSubview:sevenNoTrumpLabel];
		[sevenNoTrumpLabel release];
		// 8 Tricks
		UILabel *eightTricks = [[UILabel alloc] initWithFrame:CGRectMake(5.0f, 80.0f, 20.0f, 25.0f)];
		[eightTricks setBackgroundColor:[UIColor kAppYellowColor]];
		[eightTricks setTextAlignment:UITextAlignmentRight];
		[eightTricks setFont:[UIFont systemFontOfSize:kScoreChartFontSize]];
		[eightTricks setText:NSLocalizedString(@"8", @"8")];
		[self addSubview:eightTricks];
		[eightTricks release];
		// 8 Spades
		UILabel *eightSpadesLabel = [[UILabel alloc] initWithFrame:CGRectMake(25.0f, 80.0f, 58.0f, 25.0f)];
		[eightSpadesLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[eightSpadesLabel setTextAlignment:UITextAlignmentCenter];
		[eightSpadesLabel setFont:[UIFont systemFontOfSize:kScoreChartFontSize]];
		[eightSpadesLabel setText:NSLocalizedString(@"240", @"240")];
		[self addSubview:eightSpadesLabel];
		[eightSpadesLabel release];
		// 8 Clubs
		UILabel *eightClubsLabel = [[UILabel alloc] initWithFrame:CGRectMake(83.0f, 80.0f, 58.0f, 25.0f)];
		[eightClubsLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[eightClubsLabel setTextAlignment:UITextAlignmentCenter];
		[eightClubsLabel setFont:[UIFont systemFontOfSize:kScoreChartFontSize]];
		[eightClubsLabel setText:NSLocalizedString(@"260", @"260")];
		[self addSubview:eightClubsLabel];
		[eightClubsLabel release];
		// 8 Diamonds
		UILabel *eightDiamondsLabel = [[UILabel alloc] initWithFrame:CGRectMake(141.0f, 80.0f, 58.0f, 25.0f)];
		[eightDiamondsLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[eightDiamondsLabel setTextAlignment:UITextAlignmentCenter];
		[eightDiamondsLabel setFont:[UIFont systemFontOfSize:kScoreChartFontSize]];
		[eightDiamondsLabel setText:NSLocalizedString(@"280", @"280")];
		[self addSubview:eightDiamondsLabel];
		[eightDiamondsLabel release];
		// 8 Hearts
		UILabel *eightHeartsLabel = [[UILabel alloc] initWithFrame:CGRectMake(199.0f, 80.0f, 58.0f, 25.0f)];
		[eightHeartsLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[eightHeartsLabel setTextAlignment:UITextAlignmentCenter];
		[eightHeartsLabel setFont:[UIFont systemFontOfSize:kScoreChartFontSize]];
		[eightHeartsLabel setText:NSLocalizedString(@"300", @"300")];
		[self addSubview:eightHeartsLabel];
		[eightHeartsLabel release];
		// 8 No Trump
		UILabel *eightNoTrumpLabel = [[UILabel alloc] initWithFrame:CGRectMake(257.0f, 80.0f, 58.0f, 25.0f)];
		[eightNoTrumpLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[eightNoTrumpLabel setTextAlignment:UITextAlignmentCenter];
		[eightNoTrumpLabel setFont:[UIFont systemFontOfSize:kScoreChartFontSize]];
		[eightNoTrumpLabel setText:NSLocalizedString(@"320", @"320")];
		[self addSubview:eightNoTrumpLabel];
		[eightNoTrumpLabel release];
		// 9 Tricks
		UILabel *nineTricks = [[UILabel alloc] initWithFrame:CGRectMake(5.0f, 105.0f, 20.0f, 25.0f)];
		[nineTricks setBackgroundColor:[UIColor kAppYellowColor]];
		[nineTricks setTextAlignment:UITextAlignmentRight];
		[nineTricks setFont:[UIFont systemFontOfSize:kScoreChartFontSize]];
		[nineTricks setText:NSLocalizedString(@"9", @"9")];
		[self addSubview:nineTricks];
		[nineTricks release];
		// 9 Spades
		UILabel *nineSpadesLabel = [[UILabel alloc] initWithFrame:CGRectMake(25.0f, 105.0f, 58.0f, 25.0f)];
		[nineSpadesLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[nineSpadesLabel setTextAlignment:UITextAlignmentCenter];
		[nineSpadesLabel setFont:[UIFont systemFontOfSize:kScoreChartFontSize]];
		[nineSpadesLabel setText:NSLocalizedString(@"340", @"340")];
		[self addSubview:nineSpadesLabel];
		[nineSpadesLabel release];
		// 9 Clubs
		UILabel *nineClubsLabel = [[UILabel alloc] initWithFrame:CGRectMake(83.0f, 105.0f, 58.0f, 25.0f)];
		[nineClubsLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[nineClubsLabel setTextAlignment:UITextAlignmentCenter];
		[nineClubsLabel setFont:[UIFont systemFontOfSize:kScoreChartFontSize]];
		[nineClubsLabel setText:NSLocalizedString(@"360", @"360")];
		[self addSubview:nineClubsLabel];
		[nineClubsLabel release];
		// 9 Diamonds
		UILabel *nineDiamondsLabel = [[UILabel alloc] initWithFrame:CGRectMake(141.0f, 105.0f, 58.0f, 25.0f)];
		[nineDiamondsLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[nineDiamondsLabel setTextAlignment:UITextAlignmentCenter];
		[nineDiamondsLabel setFont:[UIFont systemFontOfSize:kScoreChartFontSize]];
		[nineDiamondsLabel setText:NSLocalizedString(@"380", @"380")];
		[self addSubview:nineDiamondsLabel];
		[nineDiamondsLabel release];
		// 9 Hearts
		UILabel *nineHeartsLabel = [[UILabel alloc] initWithFrame:CGRectMake(199.0f, 105.0f, 58.0f, 25.0f)];
		[nineHeartsLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[nineHeartsLabel setTextAlignment:UITextAlignmentCenter];
		[nineHeartsLabel setFont:[UIFont systemFontOfSize:kScoreChartFontSize]];
		[nineHeartsLabel setText:NSLocalizedString(@"400", @"400")];
		[self addSubview:nineHeartsLabel];
		[nineHeartsLabel release];
		// 9 No Trump
		UILabel *nineNoTrumpLabel = [[UILabel alloc] initWithFrame:CGRectMake(257.0f, 105.0f, 58.0f, 25.0f)];
		[nineNoTrumpLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[nineNoTrumpLabel setTextAlignment:UITextAlignmentCenter];
		[nineNoTrumpLabel setFont:[UIFont systemFontOfSize:kScoreChartFontSize]];
		[nineNoTrumpLabel setText:NSLocalizedString(@"420", @"420")];
		[self addSubview:nineNoTrumpLabel];
		[nineNoTrumpLabel release];
		// 10 Tricks
		UILabel *tenTricks = [[UILabel alloc] initWithFrame:CGRectMake(5.0f, 130.0f, 20.0f, 25.0f)];
		[tenTricks setBackgroundColor:[UIColor kAppYellowColor]];
		[tenTricks setTextAlignment:UITextAlignmentRight];
		[tenTricks setFont:[UIFont systemFontOfSize:kScoreChartFontSize]];
		[tenTricks setText:NSLocalizedString(@"10", @"10")];
		[self addSubview:tenTricks];
		[tenTricks release];
		// 10 Spades
		UILabel *tenSpadesLabel = [[UILabel alloc] initWithFrame:CGRectMake(25.0f, 130.0f, 58.0f, 25.0f)];
		[tenSpadesLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[tenSpadesLabel setTextAlignment:UITextAlignmentCenter];
		[tenSpadesLabel setFont:[UIFont systemFontOfSize:kScoreChartFontSize]];
		[tenSpadesLabel setText:NSLocalizedString(@"440", @"440")];
		[self addSubview:tenSpadesLabel];
		[tenSpadesLabel release];
		// 10 Clubs
		UILabel *tenClubsLabel = [[UILabel alloc] initWithFrame:CGRectMake(83.0f, 130.0f, 58.0f, 25.0f)];
		[tenClubsLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[tenClubsLabel setTextAlignment:UITextAlignmentCenter];
		[tenClubsLabel setFont:[UIFont systemFontOfSize:kScoreChartFontSize]];
		[tenClubsLabel setText:NSLocalizedString(@"460", @"460")];
		[self addSubview:tenClubsLabel];
		[tenClubsLabel release];
		// 10 Diamonds
		UILabel *tenDiamondsLabel = [[UILabel alloc] initWithFrame:CGRectMake(141.0f, 130.0f, 58.0f, 25.0f)];
		[tenDiamondsLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[tenDiamondsLabel setTextAlignment:UITextAlignmentCenter];
		[tenDiamondsLabel setFont:[UIFont systemFontOfSize:kScoreChartFontSize]];
		[tenDiamondsLabel setText:NSLocalizedString(@"480", @"480")];
		[self addSubview:tenDiamondsLabel];
		[tenDiamondsLabel release];
		// 10 Hearts
		UILabel *tenHeartsLabel = [[UILabel alloc] initWithFrame:CGRectMake(199.0f, 130.0f, 58.0f, 25.0f)];
		[tenHeartsLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[tenHeartsLabel setTextAlignment:UITextAlignmentCenter];
		[tenHeartsLabel setFont:[UIFont systemFontOfSize:kScoreChartFontSize]];
		[tenHeartsLabel setText:NSLocalizedString(@"500", @"500")];
		[self addSubview:tenHeartsLabel];
		[tenHeartsLabel release];
		// 10 No Trump
		UILabel *tenNoTrumpLabel = [[UILabel alloc] initWithFrame:CGRectMake(257.0f, 130.0f, 58.0f, 25.0f)];
		[tenNoTrumpLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[tenNoTrumpLabel setTextAlignment:UITextAlignmentCenter];
		[tenNoTrumpLabel setFont:[UIFont systemFontOfSize:kScoreChartFontSize]];
		[tenNoTrumpLabel setText:NSLocalizedString(@"520", @"520")];
		[self addSubview:tenNoTrumpLabel];
		[tenNoTrumpLabel release];
		// Nula
		UILabel *nulaLabel = [[UILabel alloc] initWithFrame:CGRectMake(65.0f, 172.0f, 60.0f, 25.0f)];
		[nulaLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[nulaLabel setFont:[UIFont systemFontOfSize:kScoreChartFontSize]];
		[nulaLabel setText:NSLocalizedString(@"Misere", @"Misere")];	// TODO: Replace with selected Nula equivalent from settings
		[self addSubview:nulaLabel];
		[nulaLabel release];
		// Single Nula
		UILabel *singleNulaLabel = [[UILabel alloc] initWithFrame:CGRectMake(118.0f, 160.0f, 58.0f, 25.0f)];
		[singleNulaLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[singleNulaLabel setFont:[UIFont systemFontOfSize:kScoreChartFontSize]];
		[singleNulaLabel setTextAlignment:UITextAlignmentCenter];
		[singleNulaLabel setText:NSLocalizedString(@"Single", @"Single")];
		[self addSubview:singleNulaLabel];
		[singleNulaLabel release];
		// Double Nula
		UILabel *doubleNulaLabel = [[UILabel alloc] initWithFrame:CGRectMake(174.0f, 160.0f, 58.0f, 25.0f)];
		[doubleNulaLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[doubleNulaLabel setFont:[UIFont systemFontOfSize:kScoreChartFontSize]];
		[doubleNulaLabel setTextAlignment:UITextAlignmentCenter];
		[doubleNulaLabel setText:NSLocalizedString(@"Double", @"Double")];
		[self addSubview:doubleNulaLabel];
		[doubleNulaLabel release];
		// Single Nula Score
		UILabel *singleNulaScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(118.0f, 185.0f, 58.0f, 25.0f)];
		[singleNulaScoreLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[singleNulaScoreLabel setFont:[UIFont systemFontOfSize:kScoreChartFontSize]];
		[singleNulaScoreLabel setTextAlignment:UITextAlignmentCenter];
		[singleNulaScoreLabel setText:NSLocalizedString(@"250", @"250")];
		[self addSubview:singleNulaScoreLabel];
		[singleNulaScoreLabel release];
		// Double Nula Value
		UILabel *doubleNulaScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(174.0f, 185.0f, 58.0f, 25.0f)];
		[doubleNulaScoreLabel setBackgroundColor:[UIColor kAppYellowColor]];
		[doubleNulaScoreLabel setFont:[UIFont systemFontOfSize:kScoreChartFontSize]];
		[doubleNulaScoreLabel setTextAlignment:UITextAlignmentCenter];
		[doubleNulaScoreLabel setText:NSLocalizedString(@"500", @"500")];
		[self addSubview:doubleNulaScoreLabel];
		[doubleNulaScoreLabel release];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
    [super dealloc];
}


@end
