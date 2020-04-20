import 'package:flutter/foundation.dart';
import 'package:students/model/student.dart';
import 'package:students/utilties/sql-helper.dart';

class StudentProvider with ChangeNotifier {
  bool checked = false;
  List<Student> _students = [];
  List<Student> get students => _students;

  void addStudent({String name, String desc, String sub, int pass}) {
    final newStudent = Student(name, desc, pass, sub);
    _students.add(newStudent);
    notifyListeners();
    SqlHelper.insert('student_data', newStudent.asMap());
  }

  Future<void> getData() async {
    final dataList = await SqlHelper.fetchData('student_data');
    List<Student> data = [];
    data = dataList
        .map((item) => Student.withId(item['id'], item['name'],
            item['description'], item['pass'], item['subject']))
        .toList();
    _students = data.reversed.toList();
    notifyListeners();
  }

  Future<void> update(
      {int id, String name, String desc, String sub, int pass}) async {
    final indexOfItem = _students.indexWhere((student) => student.id == id);
    _students[indexOfItem] = Student(name, desc, pass, sub);
    SqlHelper.update('student_data', _students[indexOfItem].asMap(), id);
  }

  void removeStudent({int id}) {
    _students.removeWhere((student) => student.id == id);
    notifyListeners();
    SqlHelper.remove('student_data', id);
  }

  void removeAll() {
    _students.clear();
    notifyListeners();
    SqlHelper.removeAll('student_data');
  }

  int get itemCount {
    return _students.length;
  }

  bool passed(Student student) {
    return student.pass == 1;
  }

  void isChecked() {
    checked = !checked;
    notifyListeners();
  }

  Student findItemById(int id) =>
      _students.firstWhere((student) => student.id == id);
}
