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

-(NSString *) addValueOne: (NSString *) valueOne toValueTwo: (NSString *) valueTwo{
    NSString *result;
    float resultValue = [valueOne floatValue] + [valueTwo floatValue];
    result = [NSString stringWithFormat:@"%.1f", resultValue];
    return result;
}
-(NSString *) subtractValueOne: (NSString *) valueOne fromValueTwo: (NSString *) valueTwo{
    NSString *result;
    float resultValue = [valueOne floatValue] - [valueTwo floatValue];
    result = [NSString stringWithFormat:@"%.1f", resultValue];
    return result;
}
-(NSString *) multiplyValueOne: (NSString *) valueOne withValueTwo: (NSString *) valueTwo{
    NSString *result;
    float resultValue = [valueOne floatValue] * [valueTwo floatValue];
    result = [NSString stringWithFormat:@"%.1f", resultValue];
    return result;
}
-(NSString *) divideValueOne: (NSString *) valueOne fromValueTwo: (NSString *) valueTwo{
    NSString *result;
    float resultValue = [valueOne floatValue] / [valueTwo floatValue];
    result = [NSString stringWithFormat:@"%.1f", resultValue];
    return result;
}
-(NSString *) calculatePowForValueOne: (NSString *) valueOne toThePower: (NSString *) valueTwo{
    NSString *result;
    float resultValue = powf([valueOne floatValue],[valueTwo floatValue]);
    result = [NSString stringWithFormat:@"%.1f", resultValue];
    return result;
}

-(NSString *) multiplyExpForValueSetOne: (NSArray *) valueSetOne withValueSetTwo: (NSArray *) valueSetTwo{    NSString *result;
    
    NSString *resultOne = [self calculatePowForValueOne:valueSetOne[0] toThePower:valueSetOne[1]];
    NSString *resultTwo = [self calculatePowForValueOne:valueSetTwo[0] toThePower:valueSetTwo[1]];
    result = [self multiplyValueOne:resultOne withValueTwo:resultTwo];
    return result;
}

-(NSString *) divideExpForValueSetOne: (NSArray *) valueSetOne withValueSetTwo: (NSArray *) valueSetTwo{
    NSString *result;
    NSString *resultOne = [self calculatePowForValueOne:valueSetOne[0] toThePower:valueSetOne[1]];
    NSString *resultTwo = [self calculatePowForValueOne:valueSetTwo[0] toThePower:valueSetTwo[1]];
    result = [self divideValueOne:resultOne fromValueTwo:resultTwo];
    return result;
}

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
                break;
        }
        
        completion(results);
    });
}

@end
