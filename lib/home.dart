import 'package:flutter/material.dart';
import 'package:sqlflite_student_managment/model/student_model.dart';
import 'package:sqlflite_student_managment/database/database_helper.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final nameController = TextEditingController();
  final ageController = TextEditingController();

  List<Map<String, dynamic>> students = [];
  int? editId;

  @override
  void initState() {
    super.initState();
    fetchStudents();
  }

  // Add Student
  Future<void> addStudent() async {

    if (nameController.text.isEmpty || ageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    final age = int.tryParse(ageController.text);

    if (age == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Enter a valid age')),
      );
      return;
    }

    final student = StudentModel(
      name: nameController.text.trim(),
      age: age,
    );

    if(editId == null){
      
      // Add student
      await DatabaseHelper.instance.insertStudent(student.toMap());
    }else{

      // Update student
      await DatabaseHelper.instance.updateStudent(editId!, student.toMap());
    }

    nameController.clear();
    ageController.clear();
    setState(() {
      editId = null;
    });

    await fetchStudents();

  }

  // Fetch Students
  Future<void> fetchStudents() async {

    final data = await DatabaseHelper.instance.getStudents();

    if (!mounted) return;

    setState(() {
      students = data;
    });
  }
// Delete student
Future<void> deleteStudent(int id)async{

await DatabaseHelper.instance.deleteStudent(id);
await fetchStudents();
}

 // edit or update student
  void editStudent(Map<String,dynamic>student){
    setState(() {
      editId = student['id'];
      nameController.text = student['name'];
      ageController.text = student['age'].toString();
    });
  }
  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    super.dispose();
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

            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Student Name',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 15),

            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Student Age',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: addStudent,
                child: Text('Add Student'),
              ),
            ),

            SizedBox(height: 20),

            Text(
              'Student List',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Expanded(
              child: students.isEmpty
                  ? Center(
                      child: Text('No students added yet'),
                    )
                  : ListView.builder(
                      itemCount: students.length,

                      itemBuilder: (context, index) {

                        final student = students[index];

                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text('${index + 1}'),
                            ),

                            title: Text(student['name']),

                            subtitle: Text(
                              'Age: ${student['age']}',
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                            // edit button
                            IconButton(onPressed: (){
                              editStudent(student);
                            }, icon: Icon(Icons.edit,color: Colors.blue,)),

                            // delete button
                             IconButton(onPressed: ()async{
                              await deleteStudent(student['id']);

                            },
                             icon: Icon(Icons.delete,color: Colors.red,)),
                              ],
                            ),
                           
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