//
//  ViewController.h
//  Calculator
//
//  Created by Dhammini Fernando on 10/25/16.
//  Copyright © 2016 Dhammini Fernando. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController 

@property (weak, nonatomic) IBOutlet UITextField *txtResultPanel;
@property (weak, nonatomic) IBOutlet UITextField *txtValueOne;

@property (weak, nonatomic) IBOutlet UITextField *txtValueTwo;
@property (weak, nonatomic) IBOutlet UIPickerView *functionPicker;
@property (weak, nonatomic) IBOutlet UITextField *txtDelay;

- (IBAction)executeAdvanceOption:(id)sender;
- (IBAction)clearAll:(id)sender;

- (IBAction)perfomSelectedOperationWithDelay:(id)sender;


@end

