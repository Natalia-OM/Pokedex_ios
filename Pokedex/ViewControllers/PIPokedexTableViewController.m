//
//  PIPokedexTableViewController.m
//  Pokedex
//
//  Created by Natalia Orbach-Mandel on 8/4/22.
//

#import "PIPokedexTableViewController.h"

@implementation PIPokedexTableViewController
-(instancetype) init {
    self = [super init];
    if (self) {
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"kCellId"];
        [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"hCellId"];
    }
    return self;
}

// UITableViewDataSource methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kCellId" forIndexPath:indexPath];
    cell.textLabel.text = @"My label text";
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    // Set-up the content configuration
    UIListContentConfiguration *config = UIListContentConfiguration.plainHeaderConfiguration;
    config.text = @"Header title";
    [config.textProperties setColor:[UIColor whiteColor]];
    UIBackgroundConfiguration *backgroundConfig = UIBackgroundConfiguration.listPlainHeaderFooterConfiguration;
    [backgroundConfig setBackgroundColor:[UIColor systemPurpleColor]];

    // Dequeue and set the headerView contentConfiguration
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"hCellId"];
    headerView.contentConfiguration = config;
    [headerView setBackgroundConfiguration:backgroundConfig];
    
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

@end
