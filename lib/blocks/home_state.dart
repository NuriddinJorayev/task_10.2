import 'package:equatable/equatable.dart';
import 'package:last_block/models/user.dart';

class Home_state extends Equatable {
  final bool isLoading;
  final List<User> base_list;
  final int count;

  Home_state(this.isLoading, this.base_list, this.count);

  @override
  List<Object?> get props => [base_list, isLoading, count];
}
