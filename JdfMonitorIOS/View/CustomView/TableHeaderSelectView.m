//
//  CircleTableHeaderView.m
//  YPEduApp
//
//  Created by guyunlong on 12/1/15.
//  Copyright © 2015 ypeeducation. All rights reserved.
//

#import "TableHeaderSelectView.h"
#import "UIColor+expanded.h"
#import "UIView+Common.h"
#define  selfheight self.frame.size.height


@interface TableHeaderSelectView ()
@property (strong, nonatomic) NSMutableArray *headerBtns;//类别
@property (nonatomic, strong) CALayer *selectionIndicatorBoxLayer;//选中底部条
@property (nonatomic, strong) CALayer *bottomBoxLayer;//底部颜色
@property (nonatomic) CGFloat selectionIndicatorBoxOpacity;

@property float linewidth;//线的长度
@property NSInteger index;
@end
@implementation TableHeaderSelectView

- (void)setData:(NSArray *)data{
    if (data == nil) {
        return;
    }
    if (_data != data) {
        _data = data;
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _headerBtns = [[NSMutableArray alloc] init];
        self.selectionIndicatorBoxLayer = [CALayer layer];
        self.bottomBoxLayer = [CALayer layer];
        self.selectionIndicatorBoxOpacity = 0.8;
        
        self.selectionIndicatorBoxLayer.opacity = self.selectionIndicatorBoxOpacity;
        self.selectionIndicatorBoxLayer.backgroundColor = appcolor1.CGColor;
        self.bottomBoxLayer.backgroundColor = [UIColor colorWithHexString:@"0xcccccc"].CGColor;
        
        
        _index = 0;
        _match = false;
        
        
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    if (!_data) {
        return;
    }
    if ([_headerBtns count]>0) {
        return;
    }
    NSInteger count = [_data count];
    for (NSInteger i =0; i<[_data count]; i++){
        UIButton *headerBtn = [[UIButton alloc] init];
        headerBtn.frame = CGRectMake(i * FFScreenWith/count,0,FFScreenWith/count,selfheight-2);
        [headerBtn setTitle:[_data objectAtIndex:i] forState:UIControlStateNormal];
        [headerBtn addTarget:self action:@selector(onClickHeaderBtn:) forControlEvents:UIControlEventTouchUpInside];
        if (0 == i) {
            [headerBtn setTitleColor:appcolor1 forState:UIControlStateNormal];
        }
        else{
            [headerBtn setTitleColor:[UIColor colorWithHexString:@"0x535353"] forState:UIControlStateNormal];
        }
        [headerBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [headerBtn setTag:i];
        [self addSubview:headerBtn];
        [_headerBtns addObject:headerBtn];
    }
   
    
}

- (void)drawRect:(CGRect)rect {
    float span = 0;
    if (_match) {
        CGSize originlabelSize = [[_data objectAtIndex:0] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        _linewidth = originlabelSize.width;
        span =(FFScreenWith/[_data count]-_linewidth)/2;
    }
    else{
        _linewidth = FFScreenWith/[_data count];
    }
    self.selectionIndicatorBoxLayer.frame = CGRectMake(span+FFScreenWith/[_data count]*_index, selfheight-2, _linewidth, 2);
    [self.layer addSublayer:self.selectionIndicatorBoxLayer];
    
    self.bottomBoxLayer.frame = CGRectMake(0, selfheight-0.3, FFScreenWith, 0.3);
    [self.layer addSublayer:self.bottomBoxLayer];
    
}
-(void)onClickHeaderBtn:(id)sender{
    UIButton * btn = sender;
    NSInteger tag = [btn tag];
    _index = tag;
    for (int i = 0; i<[_headerBtns count]; i++) {
        UIButton * btn = [_headerBtns objectAtIndex:i];
        NSInteger tempTag = [btn tag];
        if (tempTag == tag) {
            [btn setTitleColor:appcolor1 forState:UIControlStateNormal];
        }
        else{
            [btn setTitleColor:[UIColor colorWithHexString:@"0x535353"] forState:UIControlStateNormal];
        }
    }
    if (_delegate && [_delegate respondsToSelector:@selector(selectedIndex:)]) {
         [_delegate selectedIndex:_index];
    }
    [self setNeedsDisplay];
    
}
-(void)tran2Index:(NSUInteger)desIndex{
    if (desIndex >= [_data count] || desIndex == _index) {
        return;
    }
    else{
        UIButton * btn = [_headerBtns objectAtIndex:desIndex];
        [self onClickHeaderBtn:btn];
    }
}


@end
