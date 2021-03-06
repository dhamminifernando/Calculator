//
//  ViewController.m
//  Calculator
//
//  Created by Dhammini Fernando on 10/25/16.
//  Copyright © 2016 Dhammini Fernando. All rights reserved.
//

#import "ViewController.h"
#import "ScientificCalculator.h"


@interface ViewController () <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic)NSArray *arithmeticFunctions;
@property (strong, nonatomic)ScientificCalculator *calculator;
@property (weak, nonatomic) UITextField *currentField;

@property (nonatomic) BOOL shouldWaitOnNextExpression;
@property (nonatomic) AdvanceArithmeticOptionType selectedAdvanceArithmeticOptionType;
@property (nonatomic) ArithmeticOptionType selectedArithmeticOptionType;
@property (strong, nonatomic) NSMutableArray *holdValues;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.arithmeticFunctions = [Calculator arithmeticOptionsArray];
    self.functionPicker.transform = CGAffineTransformMakeScale(0.5, 0.5);
    
    self.txtValueOne.delegate = self;
    self.txtValueTwo.delegate = self;
    self.shouldWaitOnNextExpression = NO;
    self.selectedAdvanceArithmeticOptionType = ArithmeticOptionNone;
    
    //Adding Pi to the keyboard
    [self addMathPitoKeyboardOfTextFieldOne];
    [self addMathPitoKeyboardOfTextFieldTwo];
    
    //Instantiating the array which holds value for advance operations - MultiplyEx and DivideEx
    self.holdValues = [[NSMutableArray alloc] init];
    
    self.calculator = [[ScientificCalculator alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark PickerView Delegates

- (NSInteger)numberOfComponentsInPickerView: (UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return  self.arithmeticFunctions.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.arithmeticFunctions[row];
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *resultString = self.arithmeticFunctions[row];
    NSInteger result = [self.calculator arithmeticOptionTypeStringToEnum:resultString];
    [self performCalculationForSelectedOperation:result];
    
}

#pragma mark - TextField Delegates

-(void) textFieldDidBeginEditing:(UITextField *)textField{
    self.currentField = textField;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)txtField{
    [self performTextFieldValidation:txtField];
    return true;
 }

-(void) performTextFieldValidation:(UITextField *)textField {
    if (textField == self.txtValueOne){
        self.txtResultPanel.text = self.txtValueOne.text;
        if ([self.txtValueTwo hasText]) {
            [self performCalculationForSelectedOperation:[self.functionPicker selectedRowInComponent:0]];
        }
    }else if (textField == self.txtValueTwo){
        self.txtResultPanel.text = self.txtValueTwo.text;
        if ([self.txtValueOne hasText]) {
            [self performCalculationForSelectedOperation:[self.functionPicker selectedRowInComponent:0]];
        }
    }
}
#pragma mark - Utilities

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    //Checking if another set of values to proceed with Advance Operations
    if (self.shouldWaitOnNextExpression && self.selectedAdvanceArithmeticOptionType == ArithmeticOptionMultiplyEx) {
        NSArray *valueSetOne = self.holdValues;
        NSArray *valueSetTwo = [NSArray arrayWithObjects:self.txtValueOne.text, self.txtValueTwo.text, nil];
        self.txtResultPanel.text = [self.calculator multiplyExpForValueSetOne:valueSetOne withValueSetTwo:valueSetTwo];
        
        self.shouldWaitOnNextExpression = NO;
        self.selectedAdvanceArithmeticOptionType = ArithmeticOptionNone;
    }else if (self.shouldWaitOnNextExpression && self.selectedAdvanceArithmeticOptionType == ArithmeticOptionDivideEx){
        NSArray *valueSetOne = self.holdValues;
        NSArray *valueSetTwo = [NSArray arrayWithObjects:self.txtValueOne.text, self.txtValueTwo.text, nil];
        self.txtResultPanel.text = [self.calculator divideExpForValueSetOne:valueSetOne withValueSetTwo:valueSetTwo];
        
        self.shouldWaitOnNextExpression = NO;
        self.selectedAdvanceArithmeticOptionType = ArithmeticOptionNone;
    }
}

//This function is to perform the operation selected through the picker view
-(void) performCalculationForSelectedOperation: (NSInteger) result{
    switch (result) {
        case ArithmeticOptionAdd:
            self.selectedArithmeticOptionType = ArithmeticOptionAdd;
            self.txtResultPanel.text = [self.calculator addValueOne:self.txtValueOne.text toValueTwo:self.txtValueTwo.text];
            break;
        case ArithmeticOptionSubtract:
            self.selectedArithmeticOptionType = ArithmeticOptionSubtract;
            self.txtResultPanel.text = [self.calculator subtractValueOne:self.txtValueOne.text fromValueTwo:self.txtValueTwo.text];
            break;
        case ArithmeticOptionMultiply:
            self.selectedArithmeticOptionType = ArithmeticOptionMultiply;
            self.txtResultPanel.text = [self.calculator multiplyValueOne:self.txtValueOne.text withValueTwo:self.txtValueTwo.text];
            break;
        case ArithmeticOptionDivide:
            self.selectedArithmeticOptionType = ArithmeticOptionDivide;
            self.txtResultPanel.text = [self.calculator divideValueOne:self.txtValueOne.text fromValueTwo:self.txtValueTwo.text];
            break;
        case ArithmeticOptionPow:
            self.selectedArithmeticOptionType = ArithmeticOptionPow;
            self.txtResultPanel.text = [self.calculator calculatePowForValueOne:self.txtValueOne.text toThePower:self.txtValueTwo.text];
            break;
        default:
            break;
    }
}

/**
 This function is to add Pi sign to txtValueOne
 Specification Extracted -
 it( "returns the sine of PI / 2", function(){
 expect( calculator.sin( Math.PI / 2 ) ).to.equal( 1 );
 } );
 **/
-(void) addMathPitoKeyboardOfTextFieldOne{
    UIToolbar *toolBar = [self getToolBar];
    
    toolBar.items =   @[ [[UIBarButtonItem alloc] initWithTitle:@"π"
                                                          style:UIBarButtonItemStyleDone target:self
                                                         action:@selector(mathPiSelectedForTextFieldOne)],
                         [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                       target:nil
                                                                       action:nil],
                         ];
    
    self.txtValueOne.inputAccessoryView = toolBar;
}

/**
 This function is to add Pi sign to txtValueTwo
 Specification Extracted -
 it( "returns the sine of PI / 2", function(){
 expect( calculator.sin( Math.PI / 2 ) ).to.equal( 1 );
 } );
 **/
-(void) addMathPitoKeyboardOfTextFieldTwo{
    UIToolbar *toolBar = [self getToolBar];
    
    toolBar.items =   @[ [[UIBarButtonItem alloc] initWithTitle:@"π"
                                                          style:UIBarButtonItemStyleDone target:self
                                                         action:@selector(mathPiSelectedForTextFieldTwo)],
                         [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                       target:nil
                                                                       action:nil],
                         ];
    
    self.txtValueTwo.inputAccessoryView = toolBar;
}

//This is to instantiate the toolbar for keyboard
-(UIToolbar *) getToolBar{
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f,
                                                                     0.0f,
                                                                     self.view.window.frame.size.width,
                                                                     44.0f)];
 
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        toolBar.tintColor = [UIColor colorWithRed:0.6f
                                            green:0.6f
                                             blue:0.64f
                                            alpha:1.0f];
    }
    else
    {
        toolBar.tintColor = [UIColor colorWithRed:0.56f
                                            green:0.59f
                                             blue:0.63f
                                            alpha:1.0f];
    }
    toolBar.translucent = NO;
    
    return toolBar;
}

