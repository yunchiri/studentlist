import 'package:flutter/material.dart';
import 'package:student_management/model/student.dart';

import '../service/db_helper.dart';

class StudentAddView extends StatefulWidget {
  @override
  _StudentAddViewState createState() => _StudentAddViewState();
}

class _StudentAddViewState extends State<StudentAddView> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  Future<List<Student>>? students;
  int? studentIdForUpdate;
  String? _studentName;
  bool isUpdate = false;

  final genderList = ['Male', 'Female', 'Other'];
  final languageList = ['Korean', 'English', 'Chinese'];
  String? gender;
  bool languageKorean = false;
  bool languageEnglish = false;
  bool languagechinese = false;

  DBHelper? dbHelper;
  final _studentNameController = TextEditingController();
  final _departMentController = TextEditingController();
  final _dobController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    refreshStudentList();
  }

  refreshStudentList() {
    setState(() {
      students = dbHelper!.getStudents();
    });
  }

  @override
  void dispose() {
    _studentNameController.dispose();
    _departMentController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Form(
          key: _formStateKey,
          autovalidateMode: AutovalidateMode.always,
          child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: ListView(
                children: [
                  TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? 'Please Enter Student Name' : null,
                    onSaved: (value) => _studentName = value,
                    controller: _studentNameController,
                    // autovalidateMode: AutovalidateMode.always,
                    decoration: const InputDecoration(
                        labelText: "Name",
                        labelStyle: TextStyle(
                          color: Colors.lightGreen,
                        )),
                  ),
                  TextFormField(
                    validator: (value) => null,
                    onSaved: (value) => _studentName = value,
                    controller: _departMentController,
                    decoration: const InputDecoration(
                        labelText: "Department",
                        labelStyle: TextStyle(
                          color: Colors.lightGreen,
                        )),
                  ),
                  TextFormField(
                    validator: (value) => null,
                    onSaved: (value) => _studentName = value,
                    controller: _dobController,
                    decoration: const InputDecoration(
                        labelText: "DoB",
                        labelStyle: TextStyle(
                          color: Colors.lightGreen,
                        )),
                  ),
                  const Divider(),
                  const Text("Language"),
                  Column(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: languageKorean,
                            onChanged: (value) {
                              setState(() {
                                if (value == null) return;
                                languageKorean = value;
                              });
                            },
                          ),
                          const Text("Korean")
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: languageEnglish,
                            onChanged: (value) {
                              setState(() {
                                if (value == null) return;

                                languageEnglish = value;
                              });
                            },
                          ),
                          const Text("English")
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: languagechinese,
                            onChanged: (value) {
                              setState(() {
                                if (value == null) return;

                                languagechinese = value;
                              });
                            },
                          ),
                          const Text("Chinese")
                        ],
                      )
                    ],
                  ),
                  const Divider(),
                  const Text("Gender"),
                  Row(
                    children: [
                      Radio<String>(
                          value: genderList[0],
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value;
                            });
                          }),
                      const Text("Male"),
                      Radio<String>(
                          value: genderList[1],
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value;
                            });
                          }),
                      const Text("Feale"),
                      Radio<String>(
                          value: genderList[2],
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value;
                            });
                          }),
                      const Text("Other")
                    ],
                  )
                ],
              )),
        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.lightGreen),
              child: Text(
                (isUpdate ? 'UPDATE' : 'ADD'),
                style: const TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                if (isUpdate) {
                  if (_formStateKey.currentState!.validate()) {
                    _formStateKey.currentState!.save();

                    Student student = Student(_studentNameController.text);

                    int result = await dbHelper!.update(student);

                    if (result == 1) {
                      setState(() {
                        isUpdate = false;
                      });
                    }
                  }
                } else {
                  if (_formStateKey.currentState!.validate()) {
                    _formStateKey.currentState!.save();

                    // dbHelper!.add(Student(_studentName, []));
                    Student student = Student(_studentNameController.text);

                    Student student2 = await dbHelper!.add(student);
                  }
                }
                _studentNameController.text = '';
                refreshStudentList();
              },
            ),
            const Padding(
              padding: EdgeInsets.all(10),
            ),
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              child: const Text(
                ("CANCEL"),
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                _studentNameController.text = '';
                setState(() {
                  //isUpdate = false;
                  studentIdForUpdate = null;
                });
              },
            ),
          ],
        ),
        // const Divider(
        //   height: 5.0,
        // ),
        // Expanded(
        //   child: FutureBuilder(
        //     future: students,
        //     builder: (context, AsyncSnapshot<dynamic> snapshot) {
        //       if (snapshot.hasData) {
        //         return generateList(snapshot.data);
        //       }
        //       if (snapshot.data == null || snapshot.data.length == 0) {
        //         return Text('No Data Found');
        //       }
        //       return CircularProgressIndicator();
        //     },
        //   ),
        // ),
      ],
    );
  }

  Widget generateList(List<Student>? students) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        width: double.infinity,
        child: DataTable(
          columns: const [
            DataColumn(
              label: Text('NAME'),
            ),
            DataColumn(
              label: Text('DELETE'),
            )
          ],
          rows: students!
              .map(
                (student) => DataRow(
                  cells: [
                    DataCell(
                      Text(student.name),
                      onTap: () {
                        setState(() {
                          isUpdate = true;
                          studentIdForUpdate = student.id;
                        });
                        _studentNameController.text = student.name;
                      },
                    ),
                    DataCell(
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          // dbHelper!.delete(student.id);
                          refreshStudentList();
                        },
                      ),
                    )
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
