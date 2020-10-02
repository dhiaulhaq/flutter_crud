import 'package:flutter/material.dart';
import 'package:flutter_crud/providers/employee_provider.dart';
import 'package:provider/provider.dart';
import '../models/employee_model.dart';

class Employee extends StatelessWidget{
  final data = [
    EmployeeModel(
      id: '1',
      employeeName: "Albert Einstein",
      employeeSalary: "32080",
      employeeAge: "61",
      profileImage: "",
    ),
    EmployeeModel(
      id: '2',
      employeeName: "Ben Joe",
      employeeSalary: "42079",
      employeeAge: "26",
      profileImage: "",
    ),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Management'),
      ),
      body: RefreshIndicator(
        onRefresh: () => Provider.of<EmployeeProvider>(context, listen: false).getEmployee(),
        color: Colors.red,
        child: Container(
          margin: EdgeInsets.all(10),
          child: FutureBuilder(
            future: Provider.of<EmployeeProvider>(context, listen: false).getEmployee(),
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Consumer<EmployeeProvider>(
                builder: (context, data, _){
                  return ListView.builder(
                    itemCount: data.dataEmployee.length,
                    itemBuilder: (context, i){
                      return Card(
                        elevation: 8,
                        child: ListTile(
                          title: Text(
                            data.dataEmployee[i].employeeName,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('Age: ${data.dataEmployee[i].employeeAge}'),
                          trailing: Text("\\${data.dataEmployee[i].employeeSalary}"),
                        ),
                      );
                    }
                  );
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Text('+'),
        onPressed: () {},
      ),
    );
  }
}