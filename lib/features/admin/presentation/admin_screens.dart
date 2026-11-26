import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../core/widgets/parent_link_widgets.dart';
import '../../auth/domain/user.dart';
import '../../school_data/data/in_memory_school_repository.dart';
import '../../users/presentation/users_provider.dart';

class AdminHomeScreen extends ConsumerWidget {
  const AdminHomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(usersProvider);
    return ListView(
      children: [
        const PageIntro(
          eyebrow: 'App administration',
          title: 'Workspace status',
          subtitle: 'Manage demo accounts and keep school records organized.',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Expanded(
                child: StatTile(
                  label: 'Accounts',
                  value: '${users.length}',
                  icon: Icons.people_outline,
                ),
              ),
              Expanded(
                child: StatTile(
                  label: 'Students',
                  value: '${demoStudents.length}',
                  icon: Icons.school_outlined,
                ),
              ),
            ],
          ),
        ),
        Card(
          margin: const EdgeInsets.all(16),
          child: ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.manage_accounts_outlined),
            ),
            title: const Text('User directory'),
            subtitle: const Text('Add, remove, and link demo school accounts.'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.go(AppRoutes.manageUsers),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: Text(
            'Sample data only · Account changes are held in memory for this milestone.',
          ),
        ),
      ],
    );
  }
}

class ManageUsersScreen extends ConsumerStatefulWidget {
  const ManageUsersScreen({super.key});
  @override
  ConsumerState<ManageUsersScreen> createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends ConsumerState<ManageUsersScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _csv = TextEditingController();
  var _role = UserRole.parent;
  var _linkedStudent = demoStudents.first.id;
  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _csv.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(usersProvider);
    final linkedChildren = ref.watch(linkedChildrenProvider);
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        const PageIntro(
          eyebrow: 'Accounts',
          title: 'Manage users',
          subtitle: 'Maintain access for families and school staff.',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Card(
            child: ExpansionTile(
              title: const Text(
                'Add a user',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              leading: const Icon(Icons.person_add_alt_1),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
                  child: Column(
                    children: [
                      TextField(
                        controller: _name,
                        decoration: const InputDecoration(
                          labelText: 'Full name',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Card(
                          child: ExpansionTile(
                            leading: const Icon(Icons.upload_file_outlined),
                            title: const Text(
                              'Import CSV text',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            subtitle: const Text(
                              'Paste name,email,role,studentId rows',
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  16,
                                  0,
                                  16,
                                  18,
                                ),
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: _csv,
                                      minLines: 3,
                                      maxLines: 6,
                                      decoration: const InputDecoration(
                                        labelText: 'CSV rows',
                                        hintText:
                                            'Name,Email,Role,Student ID\nAster Bekele,aster@example.test,parent,s-101',
                                        alignLabelWithHint: true,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    SizedBox(
                                      width: double.infinity,
                                      child: OutlinedButton.icon(
                                        onPressed: _importCsv,
                                        icon: const Icon(
                                          Icons.file_download_outlined,
                                        ),
                                        label: const Text('Import rows'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email address',
                        ),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<UserRole>(
                        initialValue: _role,
                        decoration: const InputDecoration(labelText: 'Role'),
                        items: [
                          for (final role in UserRole.values)
                            DropdownMenuItem(
                              value: role,
                              child: Text(_roleLabel(role)),
                            ),
                        ],
                        onChanged: (value) {
                          if (value != null) setState(() => _role = value);
                        },
                      ),
                      if (_role == UserRole.parent) ...[
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          initialValue: _linkedStudent,
                          decoration: const InputDecoration(
                            labelText: 'Link to child',
                          ),
                          items: [
                            for (final student in demoStudents)
                              DropdownMenuItem(
                                value: student.id,
                                child: Text(student.name),
                              ),
                          ],
                          onChanged: (value) {
                            if (value != null)
                              setState(() => _linkedStudent = value);
                          },
                        ),
                      ],
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: _addUser,
                          icon: const Icon(Icons.add),
                          label: const Text('Add account'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SectionHeading('School accounts'),
        for (final user in users)
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: ListTile(
              leading: CircleAvatar(child: Icon(_roleIcon(user.role))),
              title: Text(user.name),
              subtitle: Text(
                '${user.email}\n${_roleLabel(user.role)}${user.role == UserRole.parent ? ' · ${_linkedStudentName(linkedChildren[user.id])}' : ''}',
              ),
              isThreeLine: true,
              trailing: IconButton(
                tooltip: 'Remove ${user.name}',
                onPressed: () =>
                    ref.read(usersProvider.notifier).remove(user.id),
                icon: const Icon(Icons.delete_outline),
              ),
            ),
          ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 14, 20, 8),
          child: Text(
            'Sample account changes are held in memory. CSV import here accepts simple comma-separated rows without quoted commas.',
          ),
        ),
      ],
    );
  }

  void _addUser() {
    if (_name.text.trim().isEmpty || !_email.text.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a name and valid email address.')),
      );
      return;
    }
    final id = ref
        .read(usersProvider.notifier)
        .add(name: _name.text.trim(), email: _email.text.trim(), role: _role);
    if (_role == UserRole.parent)
      ref.read(linkedChildrenProvider.notifier).link(id, _linkedStudent);
    _name.clear();
    _email.clear();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Demo account added.')));
  }

  void _importCsv() {
    final lines = _csv.text.trim().split(RegExp(r'\r?\n'));
    var imported = 0;
    for (var index = 0; index < lines.length; index++) {
      final columns = lines[index]
          .split(',')
          .map((item) => item.trim())
          .toList();
      if (columns.length < 3 || columns[0].toLowerCase() == 'name') continue;
      final roleName = columns[2].toLowerCase().replaceAll(' ', '');
      final role = switch (roleName) {
        'parent' => UserRole.parent,
        'teacher' => UserRole.teacher,
        'schoolleader' || 'leader' => UserRole.schoolLeader,
        'appadmin' || 'admin' => UserRole.appAdmin,
        _ => null,
      };
      if (columns[0].isEmpty || !columns[1].contains('@') || role == null)
        continue;
      final id = ref
          .read(usersProvider.notifier)
          .add(name: columns[0], email: columns[1], role: role);
      if (role == UserRole.parent) {
        final requestedChild = columns.length > 3 ? columns[3] : '';
        final studentId =
            demoStudents.any((student) => student.id == requestedChild)
            ? requestedChild
            : demoStudents.first.id;
        ref.read(linkedChildrenProvider.notifier).link(id, studentId);
      }
      imported++;
    }
    _csv.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          imported == 0
              ? 'No valid rows found.'
              : 'Imported $imported demo account(s).',
        ),
      ),
    );
  }
}

String _roleLabel(UserRole role) => switch (role) {
  UserRole.parent => 'Parent',
  UserRole.teacher => 'Teacher',
  UserRole.schoolLeader => 'School leader',
  UserRole.appAdmin => 'App administrator',
};
IconData _roleIcon(UserRole role) => switch (role) {
  UserRole.parent => Icons.family_restroom,
  UserRole.teacher => Icons.cast_for_education,
  UserRole.schoolLeader => Icons.account_balance,
  UserRole.appAdmin => Icons.admin_panel_settings_outlined,
};
String _linkedStudentName(String? id) =>
    demoStudents
        .where((student) => student.id == id)
        .map((student) => 'Linked to ${student.name}')
        .firstOrNull ??
    'No child linked';
