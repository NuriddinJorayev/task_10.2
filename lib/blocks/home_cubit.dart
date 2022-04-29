import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_block/Temp/temp_user.dart';
import 'package:last_block/blocks/home_state.dart';
import 'package:last_block/models/user.dart';
import 'package:last_block/services/retrofit_net.dart';

class Home_Cubit extends Cubit<Home_state> {
  Home_Cubit() : super(Home_state(false, [], 0));

  initialize() async {
    print("initialize");
    _changer(load: true);
    var data = await RestClient(Dio()).getTask();

    _changer(load: false, list: data, count: data.length);
  }

  Future<void> Delete(int index, User u) async {
    var list = state.base_list;
    list.removeAt(index);
    _changer(load: false, list: list, count: list.length);
    await RestClient(Dio()).Delete_task(u.id);
  }

  update_item(User u) {
    Temp_user.last_updated_user = u;
    int i = -1;
    for (var e in super.state.base_list) {
      if (e.id == u.id) {
        e = u;
        i++;
        break;
      }
      i++;
    }
    print("i = $i");
    super.state.base_list[i] = u;
    _changer();
  }

  add_user(User u) {
    state.base_list.add(u);
    _changer(count: state.count + 1);
  }

  _changer({bool load = false, List<User>? list, int? count}) {
    emit(Home_state(
        load, list ?? super.state.base_list, count ?? super.state.count));
  }
}
