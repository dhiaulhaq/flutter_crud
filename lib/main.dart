import 'package:flutter/material.dart';
import 'package:flutter_crud/providers/employee_provider.dart';
import 'package:provider/provider.dart';
import './pages/employee.dart';
import './providers/employee_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => EmployeeProvider(),
        ),
      ],
      child: MaterialApp(
        home: Employee(),
      ),
    );
  }
}
