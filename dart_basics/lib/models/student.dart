class Student{
  late String? firstName;
  late String? lastName;
  late int? age;
  late int id;

  Student({required int id, required String firstName, required String lastName, required int age}){
    this.id = id;
    this.firstName = firstName;
    this.lastName = lastName;
    this.age = age;
  }

  Student.withoutInfo();

  bool get getIsOlder{
    if(age as int < 18){
      return false;
    } else {
      return true;
    }
  }
}