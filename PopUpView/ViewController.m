//
//  ViewController.m
//  PopUpView
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>{
    CGFloat yPos;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
//    for (UIView* view in self.view.subviews) {
//        if ([view isKindOfClass:[UITextField class]]) {
//            [(UITextField*)view addObserver:self forKeyPath:@"text" options:0 context:nil];
//        }
//        
//    }
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(textDidChange:)
               name:UITextFieldTextDidBeginEditingNotification
             object:nil];
    
    [self.firstTextFiled addObserver:self forKeyPath:@"text" options:0 context:nil];

}

- (void)textDidChange:(NSNotification *)note
{
    NSLog(@"Observation...");
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"Value changed");
    NSLog(@"New value: %@ - Old value: %@",
          [change objectForKey:NSKeyValueChangeNewKey],
          [change objectForKey:NSKeyValueChangeOldKey]);
    
}



-(void)dismissKeyboard
{
    [self.firstTextFiled resignFirstResponder];
    [self.secondTextField resignFirstResponder];
    [self.thirdTextField resignFirstResponder];
}

-(void)keyboardWillShow:(NSNotification *) notification {

    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGFloat screenOverlap = self.view.frame.size.height - keyboardSize.height;
    NSLog(@"Keybbiard %f", screenOverlap);
    
    for (UIView* view in self.view.subviews) {
        if (view.isFirstResponder && view.frame.origin.y + view.frame.size.height+yPos > screenOverlap) {
            [self adjustScreenForKeyboard:notification target:view offset:8.0f];
            NSLog(@"dwad %f", view.frame.origin.y + view.frame.size.height-yPos);
        }
    }    
}

-(void)keyboardWillHide:(NSNotification *) notification {

    
    [self adjustScreenForKeyboard:notification target:nil offset:0];
}


- (void)adjustScreenForKeyboard:(NSNotification *)notification target:(UIView *)target offset:(CGFloat)offset
{
    yPos = 0;
    
    if (notification.name == UIKeyboardWillShowNotification) {
        CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        CGFloat screenOverlap = self.view.frame.size.height - keyboardSize.height;
        
        if (target.frame.origin.y + target.frame.size.height > screenOverlap) {
//            NSLog(@"Keybbiard %f", screenOverlap);
//            NSLog(@"%f", target.frame.origin.y + target.frame.size.height);
            yPos = screenOverlap - target.frame.origin.y - target.frame.size.height - offset;
            NSLog(@"ypos %f", yPos);
        }
    }
    
//    else if (notification.name == UIKeyboardWillHideNotification) {
//        yPos = 0;
//    }
    
//    CGFloat yPos = 0;
//    
//    if (notification.name == UIKeyboardWillShowNotification) {
//        // calculate how much we have to move the screen to bring the target into view
//        CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//        CGFloat screenOverlap = self.view.frame.size.height - keyboardSize.height;
//        CGFloat targetY = (target.frame.origin.y + target.frame.size.height + offset);
//        
//        // only set the offset if the target is actually hidden
//        yPos = targetY > screenOverlap ? screenOverlap - targetY : 0;
//    }
//    else if (notification.name == UIKeyboardWillHideNotification) {
//        // set back to original position
//        yPos = 0;
//    }
//    else {
//        // unknown notification type - do nothing
//        return;
//    }
//    
//    NSTimeInterval keyboardAnimationDuration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    
//    if (self.view.frame.origin.y == yPos) {
//        return;
//    }
//    
    // slide the view up/down to coincide with the keyboard slide
    [UIView animateWithDuration:0.2f animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = yPos;
        self.view.frame = frame;
    }];
    
}

@end
