//
//  Bids.m
//  CardScore500
//
//  Created by Joe Bonniwell on 10/5/10.
//  Copyright 2010 Joe Bonniwell. All rights reserved.
//

#import "Bids.h"

const int k_NoBid = 0;
const int k_6Spades = 1;
const int k_6Clubs = 2;
const int k_6Diamonds = 3;
const int k_6Hearts = 4;
const int k_6NoTrump = 5;
const int k_7Spades = 6;
const int k_7Clubs = 7;
const int k_7Diamonds = 8;
const int k_7Hearts = 9;
const int k_7NoTrump = 10;
const int k_8Spades = 11;
const int k_SingleLow = 12;
const int k_8Clubs = 13;
const int k_8Diamonds = 14;
const int k_8Hearts = 15;
const int k_8NoTrump = 16;
const int k_9Spades = 17;
const int k_9Clubs = 18;
const int k_9Diamonds = 19;
const int k_9Hearts = 20;
const int k_9NoTrump = 21;
const int k_10Spades = 22;
const int k_10Clubs = 23;
const int k_10Diamonds = 24;
const int k_10Hearts = 25;
const int k_DoubleLow = 26;
const int k_10NoTrump = 27;

const int bidPoints[28] = { 0,
	40, 60, 80, 100, 120,
	140, 160, 180, 200, 220,
	240, 250, 260, 280, 300,
	320, 340, 360, 380, 400,
	420, 440, 460, 480, 500,
	500, 520				};

const int bidMinTricks[28] = {  0,
	6, 6, 6, 6, 6,
	7, 7, 7, 7, 7,
	8, 0, 8, 8, 8,
	8, 9, 9, 9, 9,
	9, 10, 10, 10, 10,
	0, 10			};

const int bidMaxTricks[28] = {  0,
	10, 10, 10, 10, 10,
	10, 10, 10, 10, 10,
	10, 0, 10, 10, 10,
	10, 10, 10, 10, 10,
	10, 10, 10, 10, 10,
	0, 10			};

NSString *bidNames(int index)
{
	switch (index) {
		case 0:
			return NSLocalizedString(@"No Bid", @"No Bid");
			break;
		case 1:
			return NSLocalizedString(@"6 Spades", @"6 Spades");
			break;
		case 2:
			return NSLocalizedString(@"6 Clubs", @"6 Clubs");
			break;
		case 3:
			return NSLocalizedString(@"6 Diamonds", @"6 Diamonds");
			break;
		case 4:
			return NSLocalizedString(@"6 Hearts", @"6 Hearts");
			break;
		case 5:
			return NSLocalizedString(@"6 No Trump", @"6 No Trump");
			break;
		case 6:
			return NSLocalizedString(@"7 Spades", @"7 Spades");
			break;
		case 7:
			return NSLocalizedString(@"7 Clubs", @"7 Clubs");
			break;
		case 8:
			return NSLocalizedString(@"7 Diamonds", @"7 Diamonds");
			break;
		case 9:
			return NSLocalizedString(@"7 Hearts", @"7 Hearts");
			break;
		case 10:
			return NSLocalizedString(@"7 No Trump", @"7 No Trump");
			break;
		case 11:
			return NSLocalizedString(@"8 Spades", @"8 Spades");
			break;
		case 12:
			return NSLocalizedString(@"Single Misere", @"Single Misere");
			break;
		case 13:
			return NSLocalizedString(@"8 Clubs", @"8 Clubs");
			break;
		case 14:
			return NSLocalizedString(@"8 Diamonds", @"8 Diamonds");
			break;
		case 15:
			return NSLocalizedString(@"8 Hearts", @"8 Hearts");
			break;
		case 16:
			return NSLocalizedString(@"8 No Trump", @"8 No Trump");
			break;
		case 17:
			return NSLocalizedString(@"9 Spades", @"9 Spades");
			break;
		case 18:
			return NSLocalizedString(@"9 Clubs", @"9 Clubs");
			break;
		case 19:
			return NSLocalizedString(@"9 Diamonds", @"9 Diamonds");
			break;
		case 20:
			return NSLocalizedString(@"9 Hearts", @"9 Hearts");
			break;
		case 21:
			return NSLocalizedString(@"9 No Trump", @"9 No Trump");
			break;
		case 22:
			return NSLocalizedString(@"10 Spades", @"10 Spades");
			break;
		case 23:
			return NSLocalizedString(@"10 Clubs", @"10 Clubs");
			break;
		case 24:
			return NSLocalizedString(@"10 Diamonds", @"10 Diamonds");
			break;
		case 25:
			return NSLocalizedString(@"10 Hearts", @"10 Hearts");
			break;
		case 26:
			return NSLocalizedString(@"Double Misere", @"Double Misere");
			break;
		case 27:
			return NSLocalizedString(@"10 No Trump", @"10 No Trump");
			break;
		default:
			return nil;
			break;
	}
	return nil;
}