//
//  Calculator.m
//  Calculator
//
//  Created by Dhammini Fernando on 10/25/16.
//  Copyright © 2016 Dhammini Fernando. All rights reserved.
//

#import "Calculator.h"

@implementation Calculator

#pragma mark - enum accessors

+ (NSArray *) arithmeticOptionsArray;
{
    static NSArray *options;
    if (options == nil) {
        options = [[NSArray alloc] initWithObjects:kArithmeticOptionsArray];
    }
    return options;
}

-(NSString*) arithmeticOptionTypeEnumToString:(ArithmeticOptionType)enumVal
{
    NSArray *imageTypeArray = [[NSArray alloc] initWithObjects:kArithmeticOptionsArray];
    return [imageTypeArray objectAtIndex:enumVal];
}

// A method to retrieve the int value from the NSArray of NSStrings
-(ArithmeticOptionType) arithmeticOptionTypeStringToEnum:(NSString*)strVal
{
    NSArray *imageTypeArray = [[NSArray alloc] initWithObjects:kArithmeticOptionsArray];
    NSUInteger n = [imageTypeArray indexOfObject:strVal];
    if(n < 1)
        n = ArithmeticOptionAdd;
    return (ArithmeticOptionType) n;
}

/**
 Specification Extracted -
 it( "adds 1 and 2", function(){
 expect( calculator.add( 1, 2 ) ).to.equal( 3 );
 } );
 **/
-(NSString *) addValueOne: (NSString *) valueOne toValueTwo: (NSString *) valueTwo{
    NSString *result;
    float resultValue = [valueOne floatValue] + [valueTwo floatValue];
    result = [NSString stringWithFormat:@"%.1f", resultValue];
    return result;
}

/**
 Specification Extracted -
 it( "subtracts 2 from 9", function(){
 expect( calculator.subtract( 9, 2 ) ).to.equal( 7 );
 } );
 **/
-(NSString *) subtractValueOne: (NSString *) valueOne fromValueTwo: (NSString *) valueTwo{
    NSString *result;
    float resultValue = [valueOne floatValue] - [valueTwo floatValue];
    result = [NSString stringWithFormat:@"%.1f", resultValue];
    return result;
}

/**
 Specification Extracted -
 it( "multiplies 4 and 3", function(){
 expect( calculator.multiply( 4, 3 ) ).to.equal( 12 );
 } );
 **/
-(NSString *) multiplyValueOne: (NSString *) valueOne withValueTwo: (NSString *) valueTwo{
    NSString *result;
    float resultValue = [valueOne floatValue] * [valueTwo floatValue];
    result = [NSString stringWithFormat:@"%.1f", resultValue];
    return result;
}

/**
 Specification Extracted -
 it( "divides 10 by 2", function(){
 expect( calculator.divide( 10, 2 ) ).to.equal( 5 );
 } );
 **/
-(NSString *) divideValueOne: (NSString *) valueOne fromValueTwo: (NSString *) valueTwo{
    NSString *result;
    float resultValue = [valueOne floatValue] / [valueTwo floatValue];
    result = [NSString stringWithFormat:@"%.1f", resultValue];
    return result;
}

/**
 Specification Extracted -
 it( "returns 2^3", function(){
 expect( calculator.pow( 2, 3 ) ).to.equal( 8 );
 } );
 **/
-(NSString *) calculatePowForValueOne: (NSString *) valueOne toThePower: (NSString *) valueTwo{
    NSString *result;
    float resultValue = powf([valueOne floatValue],[valueTwo floatValue]);
    result = [NSString stringWithFormat:@"%.1f", resultValue];
    return result;
}

/**
 Specification Extracted -
 it( "multiplies 2^3 and 2^4", function(){
 expect( calculator.multiplyExp( [ 2, 3 ], [ 2, 4 ] ) ).to.equal( 128 );
 } );
 **/
-(NSString *) multiplyExpForValueSetOne: (NSArray *) valueSetOne withValueSetTwo: (NSArray *) valueSetTwo{    NSString *result;
    
    NSString *resultOne = [self calculatePowForValueOne:valueSetOne[0] toThePower:valueSetOne[1]];
    NSString *resultTwo = [self calculatePowForValueOne:valueSetTwo[0] toThePower:valueSetTwo[1]];
    result = [self multiplyValueOne:resultOne withValueTwo:resultTwo];
    return result;
}

/**
 Specification Extracted -
 it( "divides 2^3 by 2^5", function(){
 expect( calculator.divideExp( [ 2, 3 ], [ 2, 5 ] ) ).to.equal( 0.25 );
 } );
 **/
-(NSString *) divideExpForValueSetOne: (NSArray *) valueSetOne withValueSetTwo: (NSArray *) valueSetTwo{
    NSString *result;
    NSString *resultOne = [self calculatePowForValueOne:valueSetOne[0] toThePower:valueSetOne[1]];
    NSString *resultTwo = [self calculatePowForValueOne:valueSetTwo[0] toThePower:valueSetTwo[1]];
    result = [self divideValueOne:resultOne fromValueTwo:resultTwo];
    return result;
}

/**
 Specification Extracted -
 it( "delays execution", function(){
 expect( delay( 1000, calculator, 'add', [ 10, 5 ] ) ).to.eventually.equal( 15 );
 expect( delay( 500, calculator, 'subtract', [ 9, 5 ] ) ).to.eventually.equal( 4 );
 } );
 it( "cannot execute functions that do not exist", function(){
 expect( delay( 1000, calculator, 'sqrt', [ 2, 2 ] ) ).to.be.rejected;
 } ); } );
 } );
 **/
-(void) performWithDelay: (int) seconds arithmeticOperation: (ArithmeticOptionType) arithmeticOperation forValues: (NSArray *)valueSet withCompletionHandler:(void(^)(NSString *result)) completion{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, seconds * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        NSString *results=@"";
        NSString *valueOne = valueSet[0];
        NSString *valueTwo = valueSet[1];
        switch (arithmeticOperation) {
            case ArithmeticOptionAdd:
                results = [self addValueOne:valueOne toValueTwo:valueTwo];
                break;
            case ArithmeticOptionSubtract:
                results = [self subtractValueOne:valueOne fromValueTwo:valueTwo];
                break;
            case ArithmeticOptionMultiply:
                results = [self multiplyValueOne:valueOne withValueTwo:valueTwo];
                break;
            case ArithmeticOptionDivide:
                results = [self divideValueOne:valueOne fromValueTwo:valueTwo];
                break;
            case ArithmeticOptionPow:
                results = [self calculatePowForValueOne:valueOne toThePower:valueTwo];
                break;
            default:
                results = @"Rijected";
                break;
        }
        
        completion(results);
    });
}

@end
