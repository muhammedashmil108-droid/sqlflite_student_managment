class StudentModel {
  int? id;
  String name;
  int age;


  StudentModel({
    this.id,
    required this.name,
    required this.age

  });

  Map<String,dynamic> toMap(){
    return{
      'id':id,
      'name': name,
      'age': age,
    };
  }
}
