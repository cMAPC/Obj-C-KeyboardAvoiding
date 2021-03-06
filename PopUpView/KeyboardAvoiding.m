//
//  KeyboardController.m
//  PopUpView
//

#import "KeyboardAvoiding.h"

#pragma mark - Global's
UIViewController* destinationViewController;
UIScrollView* destinationScrollView;
UITapGestureRecognizer *tapGesture;
BOOL isViewController;
NSInteger tagCount;

CGFloat yPositionOffset = 0;
__strong KeyboardAvoiding* obj;

@implementation KeyboardAvoiding

+(void)observeKeyboardEvents {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

+(void)dismissKeyboard
{
    if (isViewController) {
        for (UIView* view in destinationViewController.view.subviews) {
            if ([view isKindOfClass:[UITextField class]])
                [view resignFirstResponder];
        }
    }
    else
    {
        for (UIView* view in destinationScrollView.subviews) {
            if ([view isKindOfClass:[UITextField class]])
                [view resignFirstResponder];
        }
    }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

+(void)setTextFieldsTag {
    if (isViewController) {
//        for (UIView* view in destinationViewController.view.subviews) {
//            if ([view isKindOfClass:[UITextField class]]) {
//                [(UITextField*)view setDelegate:obj];
//                [(UITextField*)view setReturnKeyType:UIReturnKeyNext];
//                
//                view.tag = tagCount;
//                tagCount++;
//            }
//            
//            if ([view isKindOfClass:[UIView class]]) {
//                for (UIView* view1 in view.subviews) {
////                    [(UITextField*)view1 setDelegate:obj];
////                    [(UITextField*)view1 setReturnKeyType:UIReturnKeyNext];
////                    
////                    view1.tag = tagCount;
////                    tagCount++;
//                }
//                
//            }
//            
//        }
//        
//        [(UITextField *)[destinationViewController.view.subviews objectAtIndex:tagCount - 1] setReturnKeyType:UIReturnKeyDone];
        
       /* for (int i = 0; i < destinationViewController.view.subviews.count; i++) {
            if ([destinationViewController.view.subviews[i] isKindOfClass:[UITextField class]]) {
                [(UITextField *)destinationViewController.view.subviews[i] setDelegate:obj];
                
//                [(UITextField*)view setDelegate:obj];
//                [(UITextField*)view setReturnKeyType:UIReturnKeyNext];
//                
                destinationViewController.view.subviews[i].tag = tagCount;
                tagCount++;
            }
            
            if ([destinationViewController.view.subviews[i] isKindOfClass:[UIView class]]) {
                for (int j=0; j<destinationViewController.view.subviews[i].subviews.count; j++) {
                    if ([destinationViewController.view.subviews[i].subviews[j] isKindOfClass:[UITextField class]]) {
                        [(UITextField *)destinationViewController.view.subviews[i].subviews[j] setDelegate:obj];
                        destinationViewController.view.subviews[i].subviews[j].tag = tagCount;
                        tagCount++;
                    }
                }
            }
        } */
        
        for (UIView* view in destinationViewController.view.subviews) {
            if ([view isKindOfClass:[UITextField class]]) {
                [(UITextField *)view setDelegate:obj];
                [(UITextField *)view setReturnKeyType:UIReturnKeyNext];
                
                view.tag = tagCount;
                tagCount ++;
                
            }
            
            if ([view isKindOfClass:[UIView class]]) {
                for (UIView *view1 in view.subviews) {
                    if ([view1 isKindOfClass:[UITextField class]]) {
                        [(UITextField *)view1 setDelegate:obj];
                        [(UITextField *)view1 setReturnKeyType:UIReturnKeyNext];
                        
                        view1.tag = tagCount;
                        tagCount ++;
                    }

                }
            }
        }
        
        [(UITextField *)[destinationViewController.view.subviews objectAtIndex:tagCount - 2] setReturnKeyType:UIReturnKeyDone];
    
    }
    else
    {
//        for (UIView* view in destinationScrollView.subviews) {
//            if ([view isKindOfClass:[UITextField class]] == TRUE) {
//                view.tag = tagCount;
//                tagCount+=1;
//                ((UITextField*)view).delegate = obj;
////                [(UITextField*)view setDelegate:(id<UITextFieldDelegate>)obj];
//            }
//        }
    }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

+(void)adjustKeyboardForView:(UIViewController *) viewController{
    obj = [[KeyboardAvoiding alloc] init];
    destinationViewController = viewController;
    isViewController = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [destinationViewController.view addGestureRecognizer:tapGesture];
    
    [self observeKeyboardEvents];
    [self setTextFieldsTag];
}

+(void)adjustKeyboardForScrollView:(UIScrollView *) scrollView andView:(UIViewController *) viewController {
    obj = [[KeyboardAvoiding alloc] init];
    destinationScrollView = scrollView;
    destinationViewController = viewController;
    isViewController = NO;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [destinationScrollView addGestureRecognizer:tapGesture];
    
    [self observeKeyboardEvents];
    [self setTextFieldsTag];
}



+(void)keyboardWillShow:(NSNotification *) notification {
    
    if (isViewController) {
//        for (UIView* view in destinationViewController.view.subviews) {
//            [self adjustViewForKeyboardNotification:notification target:view offset:8.0f];
//        }
        /////////////////////////////////////////////////////////////// sus e originalu
        for (UIView* view in destinationViewController.view.subviews) {
            if ([view isKindOfClass:[UITextField class]] && [view isFirstResponder]) {
                [self adjustViewForKeyboardNotification:notification target:view offset:8.0f];
                
            }
            
            if ([view isKindOfClass:[UIView class]]) {
                for (UIView *view1 in view.subviews) {
                    if ([view1 isKindOfClass:[UITextField class]] && [view1 isFirstResponder]) {
                        CGPoint point = [view1.superview convertPoint:view1.frame.origin toView:destinationViewController.view];
                        UIView* temp = [[UIView alloc] initWithFrame:CGRectMake(point.x, point.y, view1.frame.size.width, view1.frame.size.height)];
                        
                        [self adjustViewForKeyboardNotification:notification target:temp offset:8.0f];
                        
                    }
                    
                }
            }
        }

        ///////////////////////////////////////////////////////////////
    }
    else
    {
//        for (UIView* view in destinationScrollView.subviews) {
//            if (view.isFirstResponder)
//                [self adjustViewForKeyboardNotification:notification target:view offset:8.0f];
//        }
        ////////////////////////////////////////////////////////////////////////////
        
        for (UIView* view in destinationViewController.view.subviews) {
            if ([view isKindOfClass:[UITextField class]] && [view isFirstResponder]) {
                [self adjustViewForKeyboardNotification:notification target:view offset:8.0f];
                
            }
            
            if ([view isKindOfClass:[UIView class]]) {
                for (UIView *view1 in view.subviews) {
                    if ([view1 isKindOfClass:[UITextField class]] && [view1 isFirstResponder]) {
                        CGPoint point = [view1.superview convertPoint:view1.frame.origin toView:destinationViewController.view];
                        UIView* temp = [[UIView alloc] initWithFrame:CGRectMake(point.x, point.y, view1.frame.size.width, view1.frame.size.height)];
                        
                        [self adjustViewForKeyboardNotification:notification target:temp offset:8.0f];
                        
                    }
                    
                }
            }
        }
        
        ////////////////////////////////////////////////////////////////////////////
    }
    
}


+(void)keyboardWillHide:(NSNotification *) notification {
    [self adjustViewForKeyboardNotification:notification target:nil offset:0];
}


+(void)adjustViewForKeyboardNotification:(NSNotification *)notification target:(UIView *)target offset:(CGFloat)offset
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    if (isViewController) {
        if ([notification.name isEqual:UIKeyboardWillShowNotification]) {
            
            CGFloat screenOverlap = destinationViewController.view.frame.size.height - keyboardSize.height;
            
            if (target.frame.origin.y + target.frame.size.height > screenOverlap) {
                if (  target.frame.origin.y + target.frame.size.height + yPositionOffset > screenOverlap)
                    yPositionOffset = screenOverlap - target.frame.origin.y - target.frame.size.height - offset;
                NSLog(@"%@", NSStringFromCGPoint(target.frame.origin));
                NSLog(@"%f", yPositionOffset);
            }
        }
        else {
            yPositionOffset = 0;
        }

        // slide the view up/down to coincide with the keyboard slide
                [UIView animateWithDuration:0.2f animations:^{
                    CGRect frame = destinationViewController.view.frame;
                    frame.origin.y = yPositionOffset;
                    destinationViewController.view.frame = frame;
                }];

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//        CGPoint point = [target.superview convertPoint:target.frame.origin toView:destinationViewController.view];
//        
//        CGRect aRect = destinationViewController.view.frame;
//        aRect.size.height -= keyboardSize.height;
//        if (target.isFirstResponder && !CGRectContainsPoint(aRect, target.frame.origin) ) {
//           CGPoint scrollPoint = CGPointMake(0.0, target.frame.origin.y-keyboardSize.height);
////            NSLog(@"%@", NSStringFromCGPoint(target.frame.origin));
//            NSLog(@"point %@", NSStringFromCGPoint(point));
//            NSLog(@"este");
//        }
//        
//        // slide the view up/down to coincide with the keyboard slide
//        [UIView animateWithDuration:0.2f animations:^{
//            CGRect frame = destinationViewController.view.frame;
//            frame.origin.y = yPositionOffset;
//            destinationViewController.view.frame = frame;
//        }];
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    }
    else
    {
        if ([notification.name isEqual:UIKeyboardWillShowNotification]) {
            // scroll view above keyboard
            UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
            destinationScrollView.contentInset = contentInsets;
            destinationScrollView.scrollIndicatorInsets = contentInsets;
            
            // If active text field is hidden by keyboard, scroll it so it's visible
            CGRect aRect = destinationViewController.view.frame;
            aRect.size.height -= keyboardSize.height;
            if (!CGRectContainsPoint(aRect, target.frame.origin) ) {
                CGPoint scrollPoint = CGPointMake(0.0, target.frame.origin.y-keyboardSize.height);
                [destinationScrollView setContentOffset:scrollPoint animated:NO];
            }
//            
//                CGRect aRect = destinationScrollViewController.view.frame;
//                aRect.size.height -= keyboardSize.height;
//                if (!CGRectContainsPoint(aRect, target.frame.origin) ) {
//                    CGPoint scrollPoint = CGPointMake(0.0, target.frame.origin.y-keyboardSize.height);
//                    if (target.frame.origin.y > tempY) {
//                        [destinationScrollView setContentOffset:scrollPoint animated:NO];
//                        tempY = target.frame.origin.y;
//                    }
//                }
            
        } else {
            
            UIEdgeInsets contentInsets = UIEdgeInsetsZero;
            destinationScrollView.contentInset = contentInsets;
            destinationScrollView.scrollIndicatorInsets = contentInsets;
        }
    }
    
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"Delegate");
    NSInteger nextTag = textField.tag + 1;
    UIResponder* nextResponder = [textField.superview.superview viewWithTag:nextTag];
    
    if (nextResponder) {
        [nextResponder becomeFirstResponder];
    }
    else
    {
        [nextResponder resignFirstResponder];
        [textField resignFirstResponder];
        return YES;
    }
    
    return NO;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"%ld", (long)textField.tag);

}

@end
