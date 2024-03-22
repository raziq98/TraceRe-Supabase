import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/company.dart';

class CompanyService{
  final supabase = Supabase.instance.client;

  Future<Company?> retrieveCompany() async {
    final temp = await supabase.from('company').select('*,branches(*)').single();
    Company employeeList = Company.fromJson(temp);
    return employeeList;
  }
}