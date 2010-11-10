//
//  InformationViewController.m
//  UserInterface
//
//  Created by Joe Bonniwell on 9/29/10.
//  Copyright 2010 Joe Bonniwell. All rights reserved.
//

#import "InformationViewController.h"

@implementation InformationViewController

- (void)loadView 
{
	// Navigation Item
	[[self navigationItem] setTitle:NSLocalizedString(@"Information", @"Information")];
	// Information View
	UIView *tempInformationView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 416.0f)];
	[tempInformationView setBackgroundColor:[UIColor kAppYellowColor]];	
	[self setView:tempInformationView];
	[tempInformationView release];
	// Background Image (Yellow Color) for support button
	UIGraphicsBeginImageContext(CGSizeMake(300.0f, 80.0f));
	CGContextRef currentContext = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(currentContext, [[UIColor kAppYellowColor] CGColor]);
	CGContextFillRect(currentContext, CGRectMake(0.0f, 0.0f, 300.0f, 80.0f));
	UIImage *yellowColorImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	// Support and feedback button
	UIButton *supportButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[supportButton setFrame:CGRectMake(10.0f, 10.0f, 300.0f, 80.0f)];
	[[supportButton layer] setCornerRadius:8.0f];
	[[supportButton layer] setMasksToBounds:YES];
	[[supportButton	layer] setBorderColor:[[UIColor darkGrayColor] CGColor]];
	[[supportButton layer] setBorderWidth:2.0f];
	[supportButton setBackgroundImage:yellowColorImage forState:UIControlStateNormal];
	[[supportButton titleLabel] setFont:[UIFont systemFontOfSize:24.0f]];
	[supportButton setTitle:NSLocalizedString(@"Support & Feedback", @"Support & Feedback") forState:UIControlStateNormal];
	[supportButton addTarget:self action:@selector(supportAndFeedback) forControlEvents:UIControlEventTouchUpInside];
	[[self view] addSubview:supportButton];
	// How to change the dealer title label
	UILabel *changeDealerTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 120.0f, 300.0f, 25.0f)];
	[changeDealerTitleLabel setBackgroundColor:[UIColor kAppYellowColor]];
	[changeDealerTitleLabel setLineBreakMode:UILineBreakModeWordWrap];
	[changeDealerTitleLabel setNumberOfLines:0];
	[changeDealerTitleLabel setFont:[UIFont systemFontOfSize:20.0f]];
	[changeDealerTitleLabel setTextColor:[UIColor colorWithRed:0.22 green:0.33 blue:0.53 alpha:1.0]];
	[changeDealerTitleLabel setText:NSLocalizedString(@"How to change the dealer", @"How to change the dealer")];
	[[self view] addSubview:changeDealerTitleLabel];
	[changeDealerTitleLabel release];
	// How to change the dealer description
	UILabel *changeDealerDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 150.0f, 300.0f, 50.0f)];
	[changeDealerDescriptionLabel setBackgroundColor:[UIColor kAppYellowColor]];
	[changeDealerDescriptionLabel setLineBreakMode:UILineBreakModeWordWrap];
	[changeDealerDescriptionLabel setNumberOfLines:0];
	[changeDealerDescriptionLabel setFont:[UIFont systemFontOfSize:14.0f]];
	[changeDealerDescriptionLabel setText:NSLocalizedString(@"To change the dealer, double tap on the player's figure.", @"To change the dealer, double tap on the player's figure.")];
	[[self view] addSubview:changeDealerDescriptionLabel];
	[changeDealerDescriptionLabel release];
	// How to change a player name title label
	UILabel *changePlayerNameTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 220.0f, 300.0f, 25.0f)];
	[changePlayerNameTitleLabel setBackgroundColor:[UIColor kAppYellowColor]];
	[changePlayerNameTitleLabel setLineBreakMode:UILineBreakModeWordWrap];
	[changePlayerNameTitleLabel setNumberOfLines:0];
	[changePlayerNameTitleLabel setFont:[UIFont systemFontOfSize:20.0f]];
	[changePlayerNameTitleLabel setTextColor:[UIColor colorWithRed:0.22 green:0.33 blue:0.53 alpha:1.0]];
	[changePlayerNameTitleLabel setText:NSLocalizedString(@"How to change a player name", @"How to change a player name")];
	[[self view] addSubview:changePlayerNameTitleLabel];
	[changePlayerNameTitleLabel release];
	// How to change a player name description
	UILabel *changePlayerNameDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 250.0f, 300.0f, 50.0f)];
	[changePlayerNameDescriptionLabel setBackgroundColor:[UIColor kAppYellowColor]];
	[changePlayerNameDescriptionLabel setLineBreakMode:UILineBreakModeWordWrap];
	[changePlayerNameDescriptionLabel setNumberOfLines:0];
	[changePlayerNameDescriptionLabel setFont:[UIFont systemFontOfSize:14.0f]];
	[changePlayerNameDescriptionLabel setText:NSLocalizedString(@"To change a player's name, single tap on the name.", @"To change a player's name, single tap on the name.")];
	[[self view] addSubview:changePlayerNameDescriptionLabel];
	[changePlayerNameDescriptionLabel release];
}

- (void)viewDidUnload 
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc 
{
    [super dealloc];
}

#pragma mark -
#pragma mark Other Methods

- (void)supportAndFeedback
{
	if ([MFMailComposeViewController canSendMail] == NO)
	{
		UIAlertView *noMailAlertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Error") message:NSLocalizedString(@"This device is not configured to send email", @"This device is not configured to send email") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[noMailAlertView show];
		[noMailAlertView release];
		return;
	}
	MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
	[mailComposer setMailComposeDelegate:self];
	[mailComposer setSubject:@"CardScore500 Support"];
	[mailComposer setToRecipients:[NSArray arrayWithObject:@"CardScore500@gmail.com"]];	// TODO: Change this to the actual support address
	[mailComposer setMessageBody:@"Hey Joe,\n\n" isHTML:NO];
	[self presentModalViewController:mailComposer animated:YES];
	[mailComposer release];
}

#pragma mark -
#pragma mark MFMailComposeViewControllerDelegate Methods

- (void)mailComposeController:(MFMailComposeViewController*)argController didFinishWithResult:(MFMailComposeResult)argResult error:(NSError*)argError
{
	[self dismissModalViewControllerAnimated:YES];
	if (argResult == MFMailComposeResultSent)
	{
		UIAlertView *thankYouAlertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Thank You!", @"Thank You!") message:NSLocalizedString(@"Thank you for your feedback, if you have a support issue we will be in touch", @"Thank you for your feedback, if you have a support issue, we will be in touch") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[thankYouAlertView show];
		[thankYouAlertView release];
	}
	else if (argResult == MFMailComposeResultFailed)
	{
		UIAlertView *failedMessageAlertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Error") message:NSLocalizedString(@"There was an error sending the message", @"There was an error sending the message") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[failedMessageAlertView show];
		[failedMessageAlertView release];
	}
}

@end
