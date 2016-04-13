//
//  InputView.m
//  WXPayView
//
//  Created by apple on 16/1/6.
//  Copyright © 2016年 apple. All rights reserved.
//  密码输入框视图

#import "PwdInputView.h"

// 中心符号圆点的大小
CGFloat const PWDInputViewSymbolWH = 8;

@interface PwdInputView ()

// 装着所有格子中间的那个占位圆点
@property(nonatomic, strong) NSMutableArray *symbolArr;

@end

@implementation PwdInputView

#pragma mark - 视图创建方法

// 代码创建输入框视图
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self == nil) {
        return nil;
    }

    [self addNotification];

    return self;
}

// xib加载输入框视图
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self == nil) {
        return nil;
    }

    [self addNotification];

    return self;
}

- (void)addNotification {
    // 回调键盘输入内容变化的通知
    [[NSNotificationCenter defaultCenter] addObserverForName:UITextFieldTextDidChangeNotification object:nil queue:nil usingBlock:^(NSNotification *note) {

        NSUInteger length = _textField.text.length;

        if (length == self.places && self.PWDInputViewDidCompletion) {
            self.PWDInputViewDidCompletion(_textField.text);
        }

        if (length > self.places) {
            _textField.text = [_textField.text substringToIndex:self.places];
        }

        [_symbolArr enumerateObjectsUsingBlock:^(CAShapeLayer *symbol, NSUInteger idx, BOOL *stop) {

            symbol.hidden = idx < length ? NO : YES;
        }];
    }];
}

- (void)setPlaces:(NSInteger)places {
    _places = places;

    if (places > 0) {
        [self setupContents:places];

        if (_textField == nil) {
            _textField = [[UITextField alloc] init];
            _textField.keyboardType = UIKeyboardTypeNumberPad;
            _textField.hidden = YES;
            [self addSubview:_textField];
        }
    }
}

#pragma mark - 视图内部布局相关

- (void)setupContents:(NSInteger)pages {

    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor blackColor].CGColor;

    // 创建分割线
    for (int i = 0; i < pages - 1; i++) {
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor grayColor];
        [self addSubview:line];
    }

    // 创建中心原点
    for (int i = 0; i < pages; i++) {
        CAShapeLayer *symbol = [CAShapeLayer layer];
        symbol.fillColor = [UIColor blackColor].CGColor;
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, PWDInputViewSymbolWH, PWDInputViewSymbolWH)];
        symbol.path = path.CGPath;
        symbol.hidden = YES;
        [self.layer addSublayer:symbol];

        // 将所有中心原点添加到数组中
        [self.symbolArr addObject:symbol];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat lineX = 0;
    CGFloat lineY = 0;
    CGFloat lineW = 1;
    CGFloat lineH = self.frame.size.height;
    CGFloat margin = PWDInputViewSymbolWH * 0.5;

    CGFloat w = self.frame.size.width / self.places;

    for (int i = 0; i < self.places - 1; i++) {
        UIView *line = self.subviews[i];
        lineX = w * (i + 1);
        line.frame = CGRectMake(lineX, lineY, lineW, lineH);
    }

    for (int i = 0; i < self.symbolArr.count; i++) {
        CAShapeLayer *circle = self.symbolArr[i];
        circle.position = CGPointMake(w * (0.5 + i) - margin, self.frame.size.height * 0.5 - margin);
    }
}

#pragma mark - 共有方法

- (void)beginInput {
    [self.textField becomeFirstResponder];
}

- (void)endInput {
    [self.textField resignFirstResponder];
}

#pragma mark - 懒加载

- (NSMutableArray *)symbolArr {
    if (_symbolArr == nil) {
        _symbolArr = [NSMutableArray array];
    }
    return _symbolArr;
}

+ (instancetype)inputView {
    return [[self alloc] init];
}

#pragma mark - 视图销毁

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
