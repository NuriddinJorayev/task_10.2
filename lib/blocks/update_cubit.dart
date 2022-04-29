import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:last_block/blocks/update_state.dart';
import 'package:last_block/models/user.dart';
import 'package:last_block/services/retrofit_net.dart';

class Update_cubit extends Cubit<Update_state> {
  Update_cubit()
      : super(Update_state(title: "title", body: "body", isloading: false));

  Future<String> Update_user(User u) async {
    _changer(isloading: true);
    var data = await RestClient(Dio()).Update_task(u.id, u);
    _changer(isloading: false);
    return data;
  }

  _changer({bool isloading = false, String? ti, String? bo}) {
    emit(Update_state(
        title: ti ?? super.state.title,
        body: bo ?? super.state.body,
        isloading: isloading));
  }
}
