// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Update_state extends Equatable {
  final String title;
  final String body;
  final bool isloading;
  Update_state(
      {required this.title, required this.body, required this.isloading});

  @override
  List<Object?> get props => [this.title, this.body, this.isloading];
}
