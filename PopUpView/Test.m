//
//  Test.m
//  PopUpView
//
//  Created by Marcel  on 3/23/17.
//  Copyright © 2017 Marcel . All rights reserved.
//

#import "Test.h"
#import "KeyboardAvoiding.h"

@interface Test ()

@end

@implementation Test

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    KeyboardController* obj = [KeyboardController alloc];
//    KeyboardController* kc;
//    [obj setTextFieldsTag];
//    self.obj = [[KeyboardController alloc] init];
//    [self.obj setTextFieldsTag:self.textField_1];
//    self.textField_1.delegate = self.obj;
//    self.textField_2.delegate = self.obj;
    
    [KeyboardAvoiding adjustKeyboardForView:self];
//    [KeyboardController setTextFieldsTag:self.textField_1];
}



@end
