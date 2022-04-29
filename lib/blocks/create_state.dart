import 'package:equatable/equatable.dart';

class Create_state extends Equatable {
  final bool isLoading;
  final bool tapable;
  Create_state({required this.tapable, required this.isLoading});
  @override
  List<Object?> get props => [this.isLoading];
}
