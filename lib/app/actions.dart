import 'package:janssen_cusomer_service/Ui/recourses/constants.dart';
import 'package:janssen_cusomer_service/models/models.dart';

enum UserAction {
  creat_user,
}

extension Q12 on UserAction {
  ActionModel get add {
    switch (this) {
      case UserAction.creat_user:
        return ActionModel(
            action: "creat_user", who: username, when: DateTime.now());
    }
  }

  String get getTitle {
    switch (this) {
      case UserAction.creat_user:
        return "creat_user";
    }
  }
}

enum TicketAction {
  creat_NewTicket,
  Ticket_Resolved,
  archive_Ticket,
  change_ticket_type,
}

extension Asd on TicketAction {
  ActionModel get add {
    switch (this) {
      case TicketAction.creat_NewTicket:
        return ActionModel(
            action: "creat_NewTicket", who: username, when: DateTime.now());
      case TicketAction.Ticket_Resolved:
        return ActionModel(
            action: "Ticket_Resolved", who: username, when: DateTime.now());
      case TicketAction.archive_Ticket:
        return ActionModel(
            action: "archive_Ticket", who: username, when: DateTime.now());
      case TicketAction.change_ticket_type:
        return ActionModel(
            action: "change_ticket_type", who: username, when: DateTime.now());
    }
  }

  String get getTitle {
    switch (this) {
      case TicketAction.creat_NewTicket:
        return "creat_NewTicket";
      case TicketAction.Ticket_Resolved:
        return "Ticket_Resolved";
      case TicketAction.archive_Ticket:
        return "archive_Ticket";
      case TicketAction.change_ticket_type:
        return "change_ticket_type";
    }
  }
}

enum MaintainanceRequestAction {
  creat_NewRequest,
  visited,
  replaceToSameProdcut,
  replaceToAnotherProdcut,
  maintanance,
  ch1Agree,
  ch1disdisAgree,
  ch2Agree,
  ch2disdisAgree,
  ch3Agree,
  ch3disdisAgree,
  ch4Agree,
  ch4disdisAgree,
  pulled1,
  deleverd1,
  pulled2,
  deleverd2,
  pulled3,
  deleverd3,
}

extension Q13 on MaintainanceRequestAction {
  ActionModel get add {
    switch (this) {
      case MaintainanceRequestAction.creat_NewRequest:
        return ActionModel(
            action: "creat_NewRequest", who: username, when: DateTime.now());
      case MaintainanceRequestAction.visited:
        return ActionModel(
            action: "visited", who: username, when: DateTime.now());
      case MaintainanceRequestAction.replaceToSameProdcut:
        return ActionModel(
            action: "replaceToSameProdcut",
            who: username,
            when: DateTime.now());
      case MaintainanceRequestAction.replaceToAnotherProdcut:
        return ActionModel(
            action: "replaceToAnotherProdcut",
            who: username,
            when: DateTime.now());
      case MaintainanceRequestAction.maintanance:
        return ActionModel(
            action: "maintanance", who: username, when: DateTime.now());
      case MaintainanceRequestAction.ch1Agree:
        return ActionModel(
            action: "ch1Agree", who: username, when: DateTime.now());
      case MaintainanceRequestAction.ch1disdisAgree:
        return ActionModel(
            action: "ch1disdisAgree", who: username, when: DateTime.now());
      case MaintainanceRequestAction.ch2disdisAgree:
        return ActionModel(
            action: "ch2disdisAgree", who: username, when: DateTime.now());
      case MaintainanceRequestAction.ch3Agree:
        return ActionModel(
            action: "ch3Agree", who: username, when: DateTime.now());
      case MaintainanceRequestAction.ch3disdisAgree:
        return ActionModel(
            action: "ch3disdisAgree", who: username, when: DateTime.now());
      case MaintainanceRequestAction.ch4Agree:
        return ActionModel(
            action: "ch4Agree", who: username, when: DateTime.now());
      case MaintainanceRequestAction.ch4disdisAgree:
        return ActionModel(
            action: "ch4disdisAgree", who: username, when: DateTime.now());

      case MaintainanceRequestAction.ch2Agree:
        return ActionModel(
            action: "ch2Agree", who: username, when: DateTime.now());
      case MaintainanceRequestAction.pulled1:
        return ActionModel(
            action: "pulled1", who: username, when: DateTime.now());
      case MaintainanceRequestAction.deleverd1:
        return ActionModel(
            action: "deleverd1", who: username, when: DateTime.now());
      case MaintainanceRequestAction.pulled2:
        return ActionModel(
            action: "pulled2", who: username, when: DateTime.now());
      case MaintainanceRequestAction.deleverd2:
        return ActionModel(
            action: "deleverd2", who: username, when: DateTime.now());
      case MaintainanceRequestAction.pulled3:
        return ActionModel(
            action: "pulled3", who: username, when: DateTime.now());
      case MaintainanceRequestAction.deleverd3:
        return ActionModel(
            action: "deleverd3", who: username, when: DateTime.now());
    }
  }

