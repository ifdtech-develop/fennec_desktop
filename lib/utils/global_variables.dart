import 'package:fennec_desktop/main.dart';

String teamName = "";
int teamId = 1;

void getTeam() {
  if (prefs.getString('teamName') == null) {
    teamName = "";
    teamId = 1;
  } else {
    teamName = prefs.getString('teamName')!;
    teamId = prefs.getInt('teamId')!;
  }
}
