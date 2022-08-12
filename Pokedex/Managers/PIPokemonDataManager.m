//
//  PIPokemonDataManager.m
//  Pokedex
//
//  Created by Ray Cho on 8/30/21.
//

#import "PIPokemonDataManager.h"
#import "PIPokeData.h"
#import "PIPokemon.h"

NSString * const kPokemonListAPIEndpoint = @"https://pokeapi.co/api/v2/pokemon";

@interface PIPokemonDataManager()

@property (nonatomic, copy, readwrite) NSArray<PIPokemon *> *pokedex;

@end

@implementation PIPokemonDataManager

+ (instancetype)sharedManager
{
    // Creates a single global, shared instance of the class `PIPokemonDataManager`.
    // Provides a unified access point to Pokemon data across surfaces.
    static PIPokemonDataManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[PIPokemonDataManager alloc] init];
    });
    return sharedManager;
}

- (NSArray<PIPokemon *> *)fetchPokedex
{
    // Fetch pokedex if empty, otherwise return the cached pokedex.
    if (self.pokedex.count == 0) {
        self.pokedex = pokedex();
    }
    return self.pokedex;
}

- (void)fetchPokemonWithId:(NSInteger)pokemonId completion:(PokemonFetchCompletion)completion
{
    // make an API call to the endpoint definded in kPokemonListAPIEndpoint and call completion once it's done.
    // Make URL session
    NSURLSession *urlSession = [NSURLSession sharedSession];
    
    // Make the URL request
    // Set up string first
    NSString *urlString = [NSString stringWithFormat:@"https://pokeapi.co/api/v2/pokemon/%lu", pokemonId];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    // Now make data task with the URL we're requesting from
    NSURLSessionDataTask *dataSession = [urlSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        NSInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
        if (statusCode==200) {
            NSError *error = nil;
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            dispatch_sync(dispatch_get_main_queue(), ^{completion([[PIPokemon alloc] initWithDictionary:responseDict]);
            });
            NSLog(@"The response is - %@", responseDict);
        } else {
            NSLog(@"%@",error.localizedDescription);
        }
    }];
    
    // start data task by calling resume
    [dataSession resume];
}



- (void)pinPokemon:(PIPokemon *)pokemon
{
    // Mark a pokemon as "pinned".
    for (PIPokemon *pokemonInPokedex in self.pokedex) {
        if ([pokemonInPokedex.name isEqualToString:pokemon.name]) {
            pokemonInPokedex.isPinned = YES;
            return;
        }
    }
}

@end
