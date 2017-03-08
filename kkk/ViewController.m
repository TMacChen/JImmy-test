//
//  ViewController.m
//  kkk
//
//  Created by Jimmy on 16/9/9.
//  Copyright © 2016年 Jimmy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    buttonContainerView = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 320, 0)];
    buttonContainerView.backgroundColor = [UIColor redColor];
    [self.view addSubview:buttonContainerView];
    NSArray *array = [NSArray arrayWithObjects:@"微微一笑很倾城",@"明朝那些事儿",@"第十三天",@"第十三天",@"明朝那些事儿",@"明朝那些事儿",@"微微一笑很倾城",@"明朝那些事儿",@"第十三天", nil];
    
    buttons = [NSMutableArray array];
    for (NSString *title in array) {
        UIButton *button = [self createButtonWithTitle:title];
        CGRect buttonFrame = button.frame;
        CGFloat buttonWidth = [self buttonWidthForButton:button];
        buttonFrame.size.width = buttonWidth;
        button.frame = buttonFrame;
        [buttons addObject:button];
    }
    
    [self addViews];
    
}

- (UIButton *)createButtonWithTitle:(NSString *)title {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
    button.backgroundColor =[UIColor greenColor];
    [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 5.0;
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

- (CGFloat)buttonWidthForButton:(UIButton *)button {
    CGFloat padding = 5.0;
    CGFloat labelWidth = [button.titleLabel sizeThatFits:CGSizeMake(buttonContainerView.frame.size.width, button.titleLabel.frame.size.height)].width;
    return (labelWidth+2*padding);
}

- (void)btnAction:(UIButton *)button {
    NSString *msg = [NSString stringWithFormat:@"你点击了<%@>",button.titleLabel.text];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Hello" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)addViews {
    CGFloat buttonMargin = 30.0;
    CGFloat buttonTotalMaxWidth = buttonContainerView.frame.size.width - 2*buttonMargin;
    CGFloat buttonVerticalPadding = 5.0;
    CGFloat buttonHorizonalPadding = 4.0;
    CGFloat buttonTopMargin = 4.0;
    CGFloat buttonBottomMargin = 15.0;
    
    NSInteger lines = 1;
    CGFloat currentButtonTotalWidth = 0.0;
    
    for (NSInteger i = 0; i < buttons.count; i ++) {
        UIButton *currentButton = [buttons objectAtIndex:i];
        CGRect currentButtonFrame = currentButton.frame;
        
        if (currentButtonTotalWidth == 0.0) {
            // a new row
            currentButtonFrame.origin.x = buttonMargin;
            currentButtonFrame.origin.y = buttonTopMargin + (currentButtonFrame.size.height+ buttonVerticalPadding) * (lines-1);
            currentButton.frame = currentButtonFrame;
            currentButtonTotalWidth += currentButtonFrame.size.width;
            // calculate whether next button can put in the same row
            if ((i+1) < buttons.count) {
                UIButton *nextButton = [buttons objectAtIndex:i+1];
                CGRect nextButtonFrame = nextButton.frame;
                CGFloat ifPutNextButtonWidth = currentButtonTotalWidth + (nextButtonFrame.size.width + buttonHorizonalPadding);
                if (ifPutNextButtonWidth > buttonTotalMaxWidth) {
                    // go to another row
                    currentButtonTotalWidth = 0.0;
                    lines += 1;
                }
            }
        }else{
            // not a new row
            currentButtonFrame.origin.x = buttonMargin + currentButtonTotalWidth + buttonHorizonalPadding;
            currentButtonFrame.origin.y = buttonTopMargin + (currentButtonFrame.size.height + buttonVerticalPadding) * (lines-1);
            currentButton.frame = currentButtonFrame;
            currentButtonTotalWidth += (currentButtonFrame.size.width + buttonHorizonalPadding);
            // calculate whether next button can put in the same row
            if ((i+1) < buttons.count) {
                UIButton *nextButton = [buttons objectAtIndex:i+1];
                CGRect nextButtonFrame = nextButton.frame;
                CGFloat ifPutNextButtonWidth = currentButtonTotalWidth + (nextButtonFrame.size.width + buttonHorizonalPadding);
                if (ifPutNextButtonWidth > buttonTotalMaxWidth) {
                    // go to another row
                    currentButtonTotalWidth = 0.0;
                    lines += 1;
                }
            }
        }
    }
    CGRect containFrame = buttonContainerView.frame;
    UIButton *theButton = [buttons objectAtIndex:0];
    containFrame.size.height = buttonTopMargin + buttonBottomMargin + lines * theButton.frame.size.height  + (lines-1) * buttonVerticalPadding;
    buttonContainerView.frame = containFrame;
    
    for (UIButton *button in buttons) {
        [buttonContainerView addSubview:button];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
