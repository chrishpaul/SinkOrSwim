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
@property (nonatomic, assign) NSInteger currentUserIndex;
//@property (strong, nonatomic) NSString* currentUser;
//@property (strong, nonatomic) NSString* userLevel;
//@property (strong, nonatomic) UIImage* userImage;

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

-(NSInteger)currentUserIndex{
    if(!_currentUserIndex){
        _currentUserIndex = 0;
    }
    return _currentUserIndex;
}

-(NSArray*)users{
    if(!_users){
        _users = [self loadUsers];
    }
    return _users;
}

/*
-(NSString*)currentUser{
    if(!_currentUser){
        [self SetCurrentUserTo:self.currentUserIndex];
        //[self setDefaultUser];
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
*/

-(void)setCurrentUserTo:(NSInteger)index{
    self.currentUserIndex = index;
    /*NSDictionary* user = self.users[index];
    self.currentUser = user[@"name"];
    self.userLevel = user[@"level"];
    NSString* imageName = user[@"picture"];
    self.userImage = [UIImage imageNamed:imageName];*/
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

-(NSString*)getUsername {
    NSDictionary* user = self.users[self.currentUserIndex];
    return user[@"name"];
}

-(NSString*)getLevel {
    NSDictionary* user = self.users[self.currentUserIndex];
    return user[@"level"];
}

-(UIImage *)getUserImage {
    NSDictionary* user = self.users[self.currentUserIndex];
    NSString* picName = user[@"picture"];
    return [UIImage imageNamed:picName];
}

- (NSInteger)getNumberOfUsers {
    return self.users.count;
}

- (nonnull NSString *)getLevelByIndex:(NSInteger)index {
    NSDictionary* user = self.users[index];
    return user[@"level"];
}

- (nonnull UIImage *)getUserImageByIndex:(NSInteger)index {
    NSDictionary* user = self.users[index];
    NSString* picName = user[@"picture"];
    //NSLog(@"Picture Name: %@", picName);
    return [UIImage imageNamed:picName];
    
}

- (nonnull NSString *)getUserByIndex:(NSInteger)index {
    NSDictionary* user = self.users[index];
    return user[@"name"];
}


- (void)setUserIndex:(NSInteger)index {
    self.currentUserIndex = index;
}

@end
