import 'package:dart_basics/models/student.dart';
import 'package:flutter/material.dart';
import '../validation/students_validation.dart';

class StudentAdd extends StatelessWidget with StudentValidationMixin{
  late List<Student> students;
  Student student = Student.withoutInfo();
  var formKey = GlobalKey<FormState>();

  StudentAdd({required List<Student> studentsList}){
    this.students = studentsList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text("Add a student"),
      ),

      body: Container(
        margin: const EdgeInsets.all(25),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              nameBox(),
              surNameBox(),
              ageBox(),
              completeButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget nameBox() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Name", hintText: "Mehtap"),
      validator: firstNameValidation,
      onSaved: (String? value){
        student.firstName = value;
      },
    );
  }

  Widget surNameBox() {
    return TextFormField(
        decoration: const InputDecoration(labelText: "Surname", hintText: "Şenol"),
        validator: surNameValidation,
        onSaved: (String? value){
          student.lastName = value;
      },
    );
  }

  Widget ageBox() {
    return TextFormField(
        decoration: const InputDecoration(labelText: "Age", hintText: "44"),
        validator: ageValidation,
        onSaved: (String? value){
          student.age = int.parse(value!);
      },
    );
  }

  Widget completeButton(BuildContext context){
    return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.black87),
        onPressed: (){
          bool? isValidated = formKey.currentState?.validate();
          if(isValidated!){
              formKey.currentState?.save();
              student.id = students.length;
              students.add(student);
              Navigator.pop(context);
          }
        },
        child: Text("Add"));
  }
}