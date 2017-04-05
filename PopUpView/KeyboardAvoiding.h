//
//  KeyboardController.h
//  PopUpView
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KeyboardAvoiding : NSObject <UITextFieldDelegate>

+(void)adjustKeyboardForView:(UIViewController *) viewController;
+(void)adjustKeyboardForScrollView:(UIScrollView *) scrollView andView:(UIViewController *) viewController;

@end
