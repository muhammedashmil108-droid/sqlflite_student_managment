import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final nameController = TextEditingController();
  final ageController = TextEditingController();

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
              keyboardType: TextInputType.number,
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
                onPressed: () {},
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
                itemCount: 5,

                itemBuilder: (context, index) {

                  return Card(
                    margin: EdgeInsets.only(bottom: 10),

                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),

                      title: Text('Student Name'),

                      subtitle: Text('Age: 22'),
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