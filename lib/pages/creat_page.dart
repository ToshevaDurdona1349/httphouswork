
import 'package:flutter/material.dart';
import '../models/employee_model.dart';
import '../service/http_service.dart';
import '../service/log_service.dart';
class CreatPage extends StatefulWidget {
  const CreatPage({super.key});

  @override
  State<CreatPage> createState() => _CreatPageState();
}

class _CreatPageState extends State<CreatPage> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _idController = TextEditingController();

  _addEmployee() async{
    String name = _nameController.text.toString().trim();
    String salary = _salaryController.text.toString().trim();
    String age = _ageController.text.toString().trim();
    String id = _idController.text.toString().trim();
    Employee employee = Employee(employeeName: name, employeeSalary: int.parse(salary), employeeAge: int.parse(age), profileImage: '', id:int.parse(id) );

    var response = await Network.POST(Network.API_EMPLOYEE_CREATE, Network.paramsCreate(employee));
    LogService.d(response!);
    backToFinish();
  }

  backToFinish() {
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Add Post"),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(hintText: "Name"),
              ),
            ),
            Container(
              child: TextField(
                controller: _salaryController,
                decoration: InputDecoration(hintText: "Salary"),
              ),
            ),
            Container(
              child: TextField(
                controller: _ageController,
                decoration: InputDecoration(hintText: "Age"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: double.infinity,
              child: MaterialButton(
                color: Colors.blue,
                onPressed: () {
                  // _addPost();
                  _addEmployee();
                },
                child: const Text("Add"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}