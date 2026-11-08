# ParentLink: School-Parent Communication App for Nativity Girls School (NGS)

## 1. Title and one-sentence description

**ParentLink** is an app that helps parents, teachers and administrators at Nativity Girls School (NGS) to share attendance, grades, behavior reports, check-in and check-out times, announcements and the school year schedule, and to message each other, so that parents stay informed about their child without depending on lost letters and scattered channels.

## 2. Group

| Name | Role |
|---|---|
| Wakgari Eshetu | Team lead, Firebase Authentication, Firestore (messaging and announcements), push notifications and local database |
| Yeamlak Fiseha | UI/UX, parent, teacher and administrator screens |
| Tamirat Petros | REST API backend (attendance, grades, behavior, check-in/out, student information, user management) and hosting |
| Surafel Kassa | QR scanning, AI summary, testing and quality assurance |

## 3. The problem

Parents of SIS students, their teachers and the school administrators depend on communication that is fragmented today. The school uses emails and phone calls, letters sent home with students, meetings, social media (Facebook, Instagram, YouTube and Telegram), a general website, and Google Classroom, which gives parents limited access. Parents report missed or lost letters and must check several places for news, and administrators cannot be sure a notice reached every family.

In our parent and teacher surveys, parents preferred mobile app notifications over a website, because a website needs a steady internet connection. Teachers named delayed responses and limited access to student information as their main challenges.

ParentLink brings these channels into one app. A parent sees each child's attendance, grades, behavior reports, check-in and check-out times, and the school's announcements and schedule in one place. A teacher records attendance, grades and behavior reports in the same app, so parents see them the same day, and either side can send a message instead of a letter or a call. The principal posts announcements and the school year schedule once, and every parent gets a push notification. A mobile app fits better than the web version because the phone is always with parents: it delivers notifications immediately, scans QR codes with its camera, and keeps recent records available offline. We will reuse the REST API of our earlier web prototype (Node.js, Express and MySQL) as the app's data source.

## 4. Users

- **Parent.** Has one or more children at SIS and wants to follow each without visiting the school. Needs attendance, grades, behavior reports, check-in/out times, announcements, the school schedule and messaging with teachers. Opens the app every day or two, more often at exam time.
- **Teacher.** Teaches one or more classes. Needs to mark attendance, record grades, file behavior reports, scan check-in/out and answer parents' messages. Uses the app every school day.
- **School leader** (principal or school admin). Needs a school-wide view: all students' data, and reports by grade, section and teacher to compare how each teacher's students are doing. Posts announcements and the school year schedule. Uses the app a few times a week.
- **App administrator.** Someone with technical knowledge of the app, since the principal will not have it. Adds and removes teachers, students and parents (one by one or from a CSV file), links parents to children, keeps the data up to date and watches crash reports. Uses the app a few times a week, daily at the start of a term.

## 5. User stories

1. As a parent, I want to log in and see my children's attendance, grades and behavior reports so that I know how each child is doing without visiting the school. (must)
2. As a teacher, I want to record daily attendance, grades and behavior reports for my class so that parents receive accurate, timely information. (must)
3. As a parent, I want to message my child's teacher so that I can ask questions without a phone call. (must)
4. As a school leader, I want to post announcements and the school year schedule so that every parent is notified on their phone and can find important dates in one place. (should)
5. As a school leader, I want to see all students' data and total reports by grade and section so that I can tell which teachers' students are doing better and where support is needed. (should)
6. As an app administrator, I want to add and remove teachers, students and parents (one by one or by importing a CSV file), and link parents to their children, so that the data stays up to date and each parent sees only their own children's data. (should)
7. As a teacher or staff member, I want to scan a student's QR code at check-in and check-out so that parents can see when their child arrived and left. (should)
8. As a parent, I want a short plain-language summary of my child's term so that I understand the numbers at a glance. (should)

## 6. Screens

| Screen | Purpose | Stories |
|---|---|---|
| Login | Sign in with email and password | all |
| Parent home | The parent's children | 1 |
| Child detail | Tabs: attendance, grades, behavior, check-in/out | 1, 7 |
| Term summary | AI summary of one child's term | 8 |
| Announcements and schedule | Notices and the school year schedule | 4 |
| Messages | Thread list and chat | 3 |
| Teacher home | Class list, mark Present, Absent or Late | 2, 7 |
| QR scanner | Camera check-in or check-out | 7 |
| Add grade / behavior report | Forms for a grade or an incident | 2 |
| Post announcement / schedule | School leader sends a notice or schedule entry | 4 |
| School overview | Reports by grade, section and teacher | 5 |
| Manage users | Add or remove users, CSV import, link parents | 6 |

Sketches of the four most important screens (login, child detail, mark attendance, chat) are in `docs/sketches/`:

| Login | Child detail | Mark attendance | Chat |
|---|---|---|---|
| ![Login](docs/sketches/login.png) | ![Child detail](docs/sketches/child-detail.png) | ![Mark attendance](docs/sketches/mark-attendance.png) | ![Chat](docs/sketches/chat.png) |

