
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:httphouswork/pages/creat_page.dart';
import 'package:httphouswork/pages/update_page.dart';
import 'package:httphouswork/service/http_service.dart';
import 'package:httphouswork/service/log_service.dart';
import '../models/employee_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  String data = 'no data';
  List<Employee> employees = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadEmployees();
    // createEmployee();
    // updateEmployee();
    // deleteEmployee();
  }

  loadEmployees() async {
    var response = await Network.GET(Network.API_EMPLOYEE_LIST, {});
    LogService.d(response!);
    setState(() {
      data = response;
      employees = Network.parseEmployee(response)!;
    });
  }
  createEmployee() async {
    Employee employee = Employee(
        id: 1, employeeName: 'Ali', employeeSalary: 1000, employeeAge: 20, profileImage: 'assets/images/img.png');
    var response = await Network.POST(
        Network.API_EMPLOYEE_CREATE, Network.paramsCreate(employee));
    LogService.d(response!);
    setState(() {
      data = response;
    });
  }

  updateEmployee() async {
    Employee employee = Employee(
        id: 1, employeeName: 'Ali 2', employeeSalary: 1000, employeeAge: 20, profileImage: 'assets/images/img_1.png');
    var response = await Network.PUT(
        Network.API_EMPLOYEE_UPDATE + employee.id.toString(),
        Network.paramsUpdate(employee));
    LogService.d(response!);
    setState(() {
      data = response;
    });
  }

  deleteEmployee() async {
    Employee employee = Employee(
        id: 1, employeeName: 'Ali 3', employeeSalary: 1000, employeeAge: 20, profileImage: 'assets/images/img.png');
    var response = await Network.DEL(
        Network.API_EMPLOYEE_DELETE + employee.id.toString(),
        Network.paramsEmpty());
    LogService.d(response!);
    setState(() {
      data = response;
    });
  }

  Future _callAddPostPage() async {
    bool result = await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
      return const CreatPage();
    }));

    if (result) {
      loadEmployees();
    }
  }

  _loadEmployee() async {
    setState(() {
      isLoading = true;
    });

    var response = await Network.GET(Network.API_EMPLOYEE_LIST, Network.paramsEmpty());
    LogService.d(response!);
    List<Employee> postList = Network.parseEmployee(response);

    setState(() {
      employees = employees;
      isLoading = false;
    });
  }

  Future _callUpdatePage(Employee employee) async {
    bool result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return UpdatePage(employee: employee);
    }));

    if (result) {
      _loadEmployee();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text(
          'Network',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: employees.length,
        itemBuilder: (employee, index) {
          return employeeItem(employees[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: (){
          _callAddPostPage();
        },
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }

  void doNothing(BuildContext context) {}

  Widget employeeItem(Employee employee) {
    return Slidable(
      key: const ValueKey(0),
      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // A pane can dismiss the Slidable.
        dismissible: DismissiblePane(onDismissed: () {}),

        // All actions are defined in the children parameter.
        children: [
          // A clickableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: (BuildContext) {
              setState(() {});
              // deleteEmployee(employee.id, employee);
              LogService.i(employee.id.toString());
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),

      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            flex: 1,
            onPressed: (BuildContext context) {
              _callUpdatePage(employee);
            },
            backgroundColor: const Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'update',
          ),
        ],
      ),

      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("id: ${employee.id}",style: TextStyle(fontSize: 18)),
            Text("Name: ${employee.employeeName}", style:  TextStyle(fontSize: 18)),
            Text("age: ${employee.employeeAge}",style: TextStyle(fontSize: 18)),
            Text("salary: \$${employee.employeeSalary}",style: TextStyle(fontSize: 18)),
            Text("image: ${" Null "}",style: TextStyle(fontSize: 18)),
            const Divider(thickness: 1)
          ],
        ),
      ),
    );
  }
}