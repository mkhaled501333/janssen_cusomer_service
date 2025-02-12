// ignore_for_file: constant_identifier_names

enum UserPermition {
  show_all,
}

extension QQ on UserPermition {
  String get tittle {
    switch (this) {
      case UserPermition.show_all:
        return "show_all";
    }
  }
}
