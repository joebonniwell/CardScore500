//
//  CurvedShadow.m
//  CardScore500
//
//  Created by Joe Bonniwell on 11/11/10.
//  Copyright 2010 Joe Bonniwell. All rights reserved.
//

#import "CurvedShadow.h"


@implementation CurvedShadow


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		[self setOpaque:NO];
    }
    return self;
}

- (void)drawRect:(CGRect)rect 
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetShadow(context, CGSizeMake(0.0f, 3.0f), 8.0f);
	float lineWidth = 5.0f;
	CGContextSetLineWidth(context, lineWidth);
	CGContextSetStrokeColorWithColor(context, [[UIColor blackColor] CGColor]);
	//float diameter = rect.size.height + 0.25 * rect.size.width * rect.size.width / rect.size.height;
	//float newX = rect.origin.x - (rect.size.width * 1.5);
	//float newY = rect.origin.y - (rect.size.width * 4.0);
	//float newWidth = rect.size.width * 4.0;
	//float newHeight = rect.size.width * 4.0;
	//float radius = 105130.0 - lineWidth;
	//float newX = rect.origin.x + (rect.size.width * 0.5) - radius ;
	//float newY = rect.origin.y - (radius * 2.0);
	//float newWidth = 2.0f * radius;
	//float newHeight = 2.0f * radius;
	CGContextStrokeRect(context, CGRectMake(rect.origin.x, rect.origin.y - rect.size.height - lineWidth, rect.size.width, rect.size.height));
	//CGContextStrokeEllipseInRect(context, CGRectMake(newX, newY, newWidth, newHeight));
}

- (void)dealloc {
    [super dealloc];
}


@end
