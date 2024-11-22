# Quiz App

A **Flutter-based Quiz Application** designed for competitive exam preparation. This app supports multiple courses like **JEE, NEET, GATE, CGL, SSC, UPSC**, and provides a seamless experience for users to take quizzes, track their performance, and analyze results. Additionally, it features an admin portal for managing quiz content.

---

## Features

### **App Features**
- **Dynamic Courses & Categories**:
  - Courses like JEE, NEET, GATE, SSC, CGL, and UPSC are pre-configured.  
  - Quizzes are categorized for easy access.
  
- **Multimedia Quiz Support**:
  - Questions and MCQs support **images** and **videos** for better interactivity.

- **Real-Time Analytics**:
  - Post-quiz performance analysis using **pie charts**.
  - Detailed **ranking system** to display standings among participants.

- **Timer Functionality**:
  - Quizzes feature countdown timers powered by `slide_countdown`.

- **Offline & Responsive UI**:
  - Smooth animations using **Lottie** and interactive layouts for an engaging user experience.

---

### **Portal Features**
- **Quiz Management**:
  - Upload quizzes via a web-based portal.
  - Attach **images** and multimedia to questions or MCQs.
  
- **State Management**:
  - Efficient use of **BLoC** for dynamic course and quiz handling.

- **Content Organization**:
  - Manage sections and categories for different competitive exams.  

---

## Dependencies Used
This project utilizes the following dependencies:

### Core Functionality
| Dependency               | Version   | Usage                            |
|--------------------------|-----------|----------------------------------|
| `flutter`                | `sdk: flutter` | Base framework for the app.     |
| `firebase_core`          | `^3.1.0`  | Connects app with Firebase.      |
| `firebase_auth`          | `^5.1.0`  | Handles user authentication.     |
| `firebase_storage`       | `^12.0.1` | Uploads quiz-related files/images. |
| `cloud_firestore`        | `^5.0.2`  | Database for storing quiz data.  |
| `firebase_analytics`     | `^11.0.1` | Tracks user behavior.            |

### UI Enhancements
| Dependency               | Version   | Usage                            |
|--------------------------|-----------|----------------------------------|
| `slide_countdown`        | `^1.6.1`  | Displays countdown timer.        |
| `lottie`                 | `^3.1.2`  | Adds animations for UI.          |
| `shimmer`                | `^3.0.0`  | Shimmer effects for placeholders.|
| `video_player`           | `^2.9.1`  | Plays video questions.           |
| `cupertino_icons`        | `^1.0.6`  | iOS-styled icons.                |

### File & Media Management
| Dependency               | Version   | Usage                            |
|--------------------------|-----------|----------------------------------|
| `flutter_filereader`     | `^3.0.0`  | Opens files within the app.      |
| `file_picker`            | `^8.0.6`  | Picks quiz files for upload.     |
| `image_picker`           | `^1.1.2`  | Attaches images to questions.    |

### State Management
| Dependency               | Version   | Usage                            |
|--------------------------|-----------|----------------------------------|
| `bloc`                   | `^8.1.4`  | State management system.         |
| `flutter_bloc`           | `^8.1.6`  | BLoC-specific Flutter integration. |

---

## Functional Workflow

1. **Admin Portal**:
   - Upload quiz files and attach multimedia for questions or options.
   - Organize quizzes into sections or categories like **JEE**, **NEET**, etc.

2. **Quiz Experience**:
   - Users select a course and take quizzes with interactive questions.
   - Multimedia support ensures engaging assessments.

3. **Post-Quiz Analysis**:
   - Displays marks scored by the user.
   - Shows detailed analysis with **charts** and **rankings** among participants.

---

## How to Run

### Prerequisites:
- Flutter SDK installed on your system.
- Firebase project configured for the app.

### Steps:
1. Clone the repository:
   ```bash
   git clone https://github.com/your-repository-link.git
   ```
2. Navigate to the project directory:
   ```bash
   cd quiz-app
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Configure Firebase:
   - Add your `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) files to the project.

5. Run the app:
   ```bash
   flutter run
   ```

---

## Screenshots

- **Home Screen**:
  Displays available courses and categories.  

- **Quiz Screen**:
  Interactive quiz interface with multimedia support.  

- **Result Screen**:
  Shows marks, pie chart analysis, and leaderboard rankings.  

---

## Future Enhancements
- Add **dark mode** for better accessibility.
- Introduce **live quizzes** for real-time competitions.
- Provide **discussion forums** for users to discuss questions.

---

## Author
Built with ❤️ by **Satyam Srivastav**  
GitHub: [github.com/D-extremity](https://github.com/D-extremity)  
Feel free to contribute or report issues!
