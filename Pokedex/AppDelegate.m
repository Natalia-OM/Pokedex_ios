//
//  AppDelegate.m
//  Pokedex
//
//  Created by ricky cancro on 7/20/21.
//  Modified by Natalia Orbach-Mandel on 8.2.22
//

#import "AppDelegate.h"

#import "ViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
/* 
    NSDictionary *pokemonTypeData = exampleTypeData();
    PIPokemonType *pokemonType = [[PIPokemonType alloc] initWithDictionary:pokemonTypeData];
    NSLog(@"Pokemon type:\n%@", pokemonType);

    NSDictionary *pokemonStatData = exampleStatData();
    PIPokemonStat *pokemonStat = [[PIPokemonStat alloc] initWithDictionary:pokemonStatData];
    NSLog(@"Pokemon type:\n%@", pokemonStat);

    NSDictionary *pokemonData = [pokeData() firstObject];
    PIPokemon *pokemon = [[PIPokemon alloc] initWithDictionary:pokemonData];
    NSLog(@"Pokemon:\n%@", pokemon);

*/
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.rootViewController = [[ViewController alloc] init];
    [self.window makeKeyAndVisible];

    return YES;
}


@end
