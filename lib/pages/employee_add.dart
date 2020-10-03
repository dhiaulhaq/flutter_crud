import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/employee.dart';
import '../providers/employee_provider.dart';

class EmployeeAdd extends StatefulWidget{
  @override
  _EmployeeAddState createState() => _EmployeeAddState();
}

class _EmployeeAddState extends State<EmployeeAdd>{
  //Define Variable
  final TextEditingController _name = TextEditingController();
  final TextEditingController _salary = TextEditingController();
  final TextEditingController _age = TextEditingController();

  FocusNode salaryNode = FocusNode();
  FocusNode ageNode = FocusNode();

  bool _isLoading = false;
  final snackbarKey = GlobalKey<ScaffoldState>();

  void submit(BuildContext context){
    //Save Data Progress
    if(!_isLoading){
      setState(() {
        _isLoading = true;
      });
      Provider.of<EmployeeProvider>(context, listen: false)
          .storeEmployee(_name.text, _salary.text, _age.text)
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
        title: Text('Add Employee'),
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
            //1. Imput Form
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