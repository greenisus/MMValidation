//
//  MMValidationError.m
//
//  Created by Michael Mayo on 12/16/09.
//

#import "MMValidationError.h"
#import "MMValidation.h"

@implementation MMValidationError

@synthesize member, message;

-(id)initWithValidation:(MMValidation *)validation {
	if (self = [super init]) {
		self.member = validation.member;
		self.message = validation.message;
	}
	return self;
}

-(void)dealloc {
	[member release];
	[message release];
	[super dealloc];
}

@end
