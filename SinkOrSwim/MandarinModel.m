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
@property (strong, nonatomic) NSArray* englishWords;
//@property (strong, nonatomic) NSString* lessonFile;

@end

@implementation MandarinModel

NSString *const LESSON_FILE = @"TestData";

+(MandarinModel*)sharedInstance{
    static MandarinModel* _sharedInstance = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        _sharedInstance = [[MandarinModel alloc] init];
    } );
    return _sharedInstance;
    
}

/*
-(NSString*)lessonFile{
    if(!_lessonDict){
        _lessonDict = [self loadLessonDict];
    }
    return _lessonDict;
}*/

-(NSDictionary*)lessonDict{
    if(!_lessonDict){
        _lessonDict = [self loadLessonDict];
    }
    return _lessonDict;
}

-(NSInteger)numberOfWords {
    return self.lessonDict.count;
    //return self.englishWords.count;
}

-(NSArray*) englishWords{
    if(!_englishWords){
        _englishWords = [self.lessonDict allKeys];
    }
    return _englishWords;
}

-(NSString*) getEnglishWordAt:(NSInteger)index{
    return self.englishWords[index];
}

-(NSString*) getMandarinForEnglish:(NSString*)englishWord{
    NSDictionary* dict = self.lessonDict[englishWord];
    return dict[@"mandarin"];
}

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

-(UIImage*)getPicForEnglishWord:(NSString*)englishWord{
    NSDictionary* dict = self.lessonDict[englishWord];
    NSString* picName = dict[@"picture"];
    return [UIImage imageNamed:picName];
}

-(id)readJSONFromFile
{
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"TestData" ofType:@"json"];
    NSString *path = [[NSBundle mainBundle] pathForResource:LESSON_FILE ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

-(NSDictionary*)loadLessonDict
{
    NSDictionary* words = [self readJSONFromFile];
    return words;
}

@end
