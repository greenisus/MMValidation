//
//  Address.h
//
//  Created by Michael Mayo on 12/16/09.
//

#import "NSObject+MMValidation.h"


@interface Address : NSObject {
	NSString *city;
	NSString *state;
}

@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *state;

@end
