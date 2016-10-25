//
//  Calculator.h
//  Calculator
//
//  Created by Dhammini Fernando on 10/25/16.
//  Copyright © 2016 Dhammini Fernando. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WithExponents.h"

typedef enum ArithmeticOptionType{
    ArithmeticOptionAdd,
    ArithmeticOptionSubtract,
    ArithmeticOptionMultiply,
    ArithmeticOptionDivide,
    ArithmeticOptionPow
    
}ArithmeticOptionType;

typedef enum AdvanceArithmeticOptionType{
    ArithmeticOptionNone,
    ArithmeticOptionMultiplyEx,
    ArithmeticOptionDivideEx,
}AdvanceArithmeticOptionType;

#define kArithmeticOptionsArray @"+", @"-", @"*", @"/", @"^", nil

@interface Calculator : NSObject <WithExponents>

+ (NSArray *) arithmeticOptionsArray;

-(NSString*) arithmeticOptionTypeEnumToString:(ArithmeticOptionType)enumVal;
-(ArithmeticOptionType) arithmeticOptionTypeStringToEnum:(NSString*)strVal;

-(NSString *) addValueOne: (NSString *) valueOne toValueTwo: (NSString *) valueTwo;
-(NSString *) subtractValueOne: (NSString *) valueOne fromValueTwo: (NSString *) valueTwo;
-(NSString *) multiplyValueOne: (NSString *) valueOne withValueTwo: (NSString *) valueTwo;
-(NSString *) divideValueOne: (NSString *) valueOne fromValueTwo: (NSString *) valueTwo;

-(void) performWithDelay: (int) seconds arithmeticOperation: (ArithmeticOptionType) arithmeticOperation forValues: (NSArray *)valueSet withCompletionHandler:(void(^)(NSString *result)) completion;

@end
