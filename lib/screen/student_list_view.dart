import 'package:flutter/material.dart';
import 'package:student_management/model/student.dart';
import 'package:student_management/service/db_helper.dart';

class StudentListView extends StatefulWidget {
  StudentListView({Key? key}) : super(key: key);

  @override
  State<StudentListView> createState() => _StudentListViewState();
}

class _StudentListViewState extends State<StudentListView> {
  List<Student> studentList = [];

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getData();
  }

  Future<void> getData() async {
    studentList = await DBHelper().getStudents();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: ListView.builder(
          itemCount: studentList.length,
          itemBuilder: (BuildContext context, int index) {
            Student student = studentList[index];

            return ListTile(
                title: Text("아이디 : ${student.id} , 이름 : ${student.name}"));
          },
        ),
        onRefresh: () => getData());
  }
}
