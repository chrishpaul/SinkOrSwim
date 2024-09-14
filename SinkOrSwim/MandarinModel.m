//
//  MandarinModel.m
//  SinkOrSwim
//
//  Created by Chrishnika Paul on 9/11/24.
//

#import "MandarinModel.h"
#import "UIKit/UIKit.h"
#import <GameplayKit/GameplayKit.h>

@interface MandarinModel()

@property (strong, nonatomic) NSDictionary* mandarinDict;
@property (strong, nonatomic) NSDictionary* pinyinDict;
@property (strong, nonatomic) NSArray* englishWords;
@property (strong, nonatomic) NSDictionary* pictureDict;

@end

@implementation MandarinModel

+(MandarinModel*)sharedInstance{
    static MandarinModel* _sharedInstance = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        _sharedInstance = [[MandarinModel alloc] init];
    } );
    return _sharedInstance;
    
}


 -(NSDictionary*) pictureDict{
    if(!_pictureDict){
        _pictureDict = @{
            @"weekend" : [UIImage imageNamed:@"weekend"],
            @"movies" : [UIImage imageNamed:@"movies"],
            @"sing" : [UIImage imageNamed:@"sing"],
            @"dance" : [UIImage imageNamed:@"dance"],
            @"play ball" : [UIImage imageNamed:@"play ball"]
        };
    }
    return _pictureDict;
}


-(NSDictionary*) mandarinDict{
    if(!_mandarinDict){
        _mandarinDict = @{
            @"weekend" : @"周末",
            @"movies" : @"电影",
            @"sing" : @"唱歌",
            @"dance" : @"舞蹈",
            @"play ball" : @"打球"
        };
    }
    return _mandarinDict;
}

-(NSDictionary*) pinyinDict{
    if(!_pinyinDict){
        _pinyinDict = @{
            @"weekend" : @"zhōumò",
            @"movies" : @"diànyǐng",
            @"sing" : @"chànggē",
            @"dance" : @"wǔdǎo",
            @"play ball" : @"dǎqiú"
        };
    }
    return _pinyinDict;
}

- (NSInteger)numberOfWords {
    return self.englishWords.count;
}

-(NSArray*) englishWords{
    if(!_englishWords){
        _englishWords = [self.mandarinDict allKeys];
    }
    return _englishWords;
}

-(NSString*) getEnglishWordAt:(NSInteger)index{
    return self.englishWords[index];
}

-(NSString*) getMandarinForEnglish:(NSString*)englishWord{
    return self.mandarinDict[englishWord];
}

-(NSString*) getPinyinForEnglish:(NSString*)englishWord{
    return self.pinyinDict[englishWord];
}

-(NSInteger)getIndexOfWord:(NSString*)englishWord{
    return (NSInteger)[self.englishWords indexOfObject:englishWord];
}

-(NSArray*)getShuffledWords{
    return [self.englishWords shuffledArray];
}

-(UIImage*)getPicForEnglishWord:(NSString*)englishWord{
    return self.pictureDict[englishWord];
}

-(UIImage*)getPictureForIndex:(NSInteger)index{
    return self.pictureDict.allValues[index];
}

@end
