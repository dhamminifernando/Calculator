//
//  ScientificCalculator.h
//  Calculator
//
//  Created by Dhammini Fernando on 10/25/16.
//  Copyright © 2016 Dhammini Fernando. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calculator.h"

@interface ScientificCalculator : Calculator

-(NSString *) calculateSin: (NSString *) value;
-(NSString *) calculateCos: (NSString *) value;
-(NSString *) calculateTan: (NSString *) value;
-(NSString *) calculateLog: (NSString *) value;

@end
