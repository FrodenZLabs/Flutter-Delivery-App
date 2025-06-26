import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@injectable
class NavbarCubit extends Cubit<int> {
  final PageController controller = PageController();

  NavbarCubit() : super(0);

  void update(int value) {
    controller.animateToPage(
      value,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    emit(value);
  }

  @override
  Future<void> close() {
    controller.dispose(); // Clean up controller
    return super.close();
  }
}
