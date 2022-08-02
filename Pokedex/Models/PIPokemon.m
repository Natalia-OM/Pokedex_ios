//
//  PIPokemon.m
//  Pokedex
//
//  Created by ricky cancro on 7/20/21.
//

#import "PIPokemon.h"

// import the other files too because we need them for the arrays of types and stats
#import "PIPokemonStat.h"
#import "PIPokemonType.h"

@implementation PIPokemon

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        // name and image assignment
        _name = dictionary[@"name"];
        _imageURL = dictionary[@"sprites"][@"other"][@"official-artwork"][@"front_default"];
        
        // assign primitives
        _number = [dictionary[@"id"] unsignedIntValue];
        _height = [dictionary[@"height"] unsignedIntValue];
        _weight = [dictionary[@"weight"] unsignedIntValue];
        
        // assigning the arrays
        // declaring a mutable array lets us append non-primitive things into an array
        NSMutableArray *stats = [NSMutableArray array];
        for (NSDictionary *stat_dict in dictionary[@"stats"]) {
            PIPokemonStat *tmp_stat = [[PIPokemonStat alloc] initWithDictionary: stat_dict];
            [stats addObject: tmp_stat];
        }
        _stats = stats;
        
        // Type array
        NSMutableArray *types = [NSMutableArray array];
        for (NSDictionary *type_dict in dictionary[@"types"]) {
            PIPokemonType *tmp_type = [[PIPokemonType alloc] initWithDictionary:type_dict];
            [types addObject:tmp_type];
        }
        _types = types;
    }
    return self;
}



@end
