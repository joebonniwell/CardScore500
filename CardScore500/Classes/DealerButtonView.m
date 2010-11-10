//
//  DealerButton.m
//  CardScore500
//
//  Created by Joe Bonniwell on 10/5/10.
//  Copyright 2010 Joe Bonniwell. All rights reserved.
//

#import "DealerButtonView.h"

@implementation DealerButtonView

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
	CGContextSetLineWidth(currentContext, 1.0f);
	CGContextSetStrokeColorWithColor(currentContext, [[UIColor blackColor] CGColor]);
	CGContextAddArc(currentContext, ([self bounds].size.width / 2.0), ([self bounds].size.height / 2.0), ([self bounds].size.width / 2.0) - 2.0, 0.0f, 2.0*M_PI, 0);
	CGContextStrokePath(currentContext);
}

- (void)dealloc 
{
    [super dealloc];
}

@end
