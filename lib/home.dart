import 'package:flutter/material.dart';
import 'package:sqlflite_student_managment/model/student_model.dart';
import 'package:sqlflite_student_managment/database/database_helper.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String,dynamic>> students =[];

  final nameController = TextEditingController();
  final ageController = TextEditingController();

 Future<void> addStudent() async {

  final student = StudentModel(
    name: nameController.text,
    age: int.parse(ageController.text),
  );

  await DatabaseHelper.instance.insertStudent(
    student.toMap(),
  );
  



  nameController.clear();
  ageController.clear();
  fetchStudents();

}
Future<void> fetchStudents() async {

  final data = await DatabaseHelper.instance.getStudents();

  setState(() {
    students = data;
  });
}
@override
void initState(){
  super.initState();
  fetchStudents();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Management'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: EdgeInsets.all(16),

        child: Column(
          children: [

            // Student Name
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Student Name',
                hintText: 'Enter student name',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 15),

            // Student Age
            TextField(
              controller: ageController,
 
              decoration: InputDecoration(
                labelText: 'Student Age',
                hintText: 'Enter student age',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 15),

            // Add Button (UI only)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: ()async {
                  await addStudent();
                },
                child: Text('Add Student'),
              ),
            ),

            SizedBox(height: 20),

            // Student List Heading
            Text(
              'Student List',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            // Student List UI
            Expanded(
              child: ListView.builder(
                itemCount: students.length,

                itemBuilder: (context, index) {
                  final student =students[index];

                  return Card(
                    margin: EdgeInsets.only(bottom: 10),

                    child: ListTile(
                     leading: Icon(Icons.person),
                     title:Text(student['name']) ,
                     subtitle: Text("Age : ${student['age']}"),
                    ),
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}