//
//  PIPokedexTableViewController.m
//  Pokedex
//
//  Created by Marcelo Queiroz on 8/12/21.
//

#import <AVFAudio/AVAudioPlayer.h>

#import "PIPokedexTableViewController.h"

#import "PIPokeData.h"
#import "PIPokemon.h"
#import "PIPokemonAutoLayoutTableViewCell.h"
#import "PIPokemonViewController.h"
#import "PIPokemonDataManager.h"


@interface PIPokedexTableViewController() <PIPokemonViewControllerDelegate>

@end

@implementation PIPokedexTableViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _pokedex = [PIPokemonDataManager.sharedManager fetchPokedexData];
        [self.tableView registerClass:[PIPokemonAutoLayoutTableViewCell class] forCellReuseIdentifier:@"PokemonCell"];
        
        UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressHandler:)];
        [self.tableView addGestureRecognizer:longPressGestureRecognizer];
    }
    return self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pokedex.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Set up table view with a pokemon object cell in it
    PIPokemon *pokemon = self.pokedex[indexPath.row];   // Get the pokemon at index [row] of our actual tableview
    PIPokemonAutoLayoutTableViewCell *pokemonCell = (PIPokemonAutoLayoutTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"PokemonCell"];
    [pokemonCell.pokemonView updateWithPokemon:pokemon];
    return pokemonCell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // "Tells the delegate a row is selected", according to documentation
    PIPokemon *pokemon = self.pokedex[indexPath.row];
    PIPokemonViewController *pokemonViewController = [[PIPokemonViewController alloc] initWithPokemon:pokemon];
    pokemonViewController.delegate = self;
    [self presentViewController:pokemonViewController animated:YES completion:nil];
}

#pragma mark - Gesture Recognizers

- (void) longPressHandler:(UILongPressGestureRecognizer *)gestureRecognizer
{
    // Find the point where the long press happened
    // Create an NSIndexPath to that point
    // Use that path for the pokemon
    CGPoint point = [gestureRecognizer locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:point];
    if (indexPath != nil && indexPath.row && gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        PIPokemon *pokemon = self.pokedex[indexPath.row];
        self.pokemonNoisePlayer = [self createAudioPlayerForPokemon:pokemon];
        [self.pokemonNoisePlayer play];
    }
}

#pragma mark - Helper

- (AVAudioPlayer *)createAudioPlayerForPokemon:(PIPokemon *)pokemon
{
    NSString *pokemonName = pokemon.name;
    NSURL *cryURL = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                                pathForResource:pokemonName ofType:@"mp3"]];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:cryURL error:nil];
    [player prepareToPlay];
    return player;
}

#pragma mark - PIPokemonViewControllerDelegate


- (void)PIPokemonViewControllerDidRequestDismissal:(PIPokemonViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)PIPokemonViewController:(PIPokemonViewController *)viewController didPinPokemon:(PIPokemon *)pokemon
{
    // When someone hits pin, dismiss the view, and then reload the tableview
    [self dismissViewControllerAnimated:YES completion:^{
        self.pokedex = [PIPokemonDataManager.sharedManager fetchPokedexData];
        [self.tableView reloadData];
        }];
}

@end
