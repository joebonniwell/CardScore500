//
//  Bids.h
//  CardScore500
//
//  Created by Joe Bonniwell on 10/5/10.
//  Copyright 2010 Joe Bonniwell. All rights reserved.
//

const int k_NoBid;
const int k_6Spades;
const int k_6Clubs;
const int k_6Diamonds;
const int k_6Hearts;
const int k_6NoTrump;
const int k_7Spades;
const int k_7Clubs;
const int k_7Diamonds;
const int k_7Hearts;
const int k_7NoTrump;
const int k_8Spades;
const int k_SingleLow;
const int k_8Clubs;
const int k_8Diamonds;
const int k_8Hearts;
const int k_8NoTrump;
const int k_9Spades;
const int k_9Clubs;
const int k_9Diamonds;
const int k_9Hearts;
const int k_9NoTrump;
const int k_10Spades;
const int k_10Clubs;
const int k_10Diamonds;
const int k_10Hearts;
const int k_DoubleLow;
const int k_10NoTrump;

const int bidPoints[28];

const int bidMinTricks[28];

const int bidMaxTricks[28];

NSString * bidNames(int index);
