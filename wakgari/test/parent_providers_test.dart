import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parentlink/features/auth/presentation/auth_controller.dart';
import 'package:parentlink/features/students/presentation/students_provider.dart';

import '../features/parent/presentation/parent_providers.dart';

ProviderContainer _container() {
  final container = ProviderContainer();
  addTearDown(container.dispose);
  return container;
}

Future<void> _signIn(ProviderContainer container, String email) => container
    .read(authControllerProvider.notifier)
    .signIn(email: email, password: 'demo');

void main() {
  test('a parent only gets the children linked to their account', () async {
    final container = _container();
    await _signIn(container, 'parent@parentlink.test');
    await container.read(studentsProvider.future);

    final children = container.read(parentChildrenProvider).requireValue;

    expect(children.map((student) => student.id), ['s-101', 's-103']);
    expect(children.map((student) => student.name), [
      'Mimi Bekele',
      'Liya Abebe',
    ]);
  });

  test('an unlinked parent gets no children instead of samples', () async {
    final container = _container();
    await _signIn(container, 'other.parent@parentlink.test');
    await container.read(studentsProvider.future);

    expect(container.read(parentChildrenProvider).requireValue, isEmpty);
  });

  test('a signed-out visitor gets no children', () async {
    final container = _container();
    await container.read(studentsProvider.future);

    expect(container.read(parentChildrenProvider).requireValue, isEmpty);
  });

  test('linking a child makes it visible to that parent only', () async {
    final container = _container();
    await _signIn(container, 'other.parent@parentlink.test');
    await container.read(studentsProvider.future);

    container
        .read(parentChildLinksProvider.notifier)
        .link('other.parent@parentlink.test', 's-102');

    expect(
      container
          .read(parentChildrenProvider)
          .requireValue
          .map((student) => student.id),
      ['s-102'],
    );

    container
        .read(parentChildLinksProvider.notifier)
        .unlink('other.parent@parentlink.test', 's-102');

    expect(container.read(parentChildrenProvider).requireValue, isEmpty);
  });

  test('acknowledging a note is idempotent', () {
    final container = _container();
    final notifier = container.read(acknowledgedBehaviorProvider.notifier);

    notifier.acknowledge('b1');
    notifier.acknowledge('b1');

    expect(container.read(acknowledgedBehaviorProvider), {'b1'});
  });
}
