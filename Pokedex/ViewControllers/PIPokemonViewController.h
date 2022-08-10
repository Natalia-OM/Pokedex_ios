//
//  PIPokemonViewController.h
//  Pokedex
//
//  Created by Ray Cho on 8/27/21.
//

#import <UIKit/UIKit.h>

@class PIPokemon;
@class PIPokemonViewController;

NS_ASSUME_NONNULL_BEGIN
// Create protocol for delegate
@protocol PIPokemonViewControllerDelegate
// Define delegate methods that the delegate will need to implement
// Solutions comment: Naming convention is to have name of object requesting delegation
// as a prefix, in this case, PIPokemonViewController, and use arguments to describe the event
// occurring in the object
- (void)PIPokemonViewControllerDidRequestDismissal:(PIPokemonViewController *)viewController;
- (void)PIPokemonViewController:(PIPokemonViewController *)viewController didPinPokemon:(PIPokemon *)pokemon;
@end


@interface PIPokemonViewController : UIViewController

@property (nonatomic, readwrite, weak) id <PIPokemonViewControllerDelegate> delegate;

- (instancetype)initWithPokemon:(PIPokemon *)pokemon;

@end

NS_ASSUME_NONNULL_END
