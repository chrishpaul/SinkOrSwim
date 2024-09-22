A simple application to help students study Mandarin vocabulary words.

Lab 1 Tracking Items:
- [x] Automatic Layout 
- [x] Buttons (Quiz view)
- [x] Sliders
- [x] Labels (Quiz view, Word Review view)
- [x] Stepper (Word Review)
- [x] Switch (Timed mode on Quiz view)
- [x] Picker (you must implement picker delegate) (Quiz)
- [x] Segmented Control (Word Review)
- [x] Timer (which should repeat and somehow update the UIView) (Quiz) (0.5pts)
- [x] ScrollView (with scrollable, zoomable content) (Picture Review)
- [x] Image View (Word Review, Picture Dictionary, Picture Review)
- [x] Navigation Controller. Proper navigation (1pt)
- [x] Collection View Controller (Picture Dictionary)
- [x] Table View Controller with three different dynamic prototype cells (Not hardcoded)
- [x]   Type 1: English to Mandarin Word Cell
- [x]   Type 2: User Logo cell
- [x]   Type 3: Pinyin and picture cells
- [x] The design should work in both portrait and landscape mode. Use size classes if necessary. (2 pts)
- [x] Tested for crashing
- [x] Strictly adheres to Model View Controller programming practices. View should be agnostic to controller. Model should be agnostic to everything. (1pts)
- [x] Lazy instantiation used when possible
- [x] Modal view and handle properly using custom protocols/delegation (1pts)
- [x] Tested the app running on a device, not the emulator to ensure it runs in all scenarios.
- [x] Coding Style: Organization, comments, object oriented structures used, proper Objective C or Swift paradigms implemented (2pts)

Mandarin Tutor : UITableViewController with 3 cell types
  1) User Profile Cell -> dynamically loaded from user file. Clicking navigates modally to user selection view.
  2) Mandarin words with English translation -> clicking navigates to 'WordView'
  3) Quiz cell -> clicking navigates to 'Quiz'
  4) Picture Dictionary cell -> clicking navigates to 'PictureDict'
  5) Pinyin and Picture cells -> dynamically loaded from lesson file. 
WordView : UIViewController
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
