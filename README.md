A simple application to help students study Mandarin vocabulary words.

LessonView : UITableView with 3 cell types
  1) Mandarin words with English translation -> clicking navigates to 'WordView'
  2) Picture Dictionary cell -> clicking navigates to 'PictureDict'
  3) Quiz cell -> clicking navigates to 'Quiz'
WordView : UIView
  1) UIScrollView with embedded UIImageView displays associated picture for the word
  2) UILabel to display English, Mandarin, and pinyin words
  3) UISegmentedControl to see Mandarin only, English only, pinyin only or all.
  4) UISlider to adjust font size of words
  5) UIStepper to move to next word
PictureDict : UIView
  1) UICollectionView of UICollectionItem
  2) Displays all words with pictures
Quiz : UIView
  1) UISwitch for toggling timed mode
  2) UITimer to implement a time limit and refreshes UIVieww with right answer/next question
  3) Picker to choose correct English word
  4) Button to start quiz
  5) Button to submit answer
Results : UIView (Modal)
  1) Displays quiz results
  2) Buttons to restart quiz or return to LessonView
 
Tracking Items:
- [ ] Automatic Layout 
- [x] Buttons (Quiz view)
- [ ] Sliders
- [ ] Labels (Quiz view, Word Review view)
- [x] Stepper (Word Review)
- [ ] Switch
- [x] Picker (you must implement picker delegate) (Quiz)
- [x] Segmented Control (Word Review)
- [x] Timer (which should repeat and somehow update the UIView) (Quiz) (0.5pts)
- [ ] ScrollView (with scrollable, zoomable content) (Word Review)
- [ ] Image View (Word Review, Picture Dictionary)
- [x] Navigation Controller. Proper navigation (1pt)
- [ ] Collection View Controller (Picture Dictionary)
- [ ] Table View Controller with three different dynamic prototype cells (Not hardcoded)
- [ ] Type 1: English to Mandarin Word Cell
- [ ] Type 2: Link to Quiz - would this be considered hard coding?
- [ ] Type 3: Link to Picture Dictionary with pictures - would this be considered hard coding?
- [ ] The design should work in both portrait and landscape mode. Use size classes if necessary. (2 pts)
- [ ] Tested for crashing
- [ ] Strictly adheres to Model View Controller programming practices. View should be agnostic to controller. Model should be agnostic to everything. (1pts)
- [ ] Lazy instantiation used when possible
- [ ] Modal view and handle properly using custom protocols/delegation (1pts)
- [ ] Tested the app running on a device, not the emulator to ensure it runs in all scenarios.
- [ ] Coding Style: Organization, comments, object oriented structures used, proper Objective C or Swift paradigms implemented (2pts)
- [ ]  
