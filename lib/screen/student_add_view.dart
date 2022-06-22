import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_management/model/student.dart';

import '../service/db_helper.dart';

class StudentAddView extends StatefulWidget {
  final bool isEditMode;
  final Student? student;
  const StudentAddView({Key? key, this.isEditMode = false, this.student})
      : super(key: key);

  @override
  _StudentAddViewState createState() => _StudentAddViewState();
}

class _StudentAddViewState extends State<StudentAddView> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  Future<List<Student>>? students;

  // bool isUpdate = false;

  final genderList = ['Male', 'Female', 'Other'];
  final languageList = ['Korean', 'English', 'Chinese'];
  String? gender;

  final _studentNameController = TextEditingController();
  final _departMentController = TextEditingController();
  final _dobController = TextEditingController();

  late Student student;
  @override
  void initState() {
    super.initState();
    if (widget.isEditMode == true) {
      student = widget.student!;

      _studentNameController.text = student.name;
      _departMentController.text = student.department ?? "";
      _dobController.text = student.dob ?? "";
    } else {
      student = Student('');
      _studentNameController.text = "";
      _departMentController.text = student.department ?? "";
      _dobController.text = student.dob ?? "";
    }
  }

  @override
  void dispose() {
    _studentNameController.dispose();
    _departMentController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  void resetForm() {
    _studentNameController.clear();
    _departMentController.clear();

    _dobController.clear();
    _formStateKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Form(
              key: _formStateKey,
              // autovalidateMode: AutovalidateMode.always,
              child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: ListView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    children: [
                      TextFormField(
                        initialValue: student.name,
                        validator: (value) {
                          if (value == null) return null;
                          if (value.isEmpty) return 'Please Enter Student Name';
                          return null;
                        },
                        onChanged: (value) {
                          student.name = value;
                        },

                        onSaved: (value) {
                          student.name = value!;
                        },
                        // controller: _studentNameController,
                        // autovalidateMode: AutovalidateMode.always,
                        decoration: const InputDecoration(
                            labelText: "Name",
                            labelStyle: TextStyle(
                              color: Colors.lightGreen,
                            )),
                      ),
                      TextFormField(
                        initialValue: student.department,
                        validator: (value) => null,
                        onSaved: (value) {
                          student.department = value!;
                        },
                        onChanged: (value) {
                          student.department = value;
                        },

                        // controller: _departMentController,
                        decoration: const InputDecoration(
                            labelText: "Department",
                            labelStyle: TextStyle(
                              color: Colors.lightGreen,
                            )),
                      ),
                      TextFormField(
                        // initialValue: student.dob ,
                        readOnly: true,
                        validator: (value) => null,
                        onSaved: (value) {
                          student.dob = value!;
                        },
                        onTap: () async {
                          DateTime? selectedDateTime = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2030));

                          if (selectedDateTime != null) {
                            setState(() {
                              String formattedDob = DateFormat('yyyy/MM/dd')
                                  .format(selectedDateTime);
                              student.dob = formattedDob;
                              _dobController.text = formattedDob;
                            });
                          }
                        },

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
                                value: student.language_korean,
                                onChanged: (value) {
                                  setState(() {
                                    if (value == null) return;
                                    student.language_korean = value;
                                    // languageKorean = value;
                                  });
                                },
                              ),
                              const Text("Korean")
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: student.language_english,
                                onChanged: (value) {
                                  setState(() {
                                    if (value == null) return;
                                    student.language_english = value;
                                    // languageEnglish = value;
                                  });
                                },
                              ),
                              const Text("English")
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: student.language_chinese,
                                onChanged: (value) {
                                  setState(() {
                                    if (value == null) return;
                                    student.language_chinese = value;
                                    // languagechinese = value;
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
                        children:
                            // List.generate(genderList.length, (index) =>
                            // Radio<String>(
                            //       value: genderList[index],
                            //       groupValue: student.gender,
                            //       onChanged: (value) {
                            //         setState(() {
                            //           student.gender = value;
                            //         });
                            //       })
                            // )
                            [
                          Radio<String>(
                              value: genderList[0],
                              groupValue: student.gender,
                              onChanged: (value) {
                                setState(() {
                                  student.gender = value;
                                });
                              }),
                          Text(genderList[0]),
                          Radio<String>(
                              value: genderList[1],
                              groupValue: student.gender,
                              onChanged: (value) {
                                setState(() {
                                  student.gender = value;
                                });
                              }),
                          Text(genderList[1]),
                          Radio<String>(
                              value: genderList[2],
                              groupValue: student.gender,
                              onChanged: (value) {
                                setState(() {
                                  student.gender = value;
                                  // gender = value;
                                });
                              }),
                          Text(genderList[2])
                        ],
                      )
                    ],
                  )),
            )),
            widget.isEditMode == false
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.lightGreen),
                        child: const Text(
                          'ADD',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formStateKey.currentState!.validate()) {
                            _formStateKey.currentState!.save();

                            // dbHelper!.add(Student(_studentName, []));
                            try {
                              await DBHelper().add(student);
                              //추가 되었습니다
                              FocusScope.of(context).unfocus();
                              setState(() {
                                student = Student('');
                                resetForm();
                              });
                            } catch (e) {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text("Error"),
                                        content: Text("Save Error"),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Ok"),
                                          ),
                                        ],
                                      ));
                            }
                          }
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      TextButton(
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.red),
                        child: const Text(
                          ("CANCEL"),
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          setState(() {
                            student = Student('');
                            resetForm();
                          });
                        },
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            int result = await DBHelper().update(student);

                            if (result == 1) {
                              setState(() {});
                            }
                          },
                          child: const Text(
                            "Update",
                            style: TextStyle(color: Colors.white),
                          )),
                      const SizedBox(
                        width: 50,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            await showDialog<bool>(
                                context: context,
                                builder: (BuildContext buildContext) {
                                  return AlertDialog(
                                    title: const Text("want delete?"),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () async {
                                            if (widget.student == null) return;

                                            int result = await DBHelper()
                                                .delete(widget.student!.id!);
                                            if (result > 0) {
                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop(true);
                                              return;
                                            }

                                            return Navigator.of(context)
                                                .pop(false);
                                          },
                                          child: const Text("Delete")),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Cancle"))
                                    ],
                                  );
                                });
                          },
                          child: const Text(
                            "Delete",
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  )
          ],
        ));
  }
}
