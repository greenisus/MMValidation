//
//  NSObject+MMValidation.m
//
//  Created by Michael Mayo on 12/16/09.
//  Copyright 2009 Michael Mayo. All rights reserved.
//

#import "NSObject+MMValidation.h"
#import "MMValidation.h"

@implementation NSObject(MMValidation)

NSMutableArray *validations = nil;

-(BOOL)valid {
	return [self valid:nil];
}

-(BOOL)valid:(NSMutableArray **)errors {
	
	BOOL valid = YES;
	
	for (int i = 0; i < [validations count]; i++) {
		MMValidation *validation = [validations objectAtIndex:i];
		MMValidationError *error = nil;
		
		if (validation.klass == [self class]) {		
			valid = [validation validate:self error:&error] && valid;
			
			if (!valid && errors) {
				if (*errors == nil) {
					*errors = [[NSMutableArray alloc] init];
				}
				if (error) {
					[*errors addObject:error];
				}
			}
		}
	}
	
	return valid;
}

+(void)initializeValidations {
	if (validations == nil) {
		validations = [[NSMutableArray alloc] init];
	}
}

+(void)addValidation:(NSInteger)type member:(NSString *)member message:(NSString *)message confirmationMember:(NSString *)confirmationMember values:(NSArray *)values {
	[[self class] initializeValidations];
	MMValidation *validation = [[MMValidation alloc] init];
	validation.type = type;
	validation.klass = [self class];
	validation.member = member;
	validation.message = message;
	validation.confirmationMember = confirmationMember;
	validation.values = values;
	[validations addObject:validation];	
}

+(void)addValidation:(NSInteger)type member:(NSString *)member message:(NSString *)message confirmationMember:(NSString *)confirmationMember {
	[[self class] addValidation:type member:member message:message confirmationMember:confirmationMember values:nil];
}

+(void)addValidation:(NSInteger)type member:(NSString *)member message:(NSString *)message values:(NSArray *)values {
	[[self class] addValidation:type member:member message:message confirmationMember:nil values:values];
}

+(void)addValidation:(NSInteger)type member:(NSString *)member message:(NSString *)message {
	[[self class] addValidation:type member:member message:message confirmationMember:nil values:nil];
}

#pragma mark -
#pragma mark Validations

+(void)validatesPresenceOf:(NSString *)member {
	[[self class] validatesPresenceOf:member message:@"can't be blank"];
}

+(void)validatesPresenceOf:(NSString *)member message:(NSString *)message {
	[[self class] addValidation:kPresenceOf member:member message:message];
}

+(void)validatesAssociated:(NSString *)member {
	[[self class] validatesAssociated:member message:@"is invalid"];
}

+(void)validatesAssociated:(NSString *)member message:(NSString *)message {
	[[self class] addValidation:kAssociated member:member message:message];
}

+(void)validatesConfirmationOf:(NSString *)member withConfirmation:(NSString *)confirmationMember {
	[[self class] validatesConfirmationOf:member withConfirmation:confirmationMember message:@"should match confirmation"];
}
+(void)validatesConfirmationOf:(NSString *)member withConfirmation:(NSString *)confirmationMember message:(NSString *)message {
	[[self class] addValidation:kConfirmationOf member:member message:message confirmationMember:confirmationMember];
}

+(void)validatesExclusionOf:(NSString *)member inValues:(NSArray *)values {
	[[self class] validatesExclusionOf:member inValues:values message:@"is reserved"];
}
+(void)validatesExclusionOf:(NSString *)member inValues:(NSArray *)values message:(NSString *)message {
	[[self class] addValidation:kExclusionOf member:member message:message values:values];
}

+(void)validatesInclusionOf:(NSString *)member inValues:(NSArray *)values {
	[[self class] validatesInclusionOf:member inValues:values message:@"is not included in the list"];
}
+(void)validatesInclusionOf:(NSString *)member inValues:(NSArray *)values message:(NSString *)message {
	[[self class] addValidation:kInclusionOf member:member message:message values:values];
}


@end
