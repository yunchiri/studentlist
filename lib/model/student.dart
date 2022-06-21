// ignore_for_file: non_constant_identifier_names

enum Gender { Male, Female, Other }
enum Language { Korean, English, Chinese }

class Student {
  int? id;
  late String name;
  String? department;
  String? dob;
  String? gender;
  int language_korean = 0;
  int language_english = 0;
  int language_chinese = 0;

  Student(this.name,
      {this.id,
      this.department,
      this.dob,
      this.gender,
      this.language_korean = 0,
      this.language_english = 0,
      this.language_chinese = 0});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'department': department,
      'dob': dob,
      'gender': gender,
      'language_korean': language_korean > 0 ? 1 : 0,
      'language_english': language_english > 0 ? 1 : 0,
      'language_chinese': language_chinese > 0 ? 1 : 0,
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

    language_korean = map['language_korean'] ?? 0;
    language_english = map['language_english'] ?? 0;
    language_chinese = map['language_chinese'] ?? 0;

    // language = map['language'];
  }
}
