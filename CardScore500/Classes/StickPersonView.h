//
//  StickPersonView.h
//  StickPersonAnimations
//
//  Created by Joe Bonniwell on 8/30/10.
//  Copyright 2010 Joe Bonniwell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StickPersonView : UIView 
{
	CGRect innerFrame;
}

- (id)initWithOutterFrame:(CGRect)argOutterFrame innerFrame:(CGRect)argInnerFrame;

@end
