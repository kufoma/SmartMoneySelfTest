# SmartMoney SelfTest App - Build & Deployment Guide

## Project Status

✅ **Fully Implemented:**
- Android questionnaire application with 17 financial assessment questions
- RecyclerView-based UI with 4 response options per question (A/B/C/D)
- Scoring system: A=3, B=2, C=1, D=0
- Result screen displaying total score and average
- Interpretation mapping based on score averages

✅ **Source Code Complete:**
- `app/src/main/java/com/smartmoney/selftest/MainActivity.kt` - Main questionnaire activity
- `app/src/main/java/com/smartmoney/selftest/ResultActivity.kt` - Results display
- `app/src/main/java/com/smartmoney/selftest/Question.kt` - Question model
- `app/src/main/java/com/smartmoney/selftest/QuestionAdapter.kt` - RecyclerView adapter
- All required layout and resource files
- `AndroidManifest.xml` with proper activity declarations

✅ **Build Infrastructure:**
- Gradle 9.2.1 wrapper for reproducible builds
- AGP 8.4.0 configured
- Kotlin 1.9.20 plugin pinned
- All required dependencies declared

## Build Instructions

### Local Build (Recommended)
To build the APK on your local machine:

```bash
# Clone the repository
git clone https://github.com/kufoma/SmartMoneySelfTest.git
cd SmartMoneySelfTest

# Build the debug APK
./gradlew :app:assembleDebug
```

**Generated APK Location:**
```
app/build/outputs/apk/debug/app-debug.apk
```

### Build from Feature Branch
```bash
git checkout feature/questionnaire
./gradlew :app:assembleDebug
```

## Environment Requirements

- **Java:** 21 or 23 (Java 25 has compatibility issues with current Kotlin/Gradle ecosystem)
- **Gradle:** 9.2.1 (managed by wrapper)
- **Android SDK:** API level 34 minimum
- **Min SDK:** 21
- **Target SDK:** 34

## Application Features

### Questionnaire Screen
- 17 financial assessment questions
- Each question has 4 labeled response options:
  - A: Very True (score: 3)
  - B: True (score: 2)
  - C: Not Sure (score: 1)
  - D: Not True (score: 0)
- RecyclerView for smooth scrolling
- Submit button to calculate results

### Result Screen
Displays:
- **Total Score:** Sum of all question scores
- **Average Score:** Total / Number of questions
- **Interpretation:** Based on average score:
  - Average ≤ 1.00: "Highly satisfactory: You show strong financial resilience — keep it up and consider sharing your strategies."
  - Average ≤ 2.00: "Satisfactory: You have good habits but there's room to tighten budgeting and planning."
  - Average ≤ 3.00: "Unsatisfactory: Consider reviewing spending, creating a budget, and seeking ways to increase savings."
  - Average > 3.00: "Critical: Immediate action recommended — seek financial advice and create a plan to stabilize your situation."

## Code Structure

```
SmartMoneySelfTest/
├── app/
│   ├── src/main/java/com/smartmoney/selftest/
│   │   ├── MainActivity.kt
│   │   ├── ResultActivity.kt
│   │   ├── Question.kt
│   │   └── QuestionAdapter.kt
│   ├── src/main/res/
│   │   ├── layout/
│   │   │   ├── activity_main.xml
│   │   │   ├── activity_result.xml
│   │   │   └── item_question.xml
│   │   ├── values/
│   │   │   ├── colors.xml
│   │   │   ├── strings.xml
│   │   │   └── themes.xml
│   │   └── mipmap-*/
│   │       └── ic_launcher.xml
│   ├── build.gradle
│   └── AndroidManifest.xml
├── gradle/wrapper/
│   ├── gradle-wrapper.jar
│   └── gradle-wrapper.properties
├── gradlew
├── gradlew.bat
├── settings.gradle
├── build.gradle
└── gradle.properties
```

## Git Branches

- **main:** Original repository state
- **feature/questionnaire:** Complete implementation with all features
  - PR #1: Questionnaire UI and scoring
  - Latest: Gradle wrapper configuration

## Installation & Testing

### Install via ADB (after building)
```bash
adb install app/build/outputs/apk/debug/app-debug.apk
```

### Run in Emulator
```bash
# Build and run directly
./gradlew :app:installDebug

# Or launch in emulator manually after install
adb shell am start -n com.smartmoney.selftest/.MainActivity
```

## Troubleshooting Build Issues

### Issue: "HasConvention" errors with Gradle 9.x + Kotlin 1.9.x
**Solution:** Downgrade to Java 21/23 instead of Java 25, or upgrade to:
- Gradle 10.x (latest)
- Kotlin 2.0.x

### Issue: APK not generated
**Check:**
1. Java version: `java -version`
2. Build output: `./gradlew :app:assembleDebug --info`
3. Gradle version: `./gradlew --version`

### Clean Build
```bash
./gradlew clean :app:assembleDebug
```

## Next Steps

1. **Build locally** on a machine with Java 21/23
2. **Test on Android device or emulator**
3. **Review code** at PR #1: https://github.com/kufoma/SmartMoneySelfTest/pull/1
4. **Merge to main** when ready for production
5. **Configure signing** for Play Store release (not included in this build)

## Notes

- The questionnaire contains 17 financial health assessment questions
- Scoring is automatic and per-question average-based
- All UI is responsive and uses AndroidX libraries
- ViewBinding is enabled for type-safe view references
- No external dependencies beyond AndroidX and Material Design

For questions or issues, review the git log and commit messages for implementation details.
