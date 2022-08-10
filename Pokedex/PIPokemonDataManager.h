//
//  PIPokemonDataManager.h
//  Pokedex
//
//  Created by Natalia Orbach-Mandel on 8/10/22.
//

#import <Foundation/Foundation.h>

@class PIPokemon;

NS_ASSUME_NONNULL_BEGIN

// Manages pokedex data across different parts of the app
@interface PIPokemonDataManager : NSObject

// Look into how the dispatch once setup works (GCD) in an app
@property (class, strong, readonly) PIPokemonDataManager *sharedManager;
- (NSArray<PIPokemon *> *)fetchPokedexData;
- (void)pinPokemon:(PIPokemon *)pokemon;

@end

NS_ASSUME_NONNULL_END
