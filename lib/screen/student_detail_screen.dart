import 'package:flutter/material.dart';
import 'package:student_management/model/student.dart';
import 'package:student_management/screen/student_add_view.dart';

class StudentDetailScreen extends StatefulWidget {
  final Student student;
  const StudentDetailScreen({Key? key, required this.student})
      : super(key: key);

  @override
  State<StudentDetailScreen> createState() => _StudentDetailScreenState();
}

class _StudentDetailScreenState extends State<StudentDetailScreen> {
  late Student student;
  @override
  void initState() {
    super.initState();
    student = widget.student;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Student View")),
        body: StudentAddView(
          isEditMode: true,
          student: widget.student,
        ));
  }
}
