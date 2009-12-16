//
//  MMValidation.m
//
//  Created by Michael Mayo on 12/16/09.
//

#import "MMValidation.h"
#import "MMValidationError.h"
#import "NSObject+MMValidation.h"

@implementation MMValidation

@synthesize type, klass, member, message;
@synthesize confirmationMember, values;

#pragma mark -
#pragma mark Validations

-(BOOL)validatePresenceOf:(NSObject *)object error:(MMValidationError **)error selector:(SEL)selector {
	BOOL valid = YES;
	if ([[object class] instancesRespondToSelector:selector]) {
		id value = [object performSelector:selector];		
		if (value) {
			if ([value class] == [NSString class]) {
				valid = ![value isEqualToString:@""];
			}
		} else {
			valid = NO;
		}
	}
	return valid;	
}

-(BOOL)validateAssociated:(NSObject *)object error:(MMValidationError **)error selector:(SEL)selector {
	BOOL valid = YES;
	if ([[object class] instancesRespondToSelector:selector]) {
		id value = [object performSelector:selector];
		if (value) {
			valid = [value valid];
		}
	}
	return valid;	
}

-(BOOL)validateConfirmation:(NSObject *)object error:(MMValidationError **)error selector:(SEL)selector confirmationSelector:(SEL)confirmationSelector {
	BOOL valid = YES;
	if ([[object class] instancesRespondToSelector:selector] && [[object class] instancesRespondToSelector:confirmationSelector]) {
		id value = [object performSelector:selector];
		id confirmation = [object performSelector:confirmationSelector];
		
		if (value && confirmation) {
			valid = [value isEqualToString:confirmation];
		} else {
			// if they're both nil, they are the same
			valid = !value && !confirmation;
		}		
	}
	return valid;	
}

-(BOOL)validateExclusion:(NSObject *)object error:(MMValidationError **)error selector:(SEL)selector values:(NSArray *)excludedValues {
	BOOL valid = YES;
	if ([[object class] instancesRespondToSelector:selector]) {
		id value = [object performSelector:selector];				
		if (value) {
			for (int i = 0; i < [excludedValues count]; i++) {
				id excludedValue = [excludedValues objectAtIndex:i];
				if ([value isEqual:excludedValue]) {
					valid = NO;
					break;
				}
			}
		}		
	}
	return valid;	
}

-(BOOL)validateInclusion:(NSObject *)object error:(MMValidationError **)error selector:(SEL)selector values:(NSArray *)includedValues {
	BOOL valid = NO;
	if ([[object class] instancesRespondToSelector:selector]) {
		id value = [object performSelector:selector];				
		if (value) {
			for (int i = 0; i < [includedValues count]; i++) {
				id includedValue = [includedValues objectAtIndex:i];
				if ([value isEqual:includedValue]) {
					valid = YES;
					break;
				}
			}
		}		
	}
	return valid;	
}

#pragma mark -
#pragma mark Validate

-(BOOL)validate:(NSObject *)object error:(MMValidationError **)error {
	BOOL valid = YES;
	SEL selector = NSSelectorFromString(self.member);
	SEL confirmationSelector = nil;
	if (self.confirmationMember) {
		confirmationSelector = NSSelectorFromString(self.confirmationMember);
	}
	
	switch (self.type) {
		case kPresenceOf:
			valid = [self validatePresenceOf:object error:error selector:selector]; break;
		case kAssociated:
			valid = [self validateAssociated:object error:error selector:selector]; break;
		case kConfirmationOf:
			valid = [self validateConfirmation:object error:error selector:selector confirmationSelector:confirmationSelector]; break;
		case kExclusionOf:
			valid = [self validateExclusion:object error:error selector:selector values:self.values]; break;
		case kInclusionOf:
			valid = [self validateInclusion:object error:error selector:selector values:self.values]; break;
		default:
			break;
	}
	
	if (!valid) {
		if (*error == nil) {
			*error = [[MMValidationError alloc] initWithValidation:self];
		}
	}
	
	return valid;
}

#pragma mark -
#pragma mark Memory Management

-(void)dealloc {
	[member release];
	[message release];
	[confirmationMember release];
	[values release];
	[super dealloc];
}

@end
