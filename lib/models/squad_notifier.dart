import 'package:flutter/material.dart';

class SquadNotifier extends ChangeNotifier {
  bool reload;
  SquadNotifier(this.reload);

  void reloadSquad() {
    reload = true;

    notifyListeners();
  }
}
