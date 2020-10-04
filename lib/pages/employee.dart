import 'package:flutter/material.dart';
import 'package:flutter_crud/pages/employee_edit.dart';
import 'package:flutter_crud/providers/employee_provider.dart';
import 'package:provider/provider.dart';
import '../models/employee_model.dart';
import './employee_add.dart';

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
                      return InkWell(
                        onTap: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => EmployeeEdit(id: data.dataEmployee[i].id,)
                            ),
                          );
                        },
                        child: Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.endToStart,
                          confirmDismiss: (DismissDirection direction) async{
                            final bool res = await showDialog(context: context, builder: (BuildContext context){
                              return AlertDialog(
                                title: Text('Confirmation'),
                                content: Text('Are You Sure?'),
                                actions: <Widget>[
                                  FlatButton(onPressed: () => Navigator.of(context).pop(true), child: Text('Delete'),),
                                  FlatButton(onPressed: () => Navigator.of(context).pop(false), child: Text('Cancel'),),
                                ],
                              );
                            });
                            return res;
                          },
                          onDismissed: (value){
                            Provider.of<EmployeeProvider>(context, listen: false).deleteEmployee(data.dataEmployee[i].id);
                          },
                          child: Card(
                            elevation: 8,
                            child: ListTile(
                              title: Text(
                                data.dataEmployee[i].employeeName,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text('Age: ${data.dataEmployee[i].employeeAge}'),
                              trailing: Text("\\${data.dataEmployee[i].employeeSalary}"),
                            ),
                          ),
                        ),
                      );
                    },
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
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => EmployeeAdd()));
        },
      ),
    );
  }
}