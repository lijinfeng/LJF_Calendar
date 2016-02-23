//
//  ListTableViewController.m
//  Calendar_MyDemo
//
//  Created by lijinfeng on 16/1/19.
//  Copyright © 2016年 lijinfeng. All rights reserved.
//

#import "ListTableViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

static NSString *cellIdentifier = @"cellIdentifier";

@interface ListTableViewController ()

@property (nonatomic,strong) NSArray *listArray;

@end

@implementation ListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _listArray = [[NSArray alloc] initWithObjects:@"demo1",@"demo2", nil];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = self.listArray[indexPath.row];
    
    return cell;
}


#pragma mark - Table View delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            FirstViewController *firstVC = [[FirstViewController alloc] init];
            [self.navigationController pushViewController:firstVC animated:YES];
        }
            break;
        case 1:
        {
            SecondViewController *secondVC = [[SecondViewController alloc] init];
            [self.navigationController pushViewController:secondVC animated:YES];
        }
            break;
        default:
            break;
    }
}

@end