  String get getTitle {
    switch (this) {
      case MaintainanceRequestAction.creat_NewRequest:
        return "creat_NewRequest";
      case MaintainanceRequestAction.visited:
        return "visited";
      case MaintainanceRequestAction.replaceToSameProdcut:
        return "replaceToSameProdcut";
      case MaintainanceRequestAction.replaceToAnotherProdcut:
        return "replaceToAnotherProdcut";
      case MaintainanceRequestAction.ch1Agree:
        return "ch1Agree";

      case MaintainanceRequestAction.ch1disdisAgree:
        return "ch1disdisAgree";

      case MaintainanceRequestAction.ch2Agree:
        return "ch2Agree";

      case MaintainanceRequestAction.ch2disdisAgree:
        return "ch2disdisAgree";

      case MaintainanceRequestAction.ch3Agree:
        return "ch3Agree";
      case MaintainanceRequestAction.ch3disdisAgree:
        return "ch3disdisAgree";
      case MaintainanceRequestAction.ch4Agree:
        return "ch4Agree";
      case MaintainanceRequestAction.ch4disdisAgree:
        return "ch4disdisAgree";

      case MaintainanceRequestAction.maintanance:
        return "maintanance";
      case MaintainanceRequestAction.pulled1:
        return "pulled1";
      case MaintainanceRequestAction.deleverd1:
        return "deleverd1";
      case MaintainanceRequestAction.pulled2:
        return "pulled2";
      case MaintainanceRequestAction.deleverd2:
        return "deleverd2";
      case MaintainanceRequestAction.pulled3:
        return "pulled3";
      case MaintainanceRequestAction.deleverd3:
        return "deleverd3";
    }
  }
}

enum ProdcutsAction {
  archive,
}

extension Q1222 on ProdcutsAction {
  ActionModel get add {
    switch (this) {
      case ProdcutsAction.archive:
        return ActionModel(
            action: "archive", who: username, when: DateTime.now());
    }
  }

  String get getTitle {
    switch (this) {
      case ProdcutsAction.archive:
        return "archive";
    }
  }
}

enum CallTypeAction {
  archive,
}

extension Dertyj on CallTypeAction {
  ActionModel get add {
    switch (this) {
      case CallTypeAction.archive:
        return ActionModel(
            action: "archive", who: username, when: DateTime.now());
    }
  }

  String get getTitle {
    switch (this) {
      case CallTypeAction.archive:
        return "archive";
    }
  }
}

enum ReaReasonAction {
  archive,
}

extension Dertyjdd on ReaReasonAction {
  ActionModel get add {
    switch (this) {
      case ReaReasonAction.archive:
        return ActionModel(
            action: "archive", who: username, when: DateTime.now());
    }
  }

  String get getTitle {
    switch (this) {
      case ReaReasonAction.archive:
        return "archive";
    }
  }
}
