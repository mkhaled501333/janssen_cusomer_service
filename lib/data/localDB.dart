// ignore_for_file: non_constant_identifier_names, file_names

import 'package:hive/hive.dart';
import 'package:janssen_cusomer_service/data/networkDB.dart';
import 'package:janssen_cusomer_service/models/customer.dart';
import 'package:janssen_cusomer_service/models/governomates.dart';
import 'package:janssen_cusomer_service/models/models.dart';
import 'package:janssen_cusomer_service/models/ticket.dart';

class HiveDB extends ServerDB {
  Box<CustomerModel> customers = Hive.box<CustomerModel>("customers");
  Box<ProdcutsModel> prodcuts = Hive.box<ProdcutsModel>("prodcuts");
  Box<CallTypeModel> callTypes = Hive.box<CallTypeModel>("callTypes");
  Box<ReqReasons> reqreasons = Hive.box<ReqReasons>("reqreasons");
  Box<governomate> governamates = Hive.box<governomate>("governomates");
  List<TicketModel> get tickets =>
      customers.values.expand((e) => e.tickets).toList();

  addtogovernomates(governomate gover) {
    // print(value);
    Hive.box<governomate>("governomates").put(gover.id.toString(), gover);
    Hive.box<governomate>("pendinggovernomates").put(gover.id.toString(), gover);
     Refresh_UI();
  }

  addtttt(Map<String, List<String>> g) {
    int i = 0;
    Hive.box<governomate>("governomates").clear();
    for (var element in g.entries) {
      i++;print(i);
       Hive.box<governomate>("governomates")
        .put(i.toString(), governomate(id: i, governo: element.key, cityies: element.value));
       Hive.box<governomate>("pendinggovernomates")
        .put(i.toString(), governomate(id: i, governo: element.key, cityies: element.value));
    }
  
  }

  addtoCustomers(CustomerModel cuctomer) {
    Hive.box<CustomerModel>("customers")
        .put(cuctomer.customer_ID.toString(), cuctomer);
    Hive.box<CustomerModel>("pendingCustomers")
        .put(cuctomer.customer_ID.toString(), cuctomer);

    shosenCustomer = cuctomer;
    if (cuctomer.tickets.isNotEmpty) {
      chosenTicket = cuctomer.tickets.first;
    }
    Refresh_UI();
  }

  updatecustomer(CustomerModel cuctomer) {
    Hive.box<CustomerModel>("customers")
        .put(cuctomer.customer_ID.toString(), cuctomer);
    Hive.box<CustomerModel>("pendingCustomers")
        .put(cuctomer.customer_ID.toString(), cuctomer);
    notifyListeners();
  }

  addProdcuts(ProdcutsModel p) {
    Hive.box<ProdcutsModel>("prodcuts").put(p.id.toString(), p);
    Hive.box<ProdcutsModel>("pendingprodcuts").put(p.id.toString(), p);
    notifyListeners();
  }

  addcallType(CallTypeModel calltype) {
    Hive.box<CallTypeModel>("callTypes").put(calltype.id.toString(), calltype);
    Hive.box<CallTypeModel>("pendincallTypes")
        .put(calltype.id.toString(), calltype);
    notifyListeners();
  }

  addreqreason(ReqReasons calltype) {
    Hive.box<ReqReasons>("reqreasons").put(calltype.id.toString(), calltype);
    Hive.box<ReqReasons>("pendingreqreason")
        .put(calltype.id.toString(), calltype);
    notifyListeners();
  }

  void Refresh_UI() {
    notifyListeners();
  }

  String? x = 'طلب صيانه';
  List<String> areas = [];
  List<String> ticketsNums = [];
  List<String> ticketstatus = [];
  List<String> visiteds = [];
  List<String> Types = [];
  List<String> chosenActions = [];
  List<String> Pulleds = [];
  List<String> deleverd = [];
  String selectedReport = '';
  DateTime? pickedDateFrom;
  DateTime? pickedDateTO;
  List<DateTime> AllDatesOfOfData() {
    return [];
    // tickets.expand((e) => e.actions).map((d) => d.when).toList();
  }
}
