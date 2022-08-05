//
//  PIPokemonAutoLayoutTableViewCell.m
//  Pokedex
//
//  Created by Natalia Orbach-Mandel on 8/5/22.
//

#import "PIPokemonAutoLayoutTableViewCell.h"
#import "PIPokemonAutoLayoutView.h"

@implementation PIPokemonAutoLayoutTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _pokemonView = [[PIPokemonAutoLayoutView alloc] init];
        _pokemonView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_pokemonView];
        [self setupConstraints];
    }
    return self;
}

-(void) setupConstraints {
    [NSLayoutConstraint activateConstraints:@[
    // Content view should have same width and height as pokemon view
        [self.contentView.widthAnchor constraintEqualToAnchor:self.pokemonView.widthAnchor],
        [self.contentView.heightAnchor constraintEqualToAnchor:self.pokemonView.heightAnchor]]];
    
}

@end
