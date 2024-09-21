//
//  UserModel.h
//  SinkOrSwim
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject

+(UserModel*)sharedInstance;
-(NSString*)getUsername;                    // Get current username
-(NSString*)getLevel;                       // Get current user's level
-(UIImage*)getUserImage;                    // Get current user's image
-(NSInteger)getNumberOfUsers;               // Get total number of users
-(void)setCurrentUserTo:(NSInteger)index;   // Set current user by index
-(NSString*)getUserBy:(NSInteger)index;        // Get username by index
-(NSString*)getLevelBy:(NSInteger)index;       // Get user's level by index
-(UIImage*)getUserImageBy:(NSInteger)index;    // Get user's image by index

@end

NS_ASSUME_NONNULL_END
