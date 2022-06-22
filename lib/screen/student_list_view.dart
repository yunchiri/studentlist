import 'package:flutter/material.dart';
import 'package:student_management/model/student.dart';
import 'package:student_management/screen/student_detail_screen.dart';
import 'package:student_management/service/db_helper.dart';

class StudentListView extends StatefulWidget {
  const StudentListView({Key? key}) : super(key: key);

  @override
  State<StudentListView> createState() => _StudentListViewState();
}

class _StudentListViewState extends State<StudentListView> {
  List<Student> studentList = [];

  @override
  void initState() {
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
        onRefresh: () => getData(),
        child: Container(
            margin: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            child: DataTable(
                columns: const [
                  // DataColumn(
                  //   label: Text('ID'),
                  // ),
                  DataColumn(
                    label: Text('NAME'),
                  ),
                  DataColumn(
                    label: Text('VIEW'),
                  ),
                ],
                rows: List.generate(
                    studentList.length,
                    (index) => DataRow(cells: [
                          // DataCell(Text(studentList[index].id!.toString())),
                          DataCell(Text(studentList[index].name)),
                          DataCell(
                            TextButton(
                              child: const Icon(
                                Icons.chevron_right,
                                color: Colors.black,
                              ),
                              onPressed: () async {
                                bool? isModified = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        fullscreenDialog: true,
                                        builder: (context) =>
                                            StudentDetailScreen(
                                              student: studentList[index],
                                            )));

                                if (isModified != null && isModified == true) {
                                  setState(() {
                                    getData();
                                  });
                                }
                              },
                            ),
                          ),
                        ])))));
  }
}
