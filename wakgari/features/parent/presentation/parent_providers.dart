// Riverpod wiring for the parent experience.
//
// Links are keyed by the signed-in parent's user id and may hold several
// children. There is deliberately no fallback list: an account with no links
// sees nothing rather than another family's child.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parentlink/features/auth/presentation/auth_controller.dart';
import 'package:parentlink/features/school_data/presentation/school_data_provider.dart';
import 'package:parentlink/features/students/domain/student.dart';
import 'package:parentlink/features/students/presentation/students_provider.dart';

import '../domain/child_overview.dart';
import '../domain/child_records.dart';

/// Injected clock so "today" rules can be tested without wall-clock time.
final nowProvider = Provider<DateTime Function()>((ref) => DateTime.now);

/// Parent user id to the students they are allowed to see.
///
/// Replaces the single-child `linkedChildrenProvider`. The real source in
/// Milestone 2 is the `ParentStudent` table from the REST API; until then the
/// demo parent is linked to two sisters so the child switcher is visible.
final parentChildLinksProvider =
    NotifierProvider<ParentChildLinksController, Map<String, List<String>>>(
      ParentChildLinksController.new,
    );

class ParentChildLinksController extends Notifier<Map<String, List<String>>> {
  @override
  Map<String, List<String>> build() => {
    'parent@parentlink.test': ['s-101', 's-103'],
  };

  void link(String parentId, String studentId) {
    final current = state[parentId] ?? const <String>[];
    if (current.contains(studentId)) return;
    state = {
      ...state,
      parentId: [...current, studentId],
    };
  }

  void unlink(String parentId, String studentId) {
    final current = state[parentId];
    if (current == null) return;
    state = {
      ...state,
      parentId: current.where((id) => id != studentId).toList(),
    };
  }
}

/// The linked children of the signed-in parent, in link order.
///
/// Loading and error states are passed through from `studentsProvider`, and an
/// unlinked account resolves to an empty list, never to sample students.
final parentChildrenProvider = Provider<AsyncValue<List<Student>>>((ref) {
  final user = ref.watch(authControllerProvider).asData?.value;
  final links = ref.watch(parentChildLinksProvider);
  final students = ref.watch(studentsProvider);
  if (user == null) return AsyncValue.data(const <Student>[]);
  final linkedIds = links[user.id] ?? const <String>[];
  if (linkedIds.isEmpty) return AsyncValue.data(const <Student>[]);
  return students.whenData((allStudents) {
    final byId = <String, Student>{
      for (final student in allStudents) student.id: student,
    };
    final linked = <Student>[];
    for (final id in linkedIds) {
      final student = byId[id];
      if (student != null) linked.add(student);
    }
    return linked;
  });
});

/// Behavior notes the parent has marked as read, kept by report id.
final acknowledgedBehaviorProvider =
    NotifierProvider<AcknowledgedBehaviorController, Set<String>>(
      AcknowledgedBehaviorController.new,
    );

class AcknowledgedBehaviorController extends Notifier<Set<String>> {
  @override
  Set<String> build() => const <String>{};

  void acknowledge(String reportId) {
    if (state.contains(reportId)) return;
    state = {...state, reportId};
  }
}

/// Everything recorded about one child, in newest-first order.
final childRecordsProvider = Provider.family<ChildRecords, String>((
  ref,
  studentId,
) {
  final data = ref.watch(schoolDataProvider);
  return ChildRecords.forStudent(data: data, studentId: studentId);
});

/// The aggregates the parent home card and child detail tabs share.
final childOverviewProvider = Provider.family<ChildOverview, String>((
  ref,
  studentId,
) {
  final records = ref.watch(childRecordsProvider(studentId));
  final acknowledged = ref.watch(acknowledgedBehaviorProvider);
  final now = ref.watch(nowProvider)();
  return ChildOverview.build(
    records: records,
    acknowledgedBehaviorIds: acknowledged,
    now: now,
  );
});
