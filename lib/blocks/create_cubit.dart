import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:last_block/Temp/temp_user.dart';
import 'package:last_block/blocks/create_state.dart';
import 'package:last_block/models/user.dart';
import 'package:last_block/services/retrofit_net.dart';

class Create_cubit extends Cubit<Create_state> {
  Create_cubit() : super(Create_state(isLoading: false, tapable: true));

  Future<User> Create_user(String title, String body) async {
    emit(Create_state(isLoading: true, tapable: true));
    var u = User(id: "0", title: title, body: body);
    Temp_user.last_added_user = u;
    var d = await RestClient(Dio()).create_task(u);
    u.id = jsonDecode(d)['id'];
    print('u id ch = ${u.id}');
    emit(Create_state(isLoading: false, tapable: false));
    return u;
  }
}
