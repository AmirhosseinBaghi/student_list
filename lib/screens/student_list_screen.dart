import 'package:flutter/material.dart';
import 'package:student_list/models/user.dart';
import 'package:student_list/screens/user_edit_screen.dart';
import 'package:student_list/services/api_service.dart';
import 'package:student_list/widgets/student_list_item.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  final ApiService apiService = ApiService();
  List<User> users = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  Future<void> loadUsers() async {
    if (!mounted) return;

    setState(() {
      isLoading = true;
    });

    try {
      users = await apiService.getUsers();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("error fetching data: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _navigateAndRefresh(Widget screen) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
    if (result == true) {
      loadUsers();
    }
  }

  Future<void> deleteUser(String id) async {
    if (!mounted) return;
    try {
      await apiService.deleteUser(id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Delete User Successfully"),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("error Delete User: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double bottomPading = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      floatingActionButton: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: FloatingActionButton.extended(
            onPressed: () {
              _navigateAndRefresh(UserEditScreen());
            },
            icon: Icon(Icons.add),
            label: Text('add Student'),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : users.isEmpty
              ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_rounded, size: 80, color: Colors.grey[500]),
                  SizedBox(height: 16),
                  Text(
                    'No User Found',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Tap the + button to add Student',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ],
              )
              : RefreshIndicator(
                onRefresh: loadUsers,

                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      title: Text('Student List'),
                      floating: true,
                      pinned: false,
                      snap: true,
                    ),
                    SliverPadding(
                      padding: EdgeInsets.only(bottom: bottomPading + 100),

                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final user = users[index];
                          return StudentListItem(
                            user: user,
                            onTap: () {
                              _navigateAndRefresh(UserEditScreen(user: user));
                            },
                            onDismissed: () {
                              deleteUser(user.id);
                            },
                          );
                        }, childCount: users.length),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
