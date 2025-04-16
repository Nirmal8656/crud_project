import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user.dart';
import '../providers/user_provider.dart';

class UserFormScreen extends ConsumerStatefulWidget {
  final User? user;

  const UserFormScreen({super.key, this.user});

  @override
  ConsumerState<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends ConsumerState<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user?.name ?? '');
    _emailController = TextEditingController(text: widget.user?.email ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.user != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit User' : 'Add User')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (val) => val!.isEmpty ? 'Enter a name' : null,
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (val) => val!.isEmpty ? 'Enter an email' : null,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final name = _nameController.text;
                  final email = _emailController.text;

                  if (isEditing) {
                    final updatedUser = User(
                      id: widget.user!.id,
                      name: name,
                      email: email,
                    );
                    ref.read(usersProvider.notifier).updateUser(updatedUser);
                  } else {
                    ref.read(usersProvider.notifier).addUser(name, email);
                  }

                  Navigator.pop(context);
                }
              },
              child: Text(isEditing ? 'Update' : 'Create'),
            )
          ]),
        ),
      ),
    );
  }
}
