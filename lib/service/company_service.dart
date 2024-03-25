import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/company.dart';

class CompanyService {
  final supabase = Supabase.instance.client;

  Future<Company?> retrieveCompany() async {
    final temp =
        await supabase.from('company').select('*,branches(*)').single();
    Company employeeList = Company.fromJson(temp);
    return employeeList;
  }

  Future<void> updateCompany(int companyId, dynamic temp) async {
    try {
      await supabase.from('company').update(temp).match({'id': companyId});
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateBranch(int branchId, dynamic temp) async {
    try {
      await supabase.from('branches').update(temp).match({'id': branchId});
    } catch (e) {
      print('error update existing branch: $e');
    }
  }

  Future<void> insertNewBranch(dynamic temp) async {
    try {
      await supabase.from('branches').insert(temp);
    } catch (e) {
      print('error insert new branch: $e');
    }
  }
}
