import 'package:flutter/material.dart';
import 'package:janssen_cusomer_service/Ui/users/utiles/enums.dart';

extension Permition on Widget {
  Widget permition(BuildContext context, UserPermition permition) {
    return permitionss(context, permition) ? this : const SizedBox();
  }
}

bool permitionss(BuildContext context, UserPermition permition) {
  var test = [];
  // context
  //     .read<Users_controller>()
  //     .currentuser!
  //     .permitions
  //     .where((e) => e == permition.getTitle || e == "show_all");

  if (test.isNotEmpty) {
    return true;
  } else {
    return false;
  }
}
