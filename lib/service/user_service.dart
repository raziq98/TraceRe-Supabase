import 'package:supabase_flutter/supabase_flutter.dart';

class UserService {
  final supabase = Supabase.instance.client;

  Future<User?> retrieveCurrentUser(int currentUserId)async{
    final temp =await supabase.from('user').select('*').eq('id', currentUserId).single();
    return User.fromJson(temp);
  }
}