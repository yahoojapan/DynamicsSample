//
//  ListViewController.m
//  DynamicsSample
//
//  Created by Shingo Sato on 2013/08/03.
//  Copyright (C) 2013 Yahoo Japan Corporation. All Rights Reserved.
//
//  Copyrights licensed under the MIT License.
//  See the accompanying LICENSE file for terms.
//

#import "ListViewController.h"

@interface ListViewController ()

@end

@implementation ListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *title = [[(UITableViewCell *)sender textLabel] text];
    UIViewController *destination = segue.destinationViewController;
    destination.title =  title;
}

@end
