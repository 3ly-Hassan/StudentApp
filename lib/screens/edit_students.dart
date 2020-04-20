import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:students/model/student.dart';
import 'package:students/provider/provider.dart';

class EditStudent extends StatefulWidget {
  final int id;

  const EditStudent({this.id});

  @override
  _EditStudentState createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  Student _student;
  bool _isInit = true;
  //var _initValue = {'name': '', 'description': '', 'sub': '', 'pass': null};
  TextEditingController _nameController = TextEditingController();
  TextEditingController _subjectController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  void addStudent() {
    if (widget.id != null) {
      Provider.of<StudentProvider>(context, listen: false).update(
          id: widget.id,
          name: _nameController.text.trim(),
          desc: _descController.text.trim(),
          sub: _subjectController.text.trim(),
          pass: Provider.of<StudentProvider>(context, listen: false).checked
              ? 1
              : 2);
      Navigator.of(context).pop();

      return;
    }
    if (_nameController.text == null || _subjectController.text == null) return;
    Provider.of<StudentProvider>(context, listen: false).addStudent(
        name: _nameController.text.trim(),
        desc: _descController.text.trim(),
        sub: _subjectController.text.trim(),
        pass: Provider.of<StudentProvider>(context, listen: false).checked
            ? 1
            : 2);
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (widget.id != null && _isInit) {
      _student = Provider.of<StudentProvider>(context, listen: false)
          .findItemById(widget.id);
      _nameController.text = _student.name;
      _subjectController.text = _student.subject;
      _descController.text = _student.description;
      Provider.of<StudentProvider>(context, listen: false).checked =
          _student.pass == 1 ? true : false;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id != null ? 'Edit a student' : 'Add a New Student'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(labelText: 'Name'),
                      controller: _nameController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(labelText: 'subject'),
                        controller: _subjectController),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(labelText: 'description'),
                      controller: _descController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Pass',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 250,
                        ),
                        Checkbox(
                            activeColor: Colors.blue,
                            value:
                                Provider.of<StudentProvider>(context).checked,
                            onChanged: (val) {
                              Provider.of<StudentProvider>(context,
                                      listen: false)
                                  .isChecked();
                            }),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
            child: RaisedButton.icon(
              icon: Icon(Icons.add),
              label: Text(widget.id != null ? 'Update' : 'Add studend'),
              onPressed: addStudent,
              elevation: 5,
              color: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
    );
  }
}
