//
//  UserModel.m
//  SinkOrSwim
//
//  Created by Chrishnika Paul on 9/18/24.
//

#import "UserModel.h"
#import "UIKit/UIKit.h"

@interface UserModel()

@property (strong, nonatomic) NSArray* users;
@property (strong, nonatomic) NSString* currentUser;
@property (strong, nonatomic) NSString* userLevel;
@property (strong, nonatomic) UIImage* userImage;

@end

@implementation UserModel

NSString *const USER_FILE = @"UserData";

+ (nonnull UserModel *)sharedInstance {
    static UserModel* _sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        _sharedInstance = [[UserModel alloc] init];
    });
    return _sharedInstance;
}

-(NSArray*)users{
    if(!_users){
        _users = [self loadUsers];
    }
    return _users;
}

-(NSString*)currentUser{
    if(!_currentUser){
        [self setDefaultUser];
    }
    return _currentUser;
}

-(NSString*)userLevel{
    if(!_userLevel){
        [self setDefaultUser];
    }
    return _userLevel;
}

-(UIImage*)userImage{
    if(!_userImage){
        [self setDefaultUser];
    }
    return _userImage;
}

-(void)setDefaultUser{
    NSDictionary* user = self.users[0];
    _currentUser = user[@"name"];
    _userLevel = user[@"level"];
    NSString* picName = user[@"picture"];
    NSLog(@"Picture Name: %@", picName);
    _userImage = [UIImage imageNamed:picName];
}

/*
-(NSString*)username{
    if(!_username){
        NSDictionary* user = self.users[0];
        _username = user[@"name"];
    }
    return _currentUser;
}
*/
/*
- (nonnull UserModel *)changeUser {
    return nil;
}
*/

-(NSArray*)loadUsers
{
    NSDictionary* userFile = [self readUsersFromFile];
    //NSNumber* lastUser = userFile[@"lastUser"];
    NSArray* users = userFile[@"users"];
    //NSDictionary* currentUser = users[lastUser];
    //NSLog(@"Last User: %@", lastUser);
    NSLog(@"First User: %@", users[0]);
    return users;
}

-(id)readUsersFromFile
{
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"TestData" ofType:@"json"];
    NSString *path = [[NSBundle mainBundle] pathForResource:USER_FILE ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

/*
- (nonnull UserModel *)getUser {
    return nil;
}
 */

- (NSString*)getUser {
    return self.currentUser;
}

- (nonnull NSString *)getLevel {
    return self.userLevel;
}

- (UIImage *)getUserImage {
    return  self.userImage;
}

@end
