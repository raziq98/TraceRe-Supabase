import 'package:flutter_application_1/model/work_type.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class WorkTypeService {
  final supabase = Supabase.instance.client;

  Future<List<WorkType>> retrieveList() async {
    final temp = await supabase.from('work_type').select('*');
    List<WorkType> employeeList = temp.map((e) => WorkType.fromJson(e)).toList();
    return employeeList;
  }
}
