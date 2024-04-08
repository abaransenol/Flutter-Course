mixin class StudentValidationMixin{
  String? firstNameValidation(String? value){
    if (value.toString().length< 2){
      return "Your name is too short!";
    }
  }

  String? surNameValidation(String? value){
    if (value.toString().length< 2){
      return "Your surname is too short!";
    }
  }

  String? ageValidation(String? value){
    int age = 0;
    try {
      age = int.parse(value!);
    } on Exception catch (exception) {
      return "This age is not valid!";
    }
    if(age<0){
      return "This age is not valid!";
    }
  }
}