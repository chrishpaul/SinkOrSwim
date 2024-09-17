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

@property (strong, nonatomic) NSDictionary* lessonDict;
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

-(NSDictionary*)lessonDict{
    if(!_lessonDict){
        _lessonDict = [self loadLessonDict];
    }
    return _lessonDict;
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

/*
- (NSInteger)numberOfWords {
    return self.englishWords.count;
}
*/

- (NSInteger)numberOfWords {
    return self.lessonDict.count;
    //return self.englishWords.count;
}

/*
-(NSArray*) englishWords{
    if(!_englishWords){
        _englishWords = [self.mandarinDict allKeys];
    }
    return _englishWords;
}
*/

-(NSArray*) englishWords{
    if(!_englishWords){
        _englishWords = [self.lessonDict allKeys];
    }
    return _englishWords;
}

-(NSString*) getEnglishWordAt:(NSInteger)index{
    return self.englishWords[index];
}

/*
-(NSString*) getMandarinForEnglish:(NSString*)englishWord{
    return self.mandarinDict[englishWord];
}
*/

-(NSString*) getMandarinForEnglish:(NSString*)englishWord{
    NSDictionary* dict = self.lessonDict[englishWord];
    return dict[@"mandarin"];
}

/*
-(NSString*) getPinyinForEnglish:(NSString*)englishWord{
    return self.pinyinDict[englishWord];
}
*/

-(NSString*) getPinyinForEnglish:(NSString*)englishWord{
    NSDictionary* dict = self.lessonDict[englishWord];
    return dict[@"pinyin"];
}

-(NSInteger)getIndexOfWord:(NSString*)englishWord{
    return (NSInteger)[self.englishWords indexOfObject:englishWord];
}

-(NSArray*)getShuffledWords{
    return [self.englishWords shuffledArray];
}

-(NSArray*)getEnglishWords{
    return self.englishWords;
}

/*
-(UIImage*)getPicForEnglishWord:(NSString*)englishWord{
    return self.pictureDict[englishWord];
}
*/

-(UIImage*)getPicForEnglishWord:(NSString*)englishWord{
    NSDictionary* dict = self.lessonDict[englishWord];
    NSString* picName = dict[@"picture"];
    return [UIImage imageNamed:picName];
}

/*
-(UIImage*)getPictureForIndex:(NSInteger)index{
    return self.pictureDict.allValues[index];
}
*/

-(id)readJSONFromFile
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TestData" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

-(NSDictionary*)loadLessonDict
{
    NSDictionary* words = [self readJSONFromFile];
    for(NSString* word in words){
        //NSLog(@"Word: %@", word);
        id value = words[word];
        NSLog(@"Word: %@ Value: %@", word, value);
        if ([word isEqualToString:@"dance"]){
            NSString * mandarin = value[@"mandarin"];
            NSLog(mandarin);
        }
    }
    return words;
    
    //NSArray *words = [dict objectForKey:@"words"];
    
    /*
    for (NSDictionary *word in words) {
        NSString *english = [word objectForKey:@"english"];
        NSString *english2 = word[@"english"];
        NSString *mandarin = [word objectForKey:@"mandarin"];
        NSString *pinyin = [word objectForKey:@"pinyin"];
        NSString *picture = [word objectForKey:@"picture"];
        NSLog(@"English: %@", english);
        NSLog(@"English2: %@", english2);
        NSLog(@"Mandarin: %@", mandarin);
        NSLog(@"Pinyin: %@", pinyin);
        NSLog(@"Picture file: %@", picture);
        
        if ([name isEqualToString:@"green"]) {
            NSArray *pictures = [colour objectForKey:@"pictures"];
            for (NSDictionary *picture in pictures) {
                NSString *pictureName = [picture objectForKey:@"name"];
                NSLog(@"Picture name: %@", pictureName);
            }
        }
    }*/
}

@end
