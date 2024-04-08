import 'package:dart_basics/models/student.dart';
import 'package:dart_basics/screens/students_add.dart';
import 'package:dart_basics/screens/students_update.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Student> students = [
    Student(firstName: "Ali Baran", lastName: "Şenol", age: 18, id:0),
    Student(firstName: "Şevval Ceren", lastName: "Şenol", age: 14, id: 1),
    Student(firstName: "Zeynep Ecrin", lastName: "Şenol", age: 12, id: 2)
  ];

  Student selectedStudent = Student(id: -1, firstName: "", lastName: "", age: 0);

  @override
  Widget build(BuildContext context) {
    Scaffold scaffold = Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text("Adult or just a little kid"),
      ),
      body: Column(
        children: <Widget>[
          studentsList(),
          Text("Selected student: ${selectedStudent.firstName}"),
          Row(children: <Widget>[
            Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: addButton(context, students)),
            Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: updateButton(context, students)),
            Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: deleteButton(context, students)),
          ]),
          //counterButton(context),
        ],
      ),
    );

    return scaffold;
  }

  Widget studentsList() {
    return Expanded(
        child: ListView.builder(
            itemCount: students.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text("${students[index].firstName} ${students[index].lastName}"), //style: TextStyle(fontFamily: "Times New Roman",fontSize: 24)),
                subtitle: Text("Age: ${students[index].age}"),
                trailing: Icon(returnIconData(students, index)),
                leading: const CircleAvatar(
                  backgroundImage: NetworkImage("https://ubys.eskisehir.edu.tr/images/PortalV3/Logos/119/200x200.png"),
                  backgroundColor: Color(0x00000000),
                ),
                onTap: () {
                  setState(() {
                    selectedStudent = students[index];
                  });
                },
              );
            }));
  }

  /*Widget counterButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
          child: Text("Click on me"),
          onPressed: () {
            whenPressedTheButton(context);
          }),
    );
  }
  
  setState(() {
            Student student = Student(id: students.length,firstName: "Mehtap", lastName: "Şenol", age: 44);
            students.add(student);
          }
  setState(() {
              students[selectedStudent.id].firstName = "Murat";
              students[selectedStudent.id].age = 50;
              selectedStudent = students[selectedStudent.id];
            });
  */

  Widget addButton(BuildContext context, List<Student> students){
    return Center(child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.black87),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => StudentAdd(studentsList: students))).then((value) {setState(() {});});
        },
        child: const Row(
          children: [
            Icon(Icons.add),
            SizedBox(
              width: 4,
            ),
            Text("Add"),
          ],
        )));
  }
  Widget updateButton(BuildContext context, List<Student> students){
    return Center(child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.black87),
        onPressed: (){
          if (selectedStudent.id == -1){
            var alertDialog = const AlertDialog(
              content: Text("Before this process, please select a student."),
              title: Text("Error"),
            );
            showDialog(context: context, builder: (BuildContext context) => alertDialog);

          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) => StudentUpdate(student: selectedStudent))).then((value) {setState(() {});});
          }
        },
        child: const Row(
          children: [
            Icon(Icons.update),
            SizedBox(
              width: 7.5,
            ),
            Text("Update"),
          ],
        )));
  }

  Widget deleteButton(BuildContext context, List<Student> students){
    return Center (child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.black87),
        onPressed: (){
          if (selectedStudent.id == -1){
            var alertDialog = const AlertDialog(
              content: Text("Before this process, please select a student."),
              title: Text("Error"),
            );
            showDialog(context: context, builder: (BuildContext context) => alertDialog);

          } else {
            setState(() {
              students.remove(selectedStudent);
              selectedStudent = Student(id: -1, firstName: "", lastName: "", age: 0);
            });
          }
        },
        child: const Row(
          children: [
            Icon(Icons.delete),
            SizedBox(
              width: 5,
            ),
            Text("Delete"),
          ],
        )));
  }


  /*void whenPressedTheButton(BuildContext context) {
    _clickNumber++;
    AlertDialog alertDialog = AlertDialog(
      title: Text("Pressing time"),
      content: Text(_clickNumber.toString() + " times clicked"),
    );
    showDialog(
        context: context, builder: (BuildContext context) => alertDialog);
  }*/

  IconData returnIconData(List<Student> students, int index) {
    IconData iconData;
    if (students[index].getIsOlder) {
      iconData = Icons.done;
    } else {
      iconData = Icons.clear;
    }
    return iconData;
  }
}


