//
//  PIPokemonAutoLayoutView.m
//  Pokedex
//
//  Created by ricky cancro on 7/30/21.
//

#import "PIPokemonAutoLayoutView.h"
#import "PIPokemon+Additions.h"
#import "PIPokemonType+TypeIcon.h"
#import "UIImageView+URL.h"

static const CGSize kPokemonImageSize = { .width = 56.0, .height = 56.0 };
static const CGSize kPokemonTypeImageSize = { .width = 14.0, .height = 14.0 };


@interface PIPokemonAutoLayoutView()


@end

@implementation PIPokemonAutoLayoutView

- (instancetype)init {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        // Set up labels now to display the different UI objects
        // Labels first
        _pokemonNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _pokemonNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _pokemonNameLabel.textColor = [UIColor darkTextColor];
        _pokemonNameLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];
        
        _firstTypeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _firstTypeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _firstTypeLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
        _secondTypeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _secondTypeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _secondTypeLabel.font= [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
        
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _numberLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _numberLabel.textColor = [UIColor lightTextColor];
        _numberLabel.font = [UIFont systemFontOfSize:36 weight:UIFontWeightBold];
        
        // Set up imageViews without image since that gets updated later
        _pokemonImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _pokemonImageView.translatesAutoresizingMaskIntoConstraints = NO;
        
        _firstTypeImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _firstTypeImageView.translatesAutoresizingMaskIntoConstraints = NO;
        
        _secondTypeImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _secondTypeImageView.translatesAutoresizingMaskIntoConstraints = NO;
        
        
        // StackViews to hold our labels and images
        _typesHorizontalStackView = [[UIStackView alloc] initWithArrangedSubviews:@[_firstTypeImageView, _firstTypeLabel,
                                                                                    _secondTypeImageView, _secondTypeLabel]];
        _typesHorizontalStackView.axis = UILayoutConstraintAxisHorizontal;
        _typesHorizontalStackView.spacing = 4;
        _typesHorizontalStackView.translatesAutoresizingMaskIntoConstraints = NO;
        [_typesHorizontalStackView setCustomSpacing:8 afterView:_firstTypeLabel];
        // To get the subview to actually show up
        [self addSubview:_typesHorizontalStackView];
        
        _textVerticalStackView = [[UIStackView alloc] initWithArrangedSubviews:@[_pokemonNameLabel, _typesHorizontalStackView]];
        _textVerticalStackView.axis = UILayoutConstraintAxisVertical;
        _textVerticalStackView.spacing = 4;
        _textVerticalStackView.translatesAutoresizingMaskIntoConstraints=NO;
        [self addSubview:_textVerticalStackView];
        
        // hugging constraints to get the number further:
        [_pokemonImageView setContentHuggingPriority:UILayoutPriorityDefaultHigh
         forAxis:UILayoutConstraintAxisHorizontal];

        [_numberLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh
                               forAxis:UILayoutConstraintAxisHorizontal];

        [_textVerticalStackView setContentHuggingPriority:UILayoutPriorityDefaultLow
        forAxis:UILayoutConstraintAxisHorizontal];
        
        _cellHorizontalStackView = [[UIStackView alloc] initWithArrangedSubviews:@[_pokemonImageView, _textVerticalStackView, _numberLabel]];
        _cellHorizontalStackView.axis = UILayoutConstraintAxisHorizontal;
        _cellHorizontalStackView.spacing = 16;
        _cellHorizontalStackView.translatesAutoresizingMaskIntoConstraints=NO;
        [self addSubview: _cellHorizontalStackView];
        
        [self setupConstraints];
        
        
    }
    return self;
}

- (void)setupConstraints {
    // Constraints for the cellHorizontalStackView to lay itself out
    [NSLayoutConstraint activateConstraints:@[
        // Avoid image taking full space with constraints
        [self.pokemonImageView.widthAnchor constraintEqualToConstant: 56],
        [self.pokemonImageView.heightAnchor constraintEqualToConstant:56],
        //Set up type image height/width constraints as well
        [self.firstTypeImageView.widthAnchor constraintEqualToConstant:14],
        [self.firstTypeImageView.heightAnchor constraintEqualToConstant:14],
        [self.secondTypeImageView.widthAnchor constraintEqualToConstant:14],
        [self.secondTypeImageView.heightAnchor constraintEqualToConstant:14],
        // Set up the buffer around the screen to be 16 pts
        [self.cellHorizontalStackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:16],
        [self.cellHorizontalStackView.topAnchor constraintEqualToAnchor:self.topAnchor constant:16],
        [self.cellHorizontalStackView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-16],
        [self.cellHorizontalStackView.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-16]
    ]];
}

- (void)updateWithPokemon:(PIPokemon *)pokemon
{
    // Update the UI with the image from the inputted pokemon
    self.numberLabel.text = [pokemon pokemonNumberAsFormattedString];
    self.pokemonNameLabel.text = [pokemon.name capitalizedString];
    [self.pokemonImageView setURL:pokemon.imageURL];
    
    // Pokemon have at most 2 types
    PIPokemonType *firstType = [pokemon.types firstObject];
    // From solution - this is how to do a conditional assignment
    PIPokemonType *secType = pokemon.types.count > 1 ? [pokemon.types lastObject] : nil;
    
    self.firstTypeLabel.text = [firstType.name capitalizedString];
    self.firstTypeLabel.textColor = [firstType colorForType];
    self.firstTypeImageView.image = [firstType imageForType];
    
    // Need to be more intentional with second type since can be nil
    if (secType) {
        self.secondTypeLabel.text = [secType.name capitalizedString];
        self.secondTypeLabel.textColor = [secType colorForType];
        self.secondTypeImageView.image = [secType imageForType];
    }
    else{
        self.secondTypeLabel.text = nil;
        self.secondTypeImageView.image = nil;
    }
    
    
}

@end
