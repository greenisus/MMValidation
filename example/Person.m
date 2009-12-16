//
//  Person.m
//
//  Created by Michael Mayo on 12/16/09.
//

#import "Person.h"


@implementation Person

@synthesize firstName, lastName, password, passwordConfirmation, favoriteColor, address;

+(void)initialize {
	[Person validatesPresenceOf:@"firstName"];
	[Person validatesPresenceOf:@"lastName"];
	[Person validatesConfirmationOf:@"password" withConfirmation:@"passwordConfirmation"];
	[Person validatesAssociated:@"address"];
	[Person validatesInclusionOf:@"favoriteColor" inValues:[NSArray arrayWithObjects:@"red", @"green", @"blue", nil]];	
	[Person validatesExclusionOf:@"favoriteColor" inValues:[NSArray arrayWithObjects:@"cyan", @"magenta", @"yellow", @"black", nil]];
}

-(void)dealloc {
	[firstName release];
	[lastName release];
	[password release];
	[passwordConfirmation release];
	[favoriteColor release];
	[address release];
	[super dealloc];
}

@end
