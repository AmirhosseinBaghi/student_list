import 'package:flutter/material.dart';
import 'package:student_list/models/user.dart';

class UserEditScreen extends StatefulWidget {
  final User? user;
  const UserEditScreen({super.key, this.user});

  @override
  State<UserEditScreen> createState() => _UserEditScreenState();
}

class _UserEditScreenState extends State<UserEditScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _nameControler = TextEditingController();
  final TextEditingController _cityControler = TextEditingController();
  bool isLoading = false;

  void onSaved() {}

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _nameControler.text = widget.user!.name;
      _cityControler.text = widget.user!.city;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user == null ? "Add student" : "Edit User"),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Form(
            key: formKey,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _nameControler,
                  decoration: InputDecoration(
                    label: Text('Student name'),
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter a name";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _cityControler,
                  decoration: InputDecoration(
                    label: Text('City'),
                    prefixIcon: Icon(Icons.location_city_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter a city";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => onSaved(),
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: isLoading ? null : onSaved,
                  child:
                      isLoading
                          ? SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(),
                          )
                          : Text(
                            widget.user == null
                                ? 'add Student'
                                : 'Update Information',
                          ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
