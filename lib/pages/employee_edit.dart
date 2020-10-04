import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/employee.dart';
import '../providers/employee_provider.dart';

class EmployeeEdit extends StatefulWidget{
  final String id;
  EmployeeEdit({this.id});

  @override
  _EmployeeEditState createState() => _EmployeeEditState();
}

class _EmployeeEditState extends State<EmployeeEdit>{
  final TextEditingController _name = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _salary = TextEditingController();
  bool _isLoading = false;

  final snackbarKey = GlobalKey<ScaffoldState>();

  FocusNode salaryNode = FocusNode();
  FocusNode ageNode = FocusNode();

  @override
  void initState() {

    Future.delayed(Duration.zero, (){
      Provider.of<EmployeeProvider>(context, listen: false).findEmployee(widget.id).then((response){
        _name.text = response.employeeName;
        _age.text = response.employeeAge;
        _salary.text = response.employeeSalary;
      });
    });
    super.initState();
  }

  void submit(BuildContext context){
    //Save Data Progress
    if(!_isLoading){
      setState(() {
        _isLoading = true;
      });
      Provider.of<EmployeeProvider>(context, listen: false)
          .updateEmployee(widget.id, _name.text, _age.text, _salary.text)
          .then((res){
        if(res){
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Employee())
          );
        } else {
          //Alert
          var snackbar = SnackBar(content: Text('Error occurred, contact admin!'),);
          snackbarKey.currentState.showSnackBar(snackbar);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: snackbarKey,
      appBar: AppBar(
        title: Text('Edit Employee'),
        actions: <Widget>[
          FlatButton(
            child: _isLoading ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ) : Icon(
              Icons.save,
              color: Colors.white,
            ),
            onPressed: () => submit(context),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            //Input Form
            TextField(
              controller: _name,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.pinkAccent,
                  ),
                ),
                hintText: 'Full Name',
              ),
              onSubmitted: (_){
                FocusScope.of(context).requestFocus(salaryNode);
              },
            ),
            TextField(
              controller: _salary,
              focusNode: salaryNode,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.pinkAccent,
                  ),
                ),
                hintText: 'Salary',
              ),
              onSubmitted: (_){
                FocusScope.of(context).requestFocus(ageNode);
              },
            ),
            TextField(
              controller: _age,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.pinkAccent,
                  ),
                ),
                hintText: 'Age',
              ),
            ),
          ],
        ),
      ),
    );
  }
}