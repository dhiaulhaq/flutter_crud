import 'package:flutter/material.dart';
import '../models/employee_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EmployeeProvider extends ChangeNotifier{
  List <EmployeeModel> _data = [];
  List<EmployeeModel> get dataEmployee => _data;

  Future<List<EmployeeModel>> getEmployee() async{
    final url = 'http://employee-crud-flutter.daengweb.id/index.php';
    final response = await http.get(url);

    if(response.statusCode == 200){
      final result = json.decode(response.body)['data'].cast<Map<String, dynamic>>();
      _data = result.map<EmployeeModel>((json) => EmployeeModel.fromJson(json)).toList();
      return _data;
    }else{
      throw Exception();
    }
  }
}