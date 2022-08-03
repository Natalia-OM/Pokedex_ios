//
//  PIPokemonAutoLayoutView.h
//  Pokedex
//
//  Created by ricky cancro on 7/30/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PIPokemon;

@interface PIPokemonAutoLayoutView : UIView

- (void)updateWithPokemon:(PIPokemon *)pokemon;

// Properties for our Autolayout UI
// Main properties to identify pokemon
@property (nonatomic, readonly) UIImageView *pokemonImageView;
@property (nonatomic, readonly) UILabel *pokemonNameLabel;

// Properties to display type
@property (nonatomic, readonly) UIImageView *firstTypeImageView;
@property (nonatomic, readonly) UILabel *firstTypeLabel;
@property (nonatomic, readonly) UIImageView *secondTypeImageView;
@property (nonatomic, readonly) UILabel *secondTypeLabel;
@property (nonatomic, readonly) UILabel *numberLabel;

// Stack views to contain all of our different properties
@property (nonatomic, readonly) UIStackView *typesHorizontalStackView;
@property (nonatomic, readonly) UIStackView *textVerticalStackView;
@property (nonatomic, readonly) UIStackView *cellHorizontalStackView;

@end

NS_ASSUME_NONNULL_END
