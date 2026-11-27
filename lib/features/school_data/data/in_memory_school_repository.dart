import '../domain/school_record.dart';
import '../domain/school_repository.dart';

class InMemorySchoolRepository implements SchoolRepository {
  @override
  SchoolData loadInitialData() {
    final now = DateTime.now();
    return SchoolData(
      attendance: [
        AttendanceRecord(
          id: 'a1',
          studentId: 's-101',
          date: now,
          status: AttendanceStatus.present,
          recordedBy: 'Ms. Selam',
        ),
        AttendanceRecord(
          id: 'a2',
          studentId: 's-102',
          date: now,
          status: AttendanceStatus.late,
          recordedBy: 'Ms. Selam',
        ),
        AttendanceRecord(
          id: 'a3',
          studentId: 's-103',
          date: now,
          status: AttendanceStatus.absent,
          recordedBy: 'Mr. Dawit',
        ),
        AttendanceRecord(
          id: 'a4',
          studentId: 's-104',
          date: now,
          status: AttendanceStatus.present,
          recordedBy: 'Ms. Selam',
        ),
        AttendanceRecord(
          id: 'a5',
          studentId: 's-101',
          date: now.subtract(const Duration(days: 1)),
          status: AttendanceStatus.present,
          recordedBy: 'Ms. Selam',
        ),
        AttendanceRecord(
          id: 'a6',
          studentId: 's-102',
          date: now.subtract(const Duration(days: 1)),
          status: AttendanceStatus.present,
          recordedBy: 'Ms. Selam',
        ),
      ],
      grades: [
        GradeRecord(
          id: 'g1',
          studentId: 's-101',
          subject: 'Mathematics',
          score: 88,
          term: 'Term 1',
          date: now.subtract(const Duration(days: 4)),
          recordedBy: 'Ms. Selam',
        ),
        GradeRecord(
          id: 'g2',
          studentId: 's-101',
          subject: 'English',
          score: 94,
          term: 'Term 1',
          date: now.subtract(const Duration(days: 3)),
          recordedBy: 'Mr. Dawit',
        ),
        GradeRecord(
          id: 'g3',
          studentId: 's-101',
          subject: 'Biology',
          score: 79,
          term: 'Term 1',
          date: now.subtract(const Duration(days: 2)),
          recordedBy: 'Ms. Selam',
        ),
        GradeRecord(
          id: 'g4',
          studentId: 's-102',
          subject: 'Mathematics',
          score: 82,
          term: 'Term 1',
          date: now.subtract(const Duration(days: 4)),
          recordedBy: 'Ms. Selam',
        ),
        GradeRecord(
          id: 'g5',
          studentId: 's-103',
          subject: 'English',
          score: 91,
          term: 'Term 1',
          date: now.subtract(const Duration(days: 3)),
          recordedBy: 'Mr. Dawit',
        ),
      ],
      behaviorReports: [
        BehaviorReport(
          id: 'b1',
          studentId: 's-101',
          description: 'Helped a classmate during group work.',
          severity: BehaviorSeverity.low,
          status: 'Positive note',
          date: now.subtract(const Duration(days: 1)),
          reportedBy: 'Ms. Selam',
        ),
        BehaviorReport(
          id: 'b2',
          studentId: 's-102',
          description: 'Needs a reminder to bring the science notebook.',
          severity: BehaviorSeverity.low,
          status: 'Follow-up',
          date: now.subtract(const Duration(days: 2)),
          reportedBy: 'Mr. Dawit',
        ),
      ],
      checkInOut: [
        CheckInOutRecord(
          id: 'c1',
          studentId: 's-101',
          checkedIn: true,
          time: now.copyWith(hour: 7, minute: 42),
          recordedBy: 'Gate staff',
        ),
        CheckInOutRecord(
          id: 'c2',
          studentId: 's-101',
          checkedIn: false,
          time: now
              .subtract(const Duration(days: 1))
              .copyWith(hour: 15, minute: 20),
          recordedBy: 'Gate staff',
        ),
        CheckInOutRecord(
          id: 'c3',
          studentId: 's-102',
          checkedIn: true,
          time: now.copyWith(hour: 8, minute: 4),
          recordedBy: 'Gate staff',
        ),
      ],
      announcements: [
        SchoolAnnouncement(
          id: 'n1',
          title: 'Family science afternoon',
          message:
              'Join us in the school hall on Thursday at 14:00 for student demonstrations.',
          kind: 'Event',
          date: now.add(const Duration(days: 2)),
          createdBy: 'School office',
        ),
        SchoolAnnouncement(
          id: 'n2',
          title: 'Term assessments',
          message:
              'Assessment week begins next Monday. Please check the schedule for subject dates.',
          kind: 'Schedule change',
          date: now.add(const Duration(days: 5)),
          createdBy: 'Principal',
        ),
      ],
      schedule: [
        ScheduleItem(
          id: 'sc1',
          title: 'Term 1 assessments',
          startDate: now.add(const Duration(days: 5)),
          endDate: now.add(const Duration(days: 10)),
          description: 'Bring the required materials for each subject.',
        ),
        ScheduleItem(
          id: 'sc2',
          title: 'Family science afternoon',
          startDate: now.add(const Duration(days: 2)),
          endDate: now.add(const Duration(days: 2)),
          description: 'Student demonstrations in the main hall.',
        ),
      ],
      messages: [
        ChatMessage(
          id: 'm1',
          threadId: 's-101',
          sender: 'You',
          text: 'Good morning, how is Mimi settling into the new term?',
          sentAt: now.subtract(const Duration(days: 1, hours: 2)),
        ),
        ChatMessage(
          id: 'm2',
          threadId: 's-101',
          sender: 'Ms. Selam',
          text: 'She is doing well and has been participating confidently.',
          sentAt: now.subtract(const Duration(days: 1, hours: 1)),
        ),
        ChatMessage(
          id: 'm3',
          threadId: 's-102',
          sender: 'Mr. Dawit',
          text: 'Could Hana bring her science notebook tomorrow?',
          sentAt: now.subtract(const Duration(hours: 4)),
        ),
      ],
    );
  }
}
