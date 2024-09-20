//
//  UserModel.h
//  SinkOrSwim
//
//  Created by Chrishnika Paul on 9/18/24.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject

//@property (strong, nonatomic) NSString* currentUser;
//@property (strong, nonatomic) NSString* username;
//@property (strong, nonatomic) NSString* dateString;
//@property (strong, nonatomic) NSString* level;

+(UserModel*)sharedInstance;
-(NSString*)getUsername;
-(NSString*)getLevel;
-(UIImage*)getUserImage;
-(NSInteger)getNumberOfUsers;
-(void)setCurrentUserTo:(NSInteger)index;


-(NSString*)getUserByIndex:(NSInteger)index;
-(NSString*)getLevelByIndex:(NSInteger)index;
-(UIImage*)getUserImageByIndex:(NSInteger)index;
//-(UserModel*)changeUser;
@end

NS_ASSUME_NONNULL_END
