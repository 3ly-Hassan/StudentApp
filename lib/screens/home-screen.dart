import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:students/provider/provider.dart';
import 'edit_students.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Student'),
        leading: Consumer<StudentProvider>(
            builder: (ctx, stu, ch) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    child: Text(
                      '${stu.itemCount} ',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    radius: 5,
                    backgroundColor: Colors.white,
                    minRadius: null,
                  ),
                )),
      ),
      body: FutureBuilder(
        future: Provider.of<StudentProvider>(context, listen: false).getData(),
        builder: (ctx, data) => data.connectionState == ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<StudentProvider>(
                child: Center(
                  child: const Text(
                    'No Places Yet .',
                    style: TextStyle(fontSize: 50, color: Colors.red),
                  ),
                ),
                builder: (ctx, great, ch) => great.students.length <= 0
                    ? ch
                    : Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ListView.builder(
                            itemCount: great.students.length,
                            itemBuilder: (context, index) => Card(
                                  child: Dismissible(
                                    key: ValueKey(great.students[index].id),
                                    direction: DismissDirection.endToStart,
                                    onDismissed: (direction) {
                                      great.removeStudent(
                                          id: great.students[index].id);
                                    },
                                    confirmDismiss: (direction) => showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                              title: Text('Are You Sure'),
                                              content: Text(
                                                  'Do you want to  remove this studen '),
                                              actions: <Widget>[
                                                FlatButton(
                                                    onPressed: () {
                                                      Navigator.of(ctx)
                                                          .pop(false);
                                                    },
                                                    child: Text('No')),
                                                FlatButton(
                                                    onPressed: () {
                                                      Navigator.of(ctx)
                                                          .pop(true);
                                                    },
                                                    child: Text('Yes')),
                                              ],
                                            )),
                                    child: ListTile(
                                      isThreeLine: true,
                                      leading: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8, left: 5),
                                        child: Icon(
                                          Icons.account_circle,
                                          color: Provider.of<StudentProvider>(
                                                          context)
                                                      .students[index]
                                                      .pass ==
                                                  1
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                      title: Text(great.students[index].name),
                                      subtitle: Text(
                                        great.students[index].description +
                                            '\n' +
                                            great.students[index].subject,
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                      trailing: Container(
                                        width: 80,
                                        child: Row(
                                          children: <Widget>[
                                            IconButton(
                                              icon: Icon(Icons.edit),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditStudent(
                                                                id: great
                                                                    .students[
                                                                        index]
                                                                    .id)));
                                              },
                                            ),
                                            Icon(
                                              Icons.delete_sweep,
                                              color: Colors.red,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                      ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => EditStudent()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
