//
//  ViewController.m
//  TableViewCellBtnClicked
//
//  Created by 张忠瑞 on 2017/6/13.
//  Copyright © 2017年 张忠瑞. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView       *mainTableView;
@property (nonatomic ,strong) UILabel           *showView;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.mainTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    
    self.showView = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 80)];
    self.showView.backgroundColor = [UIColor colorWithRed:61.0/255 green:93.0/255 blue:142.0/255 alpha:1];
    self.showView.textColor = [UIColor whiteColor];
    self.showView.textAlignment = NSTextAlignmentCenter;
    
    
    [self.view addSubview:self.mainTableView];
    [self.view addSubview:self.showView];
}

#pragma mark - 
#pragma mark - UITableViewDelegate & UITabelViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"myCellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
        
        UILabel *myTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 50)];
        myTextLabel.tag = 100;
        myTextLabel.textColor = [UIColor blackColor];
        
        UIButton *myButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-100, 0, 100, 50)];
        myButton.tag = 200;
        [myButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [myButton addTarget:self action:@selector(myButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        [cell.contentView addSubview:myTextLabel];
        [cell.contentView addSubview:myButton];
    }
    
    
    //根据tag获取控件
    UILabel *myTextLabel = (UILabel *)[cell.contentView viewWithTag:100];
    UIButton *myButton = (UIButton *)[cell.contentView viewWithTag:200];
    
    myTextLabel.text = [NSString stringWithFormat:@"这是第%ld行",indexPath.row];
    [myButton setTitle:[NSString stringWithFormat:@"%ld行按钮",indexPath.row] forState:UIControlStateNormal];
    
    
    
    return cell;
    
}


#pragma mark - 
#pragma mark - events

- (void)myButtonClicked:(UIButton *)sender
{
    //获取屏幕上点击按钮位置在tableview中的位置
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.mainTableView];
    //根据坐标获取tableview的index
    NSIndexPath *indexPath = [self.mainTableView indexPathForRowAtPoint:buttonPosition];
    //如果indexPath不为空
    
    

    if(indexPath)
    {
        [self.view.layer removeAllAnimations];

        self.showView.text = [NSString stringWithFormat:@"%ld行被点击了",indexPath.row];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.showView.frame = CGRectMake(0, self.view.bounds.size.height-80, self.view.bounds.size.width, 80);
        } completion:^(BOOL finished) {
            if(!finished)
            {
                self.showView.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 80);
            }
        }];
        
        [UIView animateWithDuration:0.3 delay:3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.showView.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 80);
        } completion:^(BOOL finished) {
            if(!finished)
            {
                self.showView.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 80);
            }
        }];
    }

}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
