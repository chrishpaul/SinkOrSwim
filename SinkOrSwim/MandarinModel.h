//
//  MandarinModel.h
//  SinkOrSwim
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MandarinModel : NSObject

+(MandarinModel*)sharedInstance;
-(NSString*)getEnglishWordAt:(NSInteger)index;          // Gets English word by index
-(NSString*)getMandarinFor:(NSString*)englishWord;      // Gets Mandarin word by index
-(NSString*)getPinyinFor:(NSString*)englishWord;        // Gets pinyin form by index
-(UIImage*)getPicFor:(NSString*)englishWord;            // Gets picture form by index
-(NSInteger)numberOfWords;                              // Gets number of words
-(NSInteger)getIndexOfWord:(NSString*)englishWord;      // Gets index of an English word
-(NSArray*)getEnglishWords;                             // Gets a list of English words
-(NSArray*)getShuffledWords;                            // Gets a shuffled list of English words
-(BOOL)isValidLesson;                                   // True if input lesson file is valid

@end

NS_ASSUME_NONNULL_END
