// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:janssen_cusomer_service/app/actions.dart';
import 'package:janssen_cusomer_service/models/customer.dart';
import 'package:janssen_cusomer_service/models/models.dart';
import 'package:janssen_cusomer_service/models/ticket.dart';

extension Toint on String {
  int to_int() {
    return int.tryParse(this) ?? 0;
  }

  double to_double() {
    return double.parse(this);
  }
}

extension Brovider on BuildContext {
  gonext(BuildContext context, Widget route) {
    // checkAuth(context);
    Navigator.of(this).push(MaterialPageRoute(builder: (context) => route));
  }

  gonextAnsRemove(BuildContext context, Widget route) {
    Navigator.of(this).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => route), (d) => false);
  }
}

extension Dsd on DateTime {
  String formatt_yMd() {
    String formateeddate = DateFormat('dd-MM-yyyy').format(this);
    return formateeddate;
  }

  String formatt_yMd_hms() {
    String formateeddate = DateFormat('dd-MM-yyyy hh:mm a').format(this);
    return formateeddate;
  }

  int formatt_int() {
    String formateeddate = DateFormat('yyyyMMdd').format(this);
    return formateeddate.to_int();
  }

  String formatt_hms() {
    String formateeddate = DateFormat('hh:mm:ss a').format(this);
    return formateeddate;
  }
}

extension D34 on List<CustomerModel> {
  List<CustomerModel> filterItemsPasedOngovernomates(
      BuildContext context, List<String> governomates) {
    List<CustomerModel> l = [];
    if (governomates.isNotEmpty) {
      for (var f in governomates) {
        for (var i in this) {
          if (i.covernorate.toString() == f) {
            l.add(i);
          }
        }
      }
      return l;
    } else {
      return this;
    }
  }

  List<CustomerModel> filterItemsPasedOnareas(
      BuildContext context, List<String> areas) {
    List<CustomerModel> l = [];
    if (areas.isNotEmpty) {
      for (var f in areas) {
        for (var i in this) {
          if (i.area.toString() == f) {
            l.add(i);
          }
        }
      }
      return l;
    } else {
      return this;
    }
  }
}

extension G55 on List<TicketModel> {
  List<TicketModel> filterDateBetween(DateTime from, DateTime to) {
    return where((e) =>
        e.actions
                .get_Date_of_action(TicketAction.creat_NewTicket.getTitle)
                .formatt_int() >=
            from.formatt_int() &&
        e.actions
                .get_Date_of_action(TicketAction.creat_NewTicket.getTitle)
                .formatt_int() <=
            to.formatt_int()).toList();
  }





  List<TicketModel> filterDatefrom(
    DateTime? from,
  ) {
    if (from == null) {
      return this;
    } else {
 
      return where((e) =>
          e.datecreated.formatt_int()>=
          from.formatt_int()).toList();
    }
  }
  List<TicketModel> filterDateTo(
    DateTime? to,
  ) {
    if (to == null) {
      return this;
    } else {

      return where((e) =>
          e.datecreated.formatt_int()<=
          to.formatt_int()).toList();
    }
  }




  List<TicketModel> filterItemsPasedActionType(
      BuildContext context, List<String> actions) {
    List<TicketModel> t = [];
    if (actions.isNotEmpty) {
      for (var f in actions) {
        for (var i in this) {
          i.requests.where((r) {
            if (f == 'استبدال لنفس النوع') {
              return r.replaceToSameModel == true;
            } else if (f == 'استبدال لنوع اخر') {
              return r.replaceTosnotherModel == true;
            } else {
              return r.maintainace == true;
            }
          }).isNotEmpty
              ? t.add(i)
              : DoNothingAction();
        }
      }
      return t;
    } else {
      return this;
    }
  }

  List<TicketModel> filterItemsPasedProdcutType(
      BuildContext context, List<String> Types) {
    List<TicketModel> t = [];
    if (Types.isNotEmpty) {
      for (var f in Types) {
        for (var i in this) {
          i.requests.where((r) {
            return r.pfodcut.ProdcutType == f;
          }).isNotEmpty
              ? t.add(i)
              : DoNothingAction();
        }
      }
      return t;
    } else {
      return this;
    }
  }

  List<TicketModel> filterItemsPasedVisited(
      BuildContext context, List<String> actions) {
    List<TicketModel> t = [];
    if (actions.isNotEmpty) {
      for (var f in actions) {
        for (var i in this) {
          i.requests.where((r) {
            if (f == 'تم المعاينه') {
              return r.visited == true;
            } else {
              return r.visited == false;
            }
          }).isNotEmpty
              ? t.add(i)
              : DoNothingAction();
        }
      }
      return t;
    } else {
      return this;
    }
  }

  List<TicketModel> filterItemsPasedPulled(
      BuildContext context, List<String> pD) {
    List<TicketModel> t = [];
    if (pD.isNotEmpty) {
      for (var f in pD) {
        for (var i in this) {
          i.requests.where((r) {
            if (f == 'تم السحب') {
              return (r.replaceToSameModel == true && r.pulled1 == true) ||
                  (r.replaceTosnotherModel == true && r.pulled1 == true) ||
                  (r.maintainace == true && r.pulled3 == true);
            } else {
              return (r.replaceToSameModel == true && r.pulled1 == false) ||
                  (r.replaceTosnotherModel == true && r.pulled1 == false) ||
                  (r.maintainace == true && r.pulled3 == false);
            }
          }).isNotEmpty
              ? t.add(i)
              : DoNothingAction();
        }
      }
      return t;
    } else {
      return this;
    }
  }

  List<TicketModel> filterItemsPasedonDeleverd(
      BuildContext context, List<String> pD) {
    List<TicketModel> t = [];
    if (pD.isNotEmpty) {
      for (var f in pD) {
        for (var i in this) {
          i.requests.where((r) {
            if (f == 'تم التسليم') {
              return (r.replaceToSameModel == true && r.deleverd1 == true) ||
                  (r.replaceTosnotherModel == true && r.deleverd2 == true) ||
                  (r.maintainace == true && r.deleverd3 == true);
            } else {
              return (r.replaceToSameModel == true && r.deleverd1 == false) ||
                  (r.replaceTosnotherModel == true && r.deleverd2 == false) ||
                  (r.maintainace == true && r.deleverd3 == false);
            }
          }).isNotEmpty
              ? t.add(i)
              : DoNothingAction();
        }
      }
      return t;
    } else {
      return this;
    }
  }

  List<TicketModel> filterItemsPasedonTicketStatus(
      BuildContext context, List<String> status) {
    if (status.isNotEmpty) {
      if (status.where((h) => h == 'مفتوحه').isNotEmpty && status.length == 1) {
        return where((test) => test.Ticketresolved == false).toList();
      } else if (status.where((h) => h == 'مغلقه').isNotEmpty &&
          status.length == 1) {
        return where((test) => test.Ticketresolved == true).toList();
      } else {
        return this;
      }
    } else {
      return this;
    }
  }
}
