import 'package:flutter/material.dart';
import 'package:student_management/screen/student_add_view.dart';
import 'package:student_management/screen/student_list_view.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({Key? key}) : super(key: key);

  @override
  State<StudentHomeScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentHomeScreen> {
  int _selectedIndex = 0;

  List<Widget> studentViewList = [StudentAddView(), StudentListView()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Text("Student List"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.manage_accounts), label: "Add Student"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Student List")
        ],
      ),
      body: studentViewList[_selectedIndex],
    );
  }
}
