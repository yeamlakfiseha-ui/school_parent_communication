abstract final class AppRoutes {
  static const login = '/login';
  static const parentHome = '/parent/home';
  static const childDetail = '/parent/child/:studentId';
  static const termSummary = '/parent/child/:studentId/summary';
  static const announcements = '/parent/announcements';
  static const parentMessages = '/parent/messages';
  static const teacherHome = '/teacher/home';
  static const qrScanner = '/teacher/qr-scanner';
  static const reportEntry = '/teacher/report-entry';
  static const teacherMessages = '/teacher/messages';
  static const leaderHome = '/leader/home';
  static const postAnnouncement = '/leader/announcements';
  static const schoolOverview = '/leader/overview';
  static const adminHome = '/admin/home';
  static const manageUsers = '/admin/users';

  static String homeForRole(String role) => switch (role) {
        'teacher' => teacherHome,
        'schoolLeader' => leaderHome,
        'appAdmin' => adminHome,
        _ => parentHome,
      };
}
