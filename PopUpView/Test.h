//
//  Test.h
//  PopUpView
//
//  Created by Marcel  on 3/23/17.
//  Copyright © 2017 Marcel . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardAvoiding.h"

@interface Test : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textField_1;
@property (weak, nonatomic) IBOutlet UITextField *textField_2;

@property (nonatomic, retain) KeyboardAvoiding* obj;
@end
