//
//  MandarinModel.m
//  SinkOrSwim
//

#import "MandarinModel.h"
#import "UIKit/UIKit.h"
#import <GameplayKit/GameplayKit.h>

@interface MandarinModel()

@property (strong, nonatomic) NSDictionary* lessonDict;     // Dictionary of words in lesson
@property (strong, nonatomic) NSArray* englishWords;        // Array of English words in lesson

@end

@implementation MandarinModel

NSString *const LESSON_FILE = @"TestData";      // Name of JSON file containing words in lesson

+(MandarinModel*)sharedInstance{
    // Returns shared instance for MandarinModel following singleton pattern

    static MandarinModel* _sharedInstance = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        _sharedInstance = [[MandarinModel alloc] init];
    } );
    return _sharedInstance;
    
}

// MARK: Getters

-(NSDictionary*)lessonDict{
    // Getter for lessonDict
    
    if(!_lessonDict){
        _lessonDict = [self loadLessonDict];
    }
    return _lessonDict;
}

-(NSArray*)englishWords{
    // Getter for englishWords
    
    if(!_englishWords){
        _englishWords = [self.lessonDict allKeys];
    }
    return _englishWords;
}

-(NSString*) getEnglishWordAt:(NSInteger)index{
    // Returns English word at provided index
    
    return self.englishWords[index];
}

-(NSString*) getMandarinFor:(NSString*)englishWord{
    // Returns Mandarin translation for provided English word
    
    NSDictionary* dict = self.lessonDict[englishWord];
    return dict[@"mandarin"];
}

-(NSString*) getPinyinFor:(NSString*)englishWord{
    // Returns pinyin form for provided English word
    
    NSDictionary* dict = self.lessonDict[englishWord];
    return dict[@"pinyin"];
}

-(UIImage*)getPicFor:(NSString*)englishWord{
    // Returns image associated with provided English word
    
    NSDictionary* dict = self.lessonDict[englishWord];
    NSString* picName = dict[@"picture"];
    return [UIImage imageNamed:picName];
}

-(NSInteger)numberOfWords {
    // Returns number of words in lesson
    
    return self.lessonDict.count;
}

-(NSInteger)getIndexOfWord:(NSString*)englishWord{
    // Returns index of provided English word
    
    return (NSInteger)[self.englishWords indexOfObject:englishWord];
}

-(NSArray*)getEnglishWords{
    // Returns list of English words in lesson
    
    return self.englishWords;
}

-(NSArray*)getShuffledWords{
    // Returns a shuffled list of English words
    
    return [self.englishWords shuffledArray];
}

// MARK: Helper functions
-(NSDictionary*)loadLessonDict
{
    // Loads lesson data from JSON file
    
    id words = [self readJSONFromFile];
    
    // Check file is not empty and has expected NSDictionary structure
    if ([words isKindOfClass:[NSDictionary class]]){
        return words;
    }
    
    // File is empty or badly formatted
    NSLog(@"Invalid input JSON for lesson. Expected a dictionary. Check format of %@.json", LESSON_FILE);
    return [[NSDictionary alloc] init];
}

-(id)readJSONFromFile
{
    // Reads JSON from file
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    NSString *path = [[NSBundle mainBundle] pathForResource:LESSON_FILE ofType:@"json"];
    if ([filemgr fileExistsAtPath: path ]){                     // Check that file exists
        NSData *data = [NSData dataWithContentsOfFile:path];
        return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    }else{
        NSLog(@"Input file not found: %@.json", LESSON_FILE);
    }
    return nil;
}

- (BOOL)isValidLesson {
    // Checks for valid lesson input
    
    if(self.lessonDict.count > 0){
        return true;
    }
    return false;
}

@end
