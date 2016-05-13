//
//  ViewController.m
//  KeyBoardDemo
//
//  Created by lee on 16/5/13.
//  Copyright © 2016年 lee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>
{
    UITextField *_textField;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(100, 600, 200, 50)];
    _textField.placeholder = @"3333";
    _textField.backgroundColor = [UIColor redColor];
    _textField.delegate = self;
    [self.view addSubview:_textField];
    
    //    如果你的输入框被键盘被挡住了，就将整个self.view上移
    //    输入完成再回到原始位置
    //    监听键盘事件
    //    UIKeyboardWillShowNotification 键盘将要出现
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardwillshow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardwillhide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardwillshow:(NSNotification *)noti
{
    //    获取键盘位置，判断是否遮挡输入框
    //    获取信息
    NSDictionary *dic = noti.userInfo;
    NSLog(@"%@",dic);
    //    获取到键盘的高度和输入框高度做对比
    NSValue *value = dic[@"UIKeyboardFrameEndUserInfoKey"];
    
    //    转化为frame
    CGRect keyboardFrame = value.CGRectValue;
    //    计数是否遮挡
    NSInteger offset = (_textField.frame.size.height+_textField.frame.origin.y) - keyboardFrame.origin.y;
    NSLog(@"%@",NSStringFromCGRect(_textField.frame));
    NSLog(@"%@",NSStringFromCGRect(keyboardFrame));
    if (offset > 0) {
        self.view.frame = CGRectMake(0, -offset, self.view.frame.size.width, self.view.frame.size.height);
    }
}

- (void)keyboardwillhide:(NSNotification *)noti
{
    self.view.frame = self.view.bounds;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
