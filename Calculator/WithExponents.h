//
//  WithExponents.h
//  Calculator
//
//  Created by Dhammini Fernando on 10/25/16.
//  Copyright © 2016 Dhammini Fernando. All rights reserved.
//

@protocol WithExponents <NSObject>

-(NSString *) calculatePowForValueOne: (NSString *) valueOne toThePower: (NSString *) valueTwo;
-(NSString *) multiplyExpForValueSetOne: (NSArray *) valueSetOne withValueSetTwo: (NSArray *) valueSetTwo;
-(NSString *) divideExpForValueSetOne: (NSArray *) valueSetOne withValueSetTwo: (NSArray *) valueSetTwo;

@end