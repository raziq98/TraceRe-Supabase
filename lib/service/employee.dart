import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/user.dart';

class EmployeeService {
  final supabase = Supabase.instance.client;

  Future<List<Users?>> retrieveEmployeeList() async {
    final temp = await supabase.from('users').select('*');
    List<Users?> employeeList = temp.map((e) => Users.fromJson(e)).toList();
    return employeeList;
  }

  Future<Users?> retrieveEmployeeItem(int employeeId) async {
    final temp =
        await supabase.from('users').select('*').eq('id', employeeId).single();
    return Users.fromJson(temp);
  }

  Future<void> insertNewEmployee(dynamic temp) async {
    await supabase.from('users').insert(temp);
  }

  Future<void> updatEmployee(int employeeId, dynamic temp) async {
    await supabase.from('users').update(temp).match({'id': employeeId});
  }

  Future<void> deleteEmployee(int employeeId) async {
    await supabase.from('users').delete().match({'id': employeeId});
  }
}
