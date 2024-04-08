import 'package:dart_basics/models/student.dart';
import 'package:dart_basics/validation/students_validation.dart';
import 'package:flutter/material.dart';

class StudentUpdate extends StatelessWidget with StudentValidationMixin{
  late Student student;
  var formKey = GlobalKey<FormState>();

  StudentUpdate({required Student student}){
    this.student = student;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text("Update a student"),
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
      initialValue: student.firstName,
      decoration: const InputDecoration(labelText: "Name", hintText: "Mehtap"),
      validator: firstNameValidation,
      onSaved: (String? value){
        student.firstName = value;
      },
    );
  }

  Widget surNameBox() {
    return TextFormField(
      initialValue: student.lastName,
      decoration: const InputDecoration(labelText: "Surname", hintText: "Şenol"),
      validator: surNameValidation,
      onSaved: (String? value){
        student.lastName = value;
      },
    );
  }

  Widget ageBox() {
    return TextFormField(
      keyboardType: TextInputType.number,
      initialValue: student.age.toString(),
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
            Navigator.pop(context);
          }
        },
        child: Text("Update"));
  }
}