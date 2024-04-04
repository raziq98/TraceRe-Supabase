import 'package:flutter_application_1/model/setting_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingService {
  final supabase = Supabase.instance.client;

  Future<SettingModels> retrieveSetting(int? companyId,int? branchId) async {
    final PostgrestMap temp;
    if (companyId != null) {
      temp= await supabase
          .from('settings')
          .select('*')
          .match({'company_id': companyId}).single();
    }else if(branchId!= null){
      temp= await supabase
          .from('settings')
          .select('*')
          .match({'branch_id': branchId}).single();
    }else if(branchId!= null && companyId !=null){
      temp= await supabase
          .from('settings')
          .select('*')
          .match({'branch_id': branchId,'company_id':companyId}).single();
    } else{
      temp= await supabase
          .from('settings')
          .select('*')
          .match({'id': 1}).single();
    }
    return SettingModels.fromJson(temp);
  }

  Future<void> updateSetting(int settingId, Map<String, dynamic> temp) async {
    await supabase.from('settings').update(temp).match({'id': settingId});
  }

  Future<void> createSetting(Map<String, dynamic> temp) async {
    await supabase.from('settings').insert(temp);
  }
}