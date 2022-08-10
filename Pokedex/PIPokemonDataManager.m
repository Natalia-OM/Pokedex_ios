//
//  PIPokemonDataManager.m
//  Pokedex
//
//  Created by Natalia Orbach-Mandel on 8/10/22.
//

#import "PIPokemonDataManager.h"
#import "PIPokeData.h"
#import "PIPokemon.h"

@interface PIPokemonDataManager()
@property (nonatomic, copy, readwrite) NSArray<PIPokemon *> *pokedex;
@end


@implementation PIPokemonDataManager
- (instancetype)init
{
    return self;
}

+ (instancetype)sharedManager
{
    static PIPokemonDataManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[PIPokemonDataManager alloc] init];
    });
    return sharedManager;
}

- (NSArray<PIPokemon *> *)fetchPokedexData {
    // if the pokedex is empty, fetch it,
    // otherwise it will be cached and we can leave as is
    if (self.pokedex.count == 0) {
        self.pokedex = pokedex();
    }
    return self.pokedex;
}

- (void)pinPokemon:(PIPokemon *)pokemon {
    // we need to figure out which pokemon got pinned
    // mark as pinned in our PIPokemonIsPinned var
    // use the pokemon number maybe
    for (PIPokemon *currentPokemon in self.pokedex) {
        if (currentPokemon.number == pokemon.number) {
            currentPokemon.isPinned = YES;
            return;
        }
    }
}

@end
