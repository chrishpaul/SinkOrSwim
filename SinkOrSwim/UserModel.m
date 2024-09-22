//
//  UserModel.m
//  SinkOrSwim
//

#import "UserModel.h"
#import "UIKit/UIKit.h"

@interface UserModel()

@property (strong, nonatomic) NSArray* users;               // Array of available users
@property (nonatomic, assign) NSInteger currentUserIndex;   // Index of current user in users array

@end

@implementation UserModel

NSString *const USER_FILE = @"UserData";                    // JSON filename for user configuration

+ (nonnull UserModel *)sharedInstance {
    // Returns shared instance for user model following singleton pattern
    
    static UserModel* _sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        _sharedInstance = [[UserModel alloc] init];
    });
    return _sharedInstance;
}

// MARK: Getters
-(NSInteger)currentUserIndex{
    // Getter for currentUserIndex property
    
    if(!_currentUserIndex){
        _currentUserIndex = 0;      // Default index value is 0
    }
    return _currentUserIndex;
}

-(NSArray*)users{
    // Getter for users property
    
    if(!_users){
        _users = [self loadUsers];  // Load users if nil
    }
    return _users;
}

-(NSString*)getUsername {
    // Returns current username
    
    NSDictionary* user = self.users[self.currentUserIndex];
    return user[@"name"];
}

-(NSString*)getLevel {
    // Returns current user's level
    
    NSDictionary* user = self.users[self.currentUserIndex];
    return user[@"level"];
}

-(UIImage *)getUserImage {
    // Returns current user's image
    
    NSDictionary* user = self.users[self.currentUserIndex];
    NSString* picName = user[@"picture"];
    return [UIImage imageNamed:picName];
}

- (NSInteger)getNumberOfUsers {
    // Returns number of users
    
    return self.users.count;
}

- (nonnull NSString *)getUserBy:(NSInteger)index {
    // Returns username by user index number
    
    NSDictionary* user = self.users[index];
    return user[@"name"];
}

- (nonnull NSString *)getLevelBy:(NSInteger)index {
    // Returns user's level by user index number
    
    NSDictionary* user = self.users[index];
    return user[@"level"];
}

- (nonnull UIImage *)getUserImageBy:(NSInteger)index {
    // Returns users's image by user index number
    
    NSDictionary* user = self.users[index];
    NSString* picName = user[@"picture"];
    return [UIImage imageNamed:picName];
}

// MARK: Setters
-(void)setCurrentUserTo:(NSInteger)index{
    // Sets currentUserIndex to provided value
    
    self.currentUserIndex = index;
}

-(NSArray*)loadUsers
{
    // Loads user data into array
    
    id userFile = [self readUsersFromFile];
    
    // Check file is not empty and has expected NSDictionary structure
    if (userFile != nil && [userFile isKindOfClass:[NSDictionary class]]){
        id users = userFile[@"users"];
        
        // Check that users is an NSArray
        if ([users isKindOfClass:[NSArray class]]){
            return users;
        }
    }
    // File was empty or badly formatted
    NSLog(@"Invalid user file: %@", USER_FILE);
    return [[NSArray alloc] init];
}

-(id)readUsersFromFile
{
    // Reads JSON from file
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    NSString *path = [[NSBundle mainBundle] pathForResource:USER_FILE ofType:@"json"];
    if ([filemgr fileExistsAtPath: path ]){                     // Check that file exists
        NSData *data = [NSData dataWithContentsOfFile:path];
        return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    }else{
        NSLog(@"Input file not found: %@.json", USER_FILE);
    }
    return nil;
}

- (BOOL)isValidInput {
    // Checks for valid lesson input
    
    if(self.users.count > 0){
        return true;
    }
    return false;
}

@end
