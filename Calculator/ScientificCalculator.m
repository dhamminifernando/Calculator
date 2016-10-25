//
//  ScientificCalculator.m
//  Calculator
//
//  Created by Dhammini Fernando on 10/25/16.
//  Copyright © 2016 Dhammini Fernando. All rights reserved.
//

#import "ScientificCalculator.h"

@implementation ScientificCalculator

-(NSString *) calculateSin: (NSString *) value{
    NSString *result;
    float resultValue = sinf([value floatValue]);
    result = [NSString stringWithFormat:@"%10.5f", resultValue];
    return result;
}
-(NSString *) calculateCos: (NSString *) value{
    NSString *result;
    float resultValue = cosf([value floatValue]);
    result = [NSString stringWithFormat:@"%10.5f", resultValue];
    return result;
}
-(NSString *) calculateTan: (NSString *) value{
    NSString *result;
    float resultValue = tanf([value floatValue]);
    result = [NSString stringWithFormat:@"%10.5f", resultValue];
    return result;
}
-(NSString *) calculateLog: (NSString *) value{
    NSString *result;
    float resultValue = logf([value floatValue]);
    result = [NSString stringWithFormat:@"%10.5f", resultValue];
    return result;
}

@end