//Callback function upon selecting Pi through txtValueOne
-(void) mathPiSelectedForTextFieldOne{
    self.txtValueOne.text = [NSString stringWithFormat:@"%.5f", M_PI];
}

//Callback function upon selecting Pi through txtValueOne
-(void) mathPiSelectedForTextFieldTwo{
    self.txtValueTwo.text = [NSString stringWithFormat:@"%.5f", M_PI];
}

//This is to perform the advance functionalities on button click - Sin, Cos, Tan, Log, MultiplyEx, DivideEx
- (IBAction)executeAdvanceOption:(id)sender {
    if (self.currentField)
        [self.currentField resignFirstResponder];
    
        NSInteger tag =  [(UIButton *)sender tag];
        switch (tag) {
            case 0:
                self.txtResultPanel.text = [self.calculator calculateSin:self.txtResultPanel.text] ;
                break;
                
            case 1:
                self.txtResultPanel.text = [self.calculator calculateCos:self.txtResultPanel.text];
                break;
            case 2:
                self.txtResultPanel.text = [self.calculator calculateTan:self.txtResultPanel.text];
                break;
                
            case 3:
                self.txtResultPanel.text = [self.calculator calculateLog:self.txtResultPanel.text];
                break;
            case 4:
                self.shouldWaitOnNextExpression = YES;
                self.selectedAdvanceArithmeticOptionType = ArithmeticOptionMultiplyEx;
                [self.holdValues addObject:self.txtValueOne.text];
                [self.holdValues addObject:self.txtValueTwo.text];
                self.txtValueOne.text = @"";
                self.txtValueTwo.text = @"";
                [self.txtValueOne becomeFirstResponder];
                break;
            case 5:
                self.shouldWaitOnNextExpression = YES;
                self.selectedAdvanceArithmeticOptionType = ArithmeticOptionDivideEx;
                [self.holdValues addObject:self.txtValueOne.text];
                [self.holdValues addObject:self.txtValueTwo.text];
                self.txtValueOne.text = @"";
                self.txtValueTwo.text = @"";
                [self.txtValueOne becomeFirstResponder];
                break;

            default:
                break;
        }
}

//Reset all inputs and variables
- (IBAction)clearAll:(id)sender {
    self.txtResultPanel.text = @"0.0";
    self.txtValueOne.text = @"";
    self.txtValueTwo.text = @"";
    self.txtDelay.text = @"";
    [self.holdValues removeAllObjects];
}

//Perfom selected operation with delay
- (IBAction)perfomSelectedOperationWithDelay:(id)sender {
    int seconds = [self.txtDelay.text intValue];
    [self.holdValues addObject:self.txtValueOne.text];
    self.txtResultPanel.text = @"";
    NSArray *valueSet = [NSArray arrayWithObjects:self.txtValueOne.text, self.txtValueTwo.text, nil];    [self.calculator performWithDelay:seconds arithmeticOperation:self.selectedArithmeticOptionType forValues:valueSet withCompletionHandler:^(NSString * results){
        if  ([results isEqualToString:@"Rijected"]){
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Operation Failed" message:@"Invalid Function Requested" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:ok];
            [self presentViewController:alertController animated:YES completion:nil];
        }else{
            self.txtResultPanel.text = results;
        }
    }];
}
@end
