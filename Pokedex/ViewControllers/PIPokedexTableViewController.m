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

@end
