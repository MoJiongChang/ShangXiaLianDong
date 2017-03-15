//
//  ViewController.m
//  ShangXiaLianDong
//
//  Created by gdshwhl007 on 17/3/15.
//  Copyright © 2017年 莫炯昌. All rights reserved.
//

#import "ViewController.h"
#define CurrentHeight ([UIScreen mainScreen].bounds.size.height)
#define CurrentWidth ([UIScreen mainScreen].bounds.size.width)

@interface ViewController ()<UIScrollViewDelegate>


{
    
    UIScrollView *scorllview;
    UIScrollView *scorllview2;
    
    UIButton *selectBut;
    UIImageView *bomline;
}

@property (nonatomic, strong) NSArray *nameArray;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self mainUI];
}

-(void)mainUI{
    
    NSArray *arr = @[@"1",@"2",@"3",@"4",@"5",@"6"];
    
    
    scorllview = [[UIScrollView alloc]init];
    scorllview.frame = CGRectMake(0, 20, CurrentWidth,45);
    scorllview.contentSize = CGSizeMake(arr.count*CurrentWidth/3, 45);
    [self.view addSubview:scorllview];
    scorllview.backgroundColor = [UIColor whiteColor];
    scorllview.userInteractionEnabled = YES;
    
    scorllview.tag = 520;
    // 取消水平滚动条
    scorllview.showsHorizontalScrollIndicator = NO;
    // 设置偏移位置
    //    scorllview.contentOffset = CGPointMake(0, 0);
    // 分页使能
    //    scorllview.pagingEnabled = YES;
    
    scorllview.delegate = self;
    
    for(int i = 0; i < arr.count; i++){
        
        UIButton *but = [[UIButton alloc]initWithFrame:CGRectMake(i*CurrentWidth/3, 0, CurrentWidth/3, 40)];
        [but setTitle:arr[i] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        but.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
        but.tag = 100+i;
        [but addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            selectBut = but;
        }
        [scorllview addSubview:but];
        
    }
    
    
    bomline = [[UIImageView alloc]initWithFrame:CGRectMake(10, 40, CurrentWidth/3-20, 5)];
    bomline.backgroundColor = [UIColor redColor];
    [scorllview addSubview:bomline];
    
    scorllview2 = [[UIScrollView alloc]init];
    scorllview2.frame = CGRectMake(0, 65, CurrentWidth,200);
    scorllview2.contentSize = CGSizeMake(arr.count*CurrentWidth, 200);
    [self.view addSubview:scorllview2];
    scorllview2.backgroundColor = [UIColor whiteColor];
    scorllview2.userInteractionEnabled = YES;
    
    scorllview2.tag = 520;
    // 取消水平滚动条
    scorllview2.showsHorizontalScrollIndicator = NO;
    // 设置偏移位置
    //    scorllview.contentOffset = CGPointMake(0, 0);
    // 分页使能
    scorllview2.pagingEnabled = YES;
    
    scorllview2.delegate = self;
    
    for(int i = 0; i < arr.count; i++){
        
        UIImageView *img= [[UIImageView alloc]initWithFrame:CGRectMake(i*CurrentWidth, 0, CurrentWidth, 200)];
        img.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
        img.tag = 200+i;
        [scorllview2 addSubview:img];
        
    }
    
}

#pragma mark - scrollViewDelegate

// 拖动结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView == scorllview2) {
        
        int btag = scrollView.contentOffset.x / CurrentWidth;
        selectBut = (UIButton *)[scorllview viewWithTag:100+btag];
        [self selectButChange];
        
    }
}

// 结束滚动
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    if (scrollView == scorllview) {
        
    }
    
}


-(void)butClick:(UIButton *)but{
    
    selectBut = but;
    
    [self selectButChange];
    
    scorllview2.contentOffset = CGPointMake((but.tag-100)*CurrentWidth, 0);
}

-(void)selectButChange{
    
    //1.计算channelView应该滚动多远
    CGFloat needScrollContentOffsetX = selectBut.center.x - scorllview.bounds.size.width * 0.5;
    
    //1.1 重新设置,点击最左边的极限值
    if (needScrollContentOffsetX < 0) {
        needScrollContentOffsetX = 0;
    }
    CGFloat maxScrollContentOffsetX = scorllview.contentSize.width - scorllview.bounds.size.width;
    
    //1.2 重新设置,点击最右边的极限值
    if (needScrollContentOffsetX > maxScrollContentOffsetX) {
        needScrollContentOffsetX = maxScrollContentOffsetX;
    }
    
    //2.让其滚动
    [scorllview setContentOffset:CGPointMake(needScrollContentOffsetX, 0) animated:YES];
    
    [self underLinePosition:needScrollContentOffsetX];
    
    //跳转到对应底部界面
    
}

#pragma mark - 底线的动画
- (void)underLinePosition:(CGFloat)needScrollContentOffsetX {
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect tempFrame = bomline.frame;
        //        tempFrame.origin.x = selectBut.frame.origin.x - needScrollContentOffsetX;
        tempFrame.origin.x = selectBut.frame.origin.x + 10;
        bomline.frame = tempFrame;
    }];
    
}

///==================================================



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
