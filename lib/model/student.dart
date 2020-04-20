class Student {
  int _id;
  String _name;
  String _description;
  int _pass;
  String _subject;

  Student(this._name, this._description, this._pass, this._subject);

  Student.withId(
      this._id, this._name, this._description, this._pass, this._subject);
  void isPass() {
    this.pass = this.pass == 1 ? 2 : 1;
  }

  String get subject => _subject;

  set subject(String value) {
    _subject = value;
  }

  int get pass => _pass;

  set pass(int value) {
    if (value == 1 || value == 2) _pass = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get name => _name;

  set name(String value) {
    if (value.length <= 255) _name = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  Map<String, dynamic> asMap() {
    var map = Map<String, dynamic>();
    map['name'] = this._name;
    map['description'] = this._description;
    map['pass'] = this._pass;
    map['subject'] = this._subject;
    return map;
  }

  Student.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._description = map['description'];
    this._pass = map['pass'];
    this._subject = map['subject'];
  }
}
