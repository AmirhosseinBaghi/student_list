import 'package:flutter/material.dart';
import 'package:student_list/models/user.dart';

class StudentListItem extends StatelessWidget {
  final User user;
  final VoidCallback onTap;
  final VoidCallback onDismissed;
  const StudentListItem({
    super.key,
    required this.user,
    required this.onTap,
    required this.onDismissed,
  });
  Color _getColorAvatar(String id) {
    final colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.indigo,
      Colors.amber,
      Colors.cyan,
    ];

    final hash = user.id.hashCode;
    final index = hash % colors.length;
    return colors[index];
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(user.id),
      background: Container(
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.red[400],
        ),
        child: Icon(Icons.delete_sweep, size: 30),
      ),
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Confirm Deletion'),
              content: Text('Are you sure you want to delete ${user.name}?'),
            );
          },
        );
      },
      onDismissed: (direction) => onDismissed,
      child: Card(
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: _getColorAvatar(user.id),
            child: Text(
              user.name.isNotEmpty ? user.name[0].toUpperCase() : '',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(user.name, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(
            user.city,
            style: TextStyle(color: Colors.grey.shade400),
          ),
          onTap: onTap,
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
