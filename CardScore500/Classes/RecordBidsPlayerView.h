//
//  RecordBidsPlayerView.h
//  UserInterface
//
//  Created by Joe Bonniwell on 9/17/10.
//  Copyright 2010 Joe Bonniwell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StickPersonView.h"

@interface RecordBidsPlayerView : UIView 
{
	NSString *playerName;
	NSString *bidName;
}
@property (nonatomic, retain) NSString *playerName;
@property (nonatomic, retain) NSString *bidName;

- (void)attachPlayerName:(NSString*)argPlayerName;
- (void)attachBidName:(NSString*)argBidName;
- (id)initWithLabelPosition:(NSInteger)argLabelPosition andFrame:(CGRect)argFrame;
@end
