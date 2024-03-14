import 'package:flutter/material.dart';
import 'package:httphouswork/models/example_model.dart';
import 'package:httphouswork/service/http_service.dart';
import 'package:httphouswork/service/log_service.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String date ='no date';
// printni o'rniga ishlatiladi
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LogService.d('hi there-d');
    LogService.i('hi there-i');
    LogService.w('hi there-w');
    LogService.e('hi there-e');


    LoadExamplee();
    // creatExamplee();
    // updateExamplee();
    // deleteExamplee();
  }
// umumiy listni ko'rsatadsi
  LoadExamplee()  async {
    // var url = Uri.https('jsonplaceholder.typicode.com', 'posts');
    // var response = await http.get(url);
    // LogService.d(response.body);
    var response =await Network.GET(Network.API_EMPLOYEE_LIST, {});
    LogService.d(response!);
    setState(() {
      date=response;
    });
  }
  //yuayda ko'rsatadi
  creatExamplee() async {
    Examplee examplee = Examplee (id:1,exampleeName:'NextGen',exampleeSalary:10000,exampleeAge: 19,profileImage:"assets/images/img.png");
    var response = await Network.POST(Network.API_EMPLOYEE_CREATE,Network.paramsCreate (examplee));
    LogService.d(response!);
    //yuayga ko'rsatib beradi
    setState(() {
      date=response;
    });
  }
  updateExample() async {
    Examplee examplee = Examplee(id:1,exampleeName:'NextGen 2',exampleeSalary:20000,exampleeAge: 20,profileImage:"assets/images/img_1.png");
    var response = await Network.PUT(Network.API_EMPLOYEE_UPDATE +examplee.id.toString(),Network.paramsUpdate (examplee));
    LogService.d(response!);
    setState(() {
      date=response;
    });
  }
  deleteExample() async {
    Examplee examplee = Examplee(id:1,exampleeName:'NextGen 2',exampleeSalary:30000,exampleeAge: 21,profileImage:"assets/images/img.png");
    var response = await Network.DEL(Network.API_EMPLOYEE_DELETE +examplee.id.toString(),Network.paramsEmpty ());
    LogService.d(response!);
    setState(() {
      date=response;
    });
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("NetworkingHomeWork"),
      ),
      body: Center(
        child: Text(date,style: TextStyle(fontSize: 18),),
      ),
    );
  }
}
