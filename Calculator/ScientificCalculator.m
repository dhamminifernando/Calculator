//
//  ScientificCalculator.m
//  Calculator
//
//  Created by Dhammini Fernando on 10/25/16.
//  Copyright © 2016 Dhammini Fernando. All rights reserved.
//

#import "ScientificCalculator.h"

@implementation ScientificCalculator

/**
 Specification Extracted -
 it( "returns the sine of PI / 2", function(){
 expect( calculator.sin( Math.PI / 2 ) ).to.equal( 1 );
 } );
 **/
-(NSString *) calculateSin: (NSString *) value{
    NSString *result;
    float resultValue = sinf([value floatValue]);
    result = [NSString stringWithFormat:@"%10.5f", resultValue];
    return result;
}

/**
 Specification Extracted -
 it( "returns the cosine of PI", function(){
 expect( calculator.cos( Math.PI ) ).to.equal( -1 );
 } );
 **/
-(NSString *) calculateCos: (NSString *) value{
    NSString *result;
    float resultValue = cosf([value floatValue]);
    result = [NSString stringWithFormat:@"%10.5f", resultValue];
    return result;
}

/**
 Specification Extracted -
 it( "returns the tangent of 0", function(){
 expect( calculator.tan( 0 ) ).to.equal( 0 );
 } );
 **/
-(NSString *) calculateTan: (NSString *) value{
    NSString *result;
    float resultValue = tanf([value floatValue]);
    result = [NSString stringWithFormat:@"%10.5f", resultValue];
    return result;
}

/**
 Specification Extracted -
 it( "returns the logarithm of 1", function(){
 expect( calculator.log( 1 ) ).to.equal( 0 );
 } );
 **/
-(NSString *) calculateLog: (NSString *) value{
    NSString *result;
    float resultValue = logf([value floatValue]);
    result = [NSString stringWithFormat:@"%10.5f", resultValue];
    return result;
}

@end
