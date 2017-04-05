//
//  Test2.m
//  PopUpView
//
//KeyboardAvoiding
#import "Test2.h"
#import "KeyboardAvoiding.h"

@interface Test2 ()

@end

@implementation Test2

- (void)viewDidLoad {
    [super viewDidLoad];
    
   [KeyboardAvoiding adjustKeyboardForScrollView:self.scrollVieww andView:self];

}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
        [KeyboardAvoiding adjustKeyboardForScrollView:self.scrollVieww andView:self];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
      [KeyboardAvoiding adjustKeyboardForScrollView:self.scrollVieww andView:self];
}
@end