## 7. Data model

- **User:** id (Firebase uid), name, email, phone, role (Parent, Teacher, SchoolLeader, AppAdmin)
- **Student:** id, name, grade, section
- **ParentStudent:** parentId, studentId
- **TeacherClass:** teacherId, grade, section, subject
- **Attendance:** id, studentId, date, status (Present, Absent, Late), recordedBy
- **Grade:** id, studentId, subject, score, term, recordedBy
- **BehaviorReport:** id, studentId, description, severity, status, reportedBy, createdAt
- **CheckInOut:** id, studentId, type (In, Out), timestamp, recordedBy
- **Announcement:** id, title, message, kind (Meeting, Event, Schedule change), date, createdBy
- **SchoolSchedule:** id, schoolYear, title, startDate, endDate, description, createdBy
- **Message:** id, senderId, receiverId, content, isRead, createdAt
- **TermSummary:** studentId, term, text, createdAt

A parent has many children through ParentStudent. Attendance, Grade, BehaviorReport and CheckInOut belong to one Student and name the User who recorded them. Reports by grade, section and teacher are calculated from Grade, Attendance and TeacherClass, not stored.

## 8. Data sources

The app is built with Flutter (Dart), Android first, using `firebase_auth`, `cloud_firestore`, `firebase_messaging`, `firebase_crashlytics`, `drift`, `shared_preferences`, `mobile_scanner` and `http`. Data comes from three places:

- **Local persistence.** `drift` (SQLite) caches each child's records and term summary for offline reading and holds attendance marks and scans made offline until they can be sent. `shared_preferences` stores the selected child, theme and last role.
- **REST web service (one we built).** Our Express and MySQL API serves students, attendance, grades, behavior reports, check-in/out records and user management, calculates reports by grade, section and teacher, and has a new endpoint for the AI summary. It verifies the Firebase ID token on every request.
- **Firebase.** Auth handles sign-in, and the app administrator's screen creates and removes accounts through our API. Firestore stores messages, announcements and the school schedule so they update in real time. Cloud Messaging sends push notifications. The user's role is checked by both the app and the API.

## 9. Device feature and AI feature

**Device feature: camera (story 7).** A teacher or staff member scans the QR code on a student's ID card to record check-in or check-out. The record (time and staff name) appears on the child's detail screen for the parent. If a code is unreadable, the staff member picks the student from a list. The app asks only for the **camera** permission, when the scanner is first opened, and does not save photos or video.

**AI feature: term summary (story 8).** The parent taps “Summarize” and receives a short plain-language paragraph on one child's term: attendance, strongest and weakest subjects, and any behavior concerns. The app calls our backend, which sends the student's attendance counts, subject scores and behavior descriptions, without name or ID, to a hosted language model API (Claude or Gemini). The API key stays on the server, and each summary is saved on the phone so it is not requested again. It is labeled as AI-generated and does not replace the school's official reports.

## 10. Risks

| Risk | Likelihood | Plan |
|---|---|---|
| Exams, and too many features for four people in 14 weeks | High | Build in priority order, stories 1 to 3 first; if we fall behind, school reports (story 5) and the AI summary (story 8) are dropped first |
| Our REST API has no public hosting, so the app cannot reach it | Medium | Deploy to a free hosting tier before Milestone 2; keep a local copy for demos |
| The AI API costs money or is unavailable | Medium | Use a free tier and cache each summary; if the call fails, show a template-based summary built from the same numbers |
| Student data is exposed or mixed up between parents | Medium | Check role and parent-student link on the server for every request; use only made-up test data |
| The app fails on real phones: notifications are not delivered, or crashes go unnoticed | Medium | Test on real Android phones (iOS is a stretch goal because it needs a Mac and a paid Apple Developer account); list every announcement inside the app; use Firebase Crashlytics so crashes are reported to the app administrator and developers |

## 11. Milestone plan

- **Milestone 1 (week 6):** All 12 screens with navigation and in-memory state, using made-up data. Stories 1 to 8 can be walked through in the UI. Firebase project and REST API running.
- **Milestone 2 (week 10):** Real data. Stories 1 to 4 and 7 complete: Firebase Auth login, records from the REST API, Firestore chat, announcements and the schedule with push notifications, QR scanning, and `drift` caching. Accounts are created by script until story 6 is finished.
- **Final submission (week 14):** Stories 5, 6 and 8 complete (school reports, user management and AI summary). Offline queue, Crashlytics, error handling, tests, README and demo.

## 12. AI-use plan

We plan to use Claude for learning Flutter, Firebase and `drift`, generating boilerplate, reviewing code and suggesting test cases. We used Claude to help draft and edit this proposal. We will not submit AI-generated code we cannot explain, we will note significant AI use in pull requests, and we will follow `../syllabus/policies.md`.
