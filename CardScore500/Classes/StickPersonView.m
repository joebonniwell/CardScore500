//
//  StickPersonView.m
//  StickPersonAnimations
//
//  Created by Joe Bonniwell on 8/30/10.
//  Copyright 2010 Joe Bonniwell. All rights reserved.
//

#import "StickPersonView.h"

@implementation StickPersonView

- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) 
	{
        [self setOpaque:NO];
    }
    return self;
}

- (void)drawRect:(CGRect)rect 
{
	CGContextRef currentContext = UIGraphicsGetCurrentContext();
	// Set stroke details
	CGContextSetLineWidth(currentContext, (int)([self bounds].size.width / 40) + 1);
	CGContextSetLineCap(currentContext, kCGLineCapRound);
	CGContextSetStrokeColorWithColor(currentContext, [[UIColor blackColor] CGColor]);
	// Draw the Head
	CGContextAddArc(currentContext, ([self bounds].size.width / 2.0f), ([self bounds].size.height / 4.0f), ([self bounds].size.width / 4.0), 0.0f, 2.0*M_PI, 0);
	CGContextStrokePath(currentContext);
	// Draw the body
	CGContextMoveToPoint(currentContext, ([self bounds].size.width / 2.0f), ([self bounds].size.height / 4.0f + [self bounds].size.width / 4.0f));
	CGContextAddLineToPoint(currentContext, ([self bounds].size.width / 2.0f), (2.0f * [self bounds].size.height / 3.0f));
	CGContextStrokePath(currentContext);
	// Draw the right leg
	CGContextMoveToPoint(currentContext, ([self bounds].size.width / 2.0f), (2.0f * [self bounds].size.height / 3.0f));
	CGContextAddLineToPoint(currentContext, (5.0f * [self bounds].size.width / 6.0f), (7.0f * [self bounds].size.height / 8.0f));
	CGContextStrokePath(currentContext);
	// Draw the left leg
	CGContextMoveToPoint(currentContext, ([self bounds].size.width / 2.0f), (2.0f * [self bounds].size.height / 3.0f));
	CGContextAddLineToPoint(currentContext, ([self bounds].size.width / 6.0f), (7.0f * [self bounds].size.height / 8.0f));
	CGContextStrokePath(currentContext);
	// Draw the right arm
	CGContextMoveToPoint(currentContext, ([self bounds].size.width / 2.0f), (8.0f * [self bounds].size.height / 16.0f));
	CGContextAddLineToPoint(currentContext, (5.0f * [self bounds].size.width / 6.0f), (3.0f * [self bounds].size.height / 8.0f));
	CGContextStrokePath(currentContext);
	// Draw the left arm
	CGContextMoveToPoint(currentContext, ([self bounds].size.width / 2.0f), (8.0f * [self bounds].size.height / 16.0f));
	CGContextAddLineToPoint(currentContext, ([self bounds].size.width / 6.0f), (3.0f * [self bounds].size.height / 8.0f));
	CGContextStrokePath(currentContext);
}

@end
