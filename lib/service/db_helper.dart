import 'package:student_management/model/student.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;

    _db = await initDatabase();
    return _db!;
  }

  Future<Database> initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'student.db');
    Database db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE student (id INTEGER PRIMARY KEY AUTOINCREMENT , name TEXT,department TEXT, dob TEXT, gender TEXT, language_korean INTEGER, language_english INTEGER, language_chinese INTEGER )");
  }

  Future<Student> add(Student student) async {
    var dbClient = await db;
    student.id = await dbClient.insert('student', student.toMap());
    return student;
  }

  Future<List<Student>> getStudents() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query('student', columns: ['id', 'name']);
    List<Student> students = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        students.add(Student.fromMap(maps[i]));
      }
    }
    return students;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(
      'student',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> update(Student student) async {
    var dbClient = await db;
    return await dbClient.update(
      'student',
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
