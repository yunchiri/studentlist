// ignore_for_file: non_constant_identifier_names

// enum Gender { Male, Female, Other }

// enum Language { Korean, English, Chinese }

class Student {
  int? id;
  late String name;
  String? department;
  String? dob;
  String? gender;
  bool language_korean = false;
  bool language_english = false;
  bool language_chinese = false;

  Student(this.name,
      {this.id,
      this.department,
      this.dob,
      this.gender,
      this.language_korean = false,
      this.language_english = false,
      this.language_chinese = false});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'department': department,
      'dob': dob,
      'gender': gender,
      'language_korean': language_korean == true ? 1 : 0,
      'language_english': language_english == true ? 1 : 0,
      'language_chinese': language_chinese == true ? 1 : 0,
      // 'language' : language
    };
    return map;
  }

  Student.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    name = map['name'];
    department = map['department'];
    dob = map['dob'];
    gender = map['gender'];

    language_korean = ((map['language_korean'] ?? 0) == 1 ? true : false);
    language_english = ((map['language_english'] ?? 0) == 1 ? true : false);
    language_chinese = ((map['language_chinese'] ?? 0) == 1 ? true : false);

    // language = map['language'];
  }
}
