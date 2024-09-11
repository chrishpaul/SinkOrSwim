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
 

Project Requirements:

- Automatic Layout 
- Buttons, Sliders, and Labels
- Stepper and Switch
- Picker (you must implement picker delegate)
- Segmented Control
- Timer (which should repeat and somehow update the UIView)
- ScrollView (with scrollable, zoomable content)
- Image View
- Navigation Controller
- Collection View Controller
- Table View Controller with three different dynamic prototype cells
- The design should work in both portrait and landscape mode
- I should not be able to crash your app
- Your design must strictly adhere to Model View Controller programming practices
- Use lazy instantiation when possible
- Exceptional Credit for 5000 students and for 7000 students:
- Implement a modal view and handle properly using custom protocols/delegation
- Test your app running on the device, not the emulator to ensure it runs in all scenarios. Also see the grading rubric for how much each element is worth. 
