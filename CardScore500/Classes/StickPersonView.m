//
//  StickPersonView.m
//  StickPersonAnimations
//
//  Created by Joe Bonniwell on 8/30/10.
//  Copyright 2010 Joe Bonniwell. All rights reserved.
//

#import "StickPersonView.h"

@implementation StickPersonView

- (id)initWithFrame:(CGRect)argFrame 
{
    return [self initWithOutterFrame:argFrame innerFrame:CGRectMake(0.0f, 0.0f, argFrame.size.width, argFrame.size.height)];
}

- (id)initWithOutterFrame:(CGRect)argOutterFrame innerFrame:(CGRect)argInnerFrame
{
	if ((self = [super initWithFrame:argOutterFrame]))
	{
		innerFrame = argInnerFrame;
		[self setOpaque:NO];
	}
	return self;
}

- (void)drawRect:(CGRect)rect 
{
	CGContextRef currentContext = UIGraphicsGetCurrentContext();
	// Set stroke details
	CGContextSetLineWidth(currentContext, (int)(innerFrame.size.width / 40) + 1);
	CGContextSetLineCap(currentContext, kCGLineCapRound);
	CGContextSetStrokeColorWithColor(currentContext, [[UIColor blackColor] CGColor]);
	// Draw the Head
	CGContextAddArc(currentContext, (innerFrame.size.width / 2.0f) + innerFrame.origin.x, (innerFrame.size.height / 4.0f) + innerFrame.origin.y, (innerFrame.size.width / 4.0), 0.0f, 2.0*M_PI, 0);
	CGContextStrokePath(currentContext);
	// Draw the body
	CGContextMoveToPoint(currentContext, (innerFrame.size.width / 2.0f) + innerFrame.origin.x, (innerFrame.size.height / 4.0f + innerFrame.size.width / 4.0f) + innerFrame.origin.y);
	CGContextAddLineToPoint(currentContext, (innerFrame.size.width / 2.0f) + innerFrame.origin.x, (2.0f * innerFrame.size.height / 3.0f) + innerFrame.origin.y);
	CGContextStrokePath(currentContext);
	// Draw the right leg
	CGContextMoveToPoint(currentContext, (innerFrame.size.width / 2.0f) + innerFrame.origin.x, (2.0f * innerFrame.size.height / 3.0f) + innerFrame.origin.y);
	CGContextAddLineToPoint(currentContext, (5.0f * innerFrame.size.width / 6.0f) + innerFrame.origin.x, (7.0f * innerFrame.size.height / 8.0f) + innerFrame.origin.y);
	CGContextStrokePath(currentContext);
	// Draw the left leg
	CGContextMoveToPoint(currentContext, (innerFrame.size.width / 2.0f) + innerFrame.origin.x, (2.0f * innerFrame.size.height / 3.0f) + innerFrame.origin.y);
	CGContextAddLineToPoint(currentContext, (innerFrame.size.width / 6.0f) + innerFrame.origin.x, (7.0f * innerFrame.size.height / 8.0f) + innerFrame.origin.y);
	CGContextStrokePath(currentContext);
	// Draw the right arm
	CGContextMoveToPoint(currentContext, (innerFrame.size.width / 2.0f) + innerFrame.origin.x, (8.0f * innerFrame.size.height / 16.0f) + innerFrame.origin.y);
	CGContextAddLineToPoint(currentContext, (5.0f * innerFrame.size.width / 6.0f) + innerFrame.origin.x, (3.0f * innerFrame.size.height / 8.0f) + innerFrame.origin.y);
	CGContextStrokePath(currentContext);
	// Draw the left arm
	CGContextMoveToPoint(currentContext, (innerFrame.size.width / 2.0f) + innerFrame.origin.x, (8.0f * innerFrame.size.height / 16.0f) + innerFrame.origin.y);
	CGContextAddLineToPoint(currentContext, (innerFrame.size.width / 6.0f) + innerFrame.origin.x, (3.0f * innerFrame.size.height / 8.0f) + innerFrame.origin.y);
	CGContextStrokePath(currentContext);
}

@end
