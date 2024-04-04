import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/holiday.dart';

class HolidayService {
  final supabase = Supabase.instance.client;

  Future<List<Holiday>> retrieveHolidayList() async {
    final temp = await supabase.from('holiday').select('id,name,start_from,end_at,day_amount,description');
    print(temp);
    List<Holiday> holidayList = temp.map((e) => Holiday.fromJson(e)).toList();
    return holidayList;
  }

  Future<Holiday?> retrieveHolidayItem(int holidayId) async {
    final temp =
        await supabase.from('holiday').select('*').eq('id', holidayId).single();
    return Holiday.fromJson(temp);
  }

  Future<void> insertNewHoliday(dynamic temp) async {
    await supabase.from('holiday').insert(temp);
  }

  Future<void> updateHoliday(int holidayId, dynamic temp) async {
    await supabase.from('holiday').update(temp).match({'id': holidayId});
  }

  Future<void> deleteHoliday(int holidayId) async {
    await supabase.from('holiday').delete().match({'id': holidayId});
  }
}
