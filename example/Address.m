//
//  Address.m
//
//  Created by Michael Mayo on 12/16/09.
//

#import "Address.h"


@implementation Address

@synthesize city, state;

+(void)initialize {
	[Address validatesPresenceOf:@"city"];
	[Address validatesPresenceOf:@"state"];
}

-(void)dealloc {
	[city release];
	[state release];
	[super dealloc];
}

@end
