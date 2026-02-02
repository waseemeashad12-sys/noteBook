import 'package:flutter/material.dart';
import 'package:notebook/Services/database_service.dart';
import 'package:notebook/app_lang.dart';
class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  List<Map<String, dynamic>> users = [];

  Future<void> loadUsers() async {
    final db = await DatabaseService.database;
    final data = await db.query('users');

    setState(() {
      users = data;
    });
  }

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المستخدمون'),
        backgroundColor: Colors.blue,
      ),
      body: users.isEmpty
          ? const Center(child: Text("لا يوجد مستخدمون"))
          : ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            leading: const Icon(Icons.person),
            title: Text(user['name'] ?? ''),
            subtitle: Text(user['email'] ?? ''),
          );
        },
      ),
    );
  }
}
