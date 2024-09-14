//
//  MandarinModel.h
//  SinkOrSwim
//
//  Created by Chrishnika Paul on 9/11/24.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MandarinModel : NSObject

+(MandarinModel*)sharedInstance;
-(NSInteger)numberOfWords;
-(NSString*)getEnglishWordAt:(NSInteger)index;
-(NSString*)getMandarinForEnglish:(NSString*)englishWord;
-(NSString*)getPinyinForEnglish:(NSString*)englishWord;
-(NSInteger)getIndexOfWord:(NSString*)englishWord;
-(NSArray*)getShuffledWords;
-(UIImage*)getPicForEnglishWord:(NSString*)englishWord;

@end

NS_ASSUME_NONNULL_END
