// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:janssen_cusomer_service/Ui/recourses/widgets.dart';
import 'package:janssen_cusomer_service/main.dart';
import 'package:janssen_cusomer_service/models/customer.dart';
import 'package:janssen_cusomer_service/models/governomates.dart';
import 'package:janssen_cusomer_service/models/models.dart';
import 'package:janssen_cusomer_service/models/ticket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

bool done = false;
// String ip = '192.168.1.16';
// String ip = '192.168.1.77';
String ip = '10.171.253.202';

class ServerDB extends ChangeNotifier {
  late WebSocketChannel customerchannel;
  late WebSocketChannel prodcutchannel;
  late WebSocketChannel calltypechannel;
  late WebSocketChannel reqreasonchannel;
  late WebSocketChannel governomanteschannel;

  CustomerModel? shosenCustomer;
  TicketModel? chosenTicket;

  Future<void> SendPending_GetAll_ConnectAndListenchannels() async {
    print(2);

    while (done == false) {
      await Future.delayed(const Duration(seconds: 1));
      if (isserveronline == true) {
        Uri a = Uri.http('$ip:8080', '/records');
        //sen pending
        for (var element
            in Hive.box<CustomerModel>("pendingCustomers").values) {
          await http.put(a, body: element.toJson()).then((e) {
            if (e.statusCode == 200) {
              Hive.box<CustomerModel>("pendingCustomers")
                  .delete(element.customer_ID.toString());
            }
          });
        }
        // recevie updates
        Hive.box<CustomerModel>("customers").clear();
        await http
            .get(
          a,
        )
            .then((onValue) {
          for (var element in json.decode(onValue.body) as List) {
            final item = CustomerModel.fromMap(element);
            Hive.box<CustomerModel>("customers")
                .put(item.customer_ID.toString(), item);
          }
        });
        Uri b = Uri.http('$ip:8080', '/calltypes');

        //sen pending
        for (var element in Hive.box<CallTypeModel>("pendincallTypes").values) {
          await http.put(b, body: element.toJson()).then((e) {
            if (e.statusCode == 200) {
              Hive.box<CallTypeModel>("pendincallTypes")
                  .delete(element.id.toString());
            }
          });
        }
        // recevie updates
        Hive.box<CallTypeModel>("callTypes").clear();
        await http
            .get(
          b,
        )
            .then((onValue) {
          for (var element in json.decode(onValue.body) as List) {
            final item = CallTypeModel.fromMap(element);
            Hive.box<CallTypeModel>("callTypes").put(item.id.toString(), item);
          }
        });
        Uri c = Uri.http('$ip:8080', '/prodcuts');

        //sen pending
        for (var element in Hive.box<ProdcutsModel>("pendingprodcuts").values) {
          await http.put(c, body: element.toJson()).then((e) {
            if (e.statusCode == 200) {
              Hive.box<ProdcutsModel>("pendingprodcuts")
                  .delete(element.id.toString());
            }
          });
        }

        // recevie updates
        Hive.box<ProdcutsModel>("prodcuts").clear();
        await http
            .get(
          c,
        )
            .then((onValue) {
          for (var element in json.decode(onValue.body) as List) {
            final item = ProdcutsModel.fromMap(element);
            Hive.box<ProdcutsModel>("prodcuts").put(item.id.toString(), item);
          }
        });
        Uri d = Uri.http('$ip:8080', '/reqreason');
        //sen pendingreqreason
        for (var element in Hive.box<ReqReasons>("pendingreqreason").values) {
          await http.put(d, body: element.toJson()).then((e) {
            if (e.statusCode == 200) {
              Hive.box<ReqReasons>("pendingreqreason")
                  .delete(element.id.toString());
            }
          });
        }
        // recevie updates
        Hive.box<ReqReasons>("reqreasons").clear();
        await http.get(d,).then((onValue) {
          for (var element in json.decode(onValue.body) as List) {
            final item = ReqReasons.fromMap(element);
            Hive.box<ReqReasons>("reqreasons").put(item.id.toString(), item);
          }
        });
        Uri f = Uri.http('$ip:8080', '/governomates');
        // sen pendingreqreason
        for (var element in Hive.box<governomate>("pendinggovernomates").values) {
          await http.put(f, body: element.toJson()).then((e) {
            if (e.statusCode == 200) {print('1111111111111111111111111111');
              Hive.box<governomate>("pendinggovernomates")
                  .delete(element.id.toString());
            }
          });
        }
        // recevie updates
        Hive.box<governomate>("governomates").clear();
        await http.get(f,).then((onValue) {
          for (var element in json.decode(onValue.body) as List) {
            final item = governomate.fromMap(element);
            Hive.box<governomate>("governomates").put(item.id.toString(), item);
          }
        });

        done = true;
        notifyListeners();
        connect_listen_chanel();
      }
    }
  }

  connect_listen_chanel() {
    Uri a = Uri.parse('ws://$ip:8080/records/ws')
        .replace(queryParameters: {'username': sharedPrefs.getString('email')});
    Uri b = Uri.parse('ws://$ip:8080/calltypes/ws')
        .replace(queryParameters: {'username': sharedPrefs.getString('email')});
    Uri c = Uri.parse('ws://$ip:8080/prodcuts/ws')
        .replace(queryParameters: {'username': sharedPrefs.getString('email')});
    Uri d = Uri.parse('ws://$ip:8080/reqreason/ws')
        .replace(queryParameters: {'username': sharedPrefs.getString('email')});
    Uri f = Uri.parse('ws://$ip:8080/governomates/ws')
        .replace(queryParameters: {'username': sharedPrefs.getString('email')});

    customerchannel = WebSocketChannel.connect(a);
    calltypechannel = WebSocketChannel.connect(b);
    prodcutchannel = WebSocketChannel.connect(c);
    reqreasonchannel = WebSocketChannel.connect(d);
    governomanteschannel = WebSocketChannel.connect(f);
    //listen to channel
    customerchannel.stream.forEach((u) {
      CustomerModel item = CustomerModel.fromJson(u);
      Hive.box<CustomerModel>("customers")
          .put(item.customer_ID.toString(), item);
      if (shosenCustomer != null &&
          (item.customer_ID == shosenCustomer!.customer_ID)) {
        shosenCustomer = item;
        if (chosenTicket != null) {
          chosenTicket = item.tickets
              .firstWhere((e) => e.ticket_ID == chosenTicket!.ticket_ID);
        }
      }
      notifyListeners();
      print("get channel $item");
    });
    calltypechannel.stream.forEach((u) {
      CallTypeModel item = CallTypeModel.fromJson(u);
      Hive.box<CallTypeModel>("callTypes").put(item.id.toString(), item);
      print("get channel $item");
    });
    prodcutchannel.stream.forEach((u) {
      ProdcutsModel item = ProdcutsModel.fromJson(u);
      Hive.box<ProdcutsModel>("prodcuts").put(item.id.toString(), item);
      print("get channel $item");
    });
   
    reqreasonchannel.stream.forEach((u) {
      ReqReasons item = ReqReasons.fromJson(u);
      Hive.box<ReqReasons>("reqreasons").put(item.id.toString(), item);
      print("get channel $item");
    });
 
   
    governomanteschannel.stream.forEach((u) {
      governomate item = governomate.fromJson(u);
      Hive.box<governomate>("governomates").put(item.id.toString(), item);
      print("get channel $item");
    });
 
 
    reconnectChannelAndSendPeinding();
  }

  Future<void> reconnectChannelAndSendPeinding() async {
    // reconnect channel
    while (true) {
      final i = await isServerOnline2();

      if (customerchannel.closeCode != null && i == true) {
        connect_listen_chanel();
      }
      await Future.delayed(const Duration(seconds: 1));
      //sen pending
      if (isserveronline == true) {
        for (var element
            in Hive.box<CustomerModel>("pendingCustomers").values) {
          customerchannel.sink.add(element.toJson());
          Hive.box<CustomerModel>("pendingCustomers")
              .delete(element.customer_ID.toString());
        }
        for (var element in Hive.box<ProdcutsModel>("pendingprodcuts").values) {
          prodcutchannel.sink.add(element.toJson());
          Hive.box<ProdcutsModel>("pendingprodcuts")
              .delete(element.id.toString());
        }
        for (var element in Hive.box<CallTypeModel>("pendincallTypes").values) {
          calltypechannel.sink.add(element.toJson());
          Hive.box<CallTypeModel>("pendincallTypes")
              .delete(element.id.toString());
        }
        for (var element in Hive.box<ReqReasons>("pendingreqreason").values) {
          reqreasonchannel.sink.add(element.toJson());
          Hive.box<ReqReasons>("pendingreqreason")
              .delete(element.id.toString());
        }
        for (var element in Hive.box<governomate>("pendinggovernomates").values) {
          governomanteschannel.sink.add(element.toJson());
          Hive.box<governomate>("pendinggovernomates")
              .delete(element.id.toString());print('2222222222222222222222');
        }
      }
    }
  }
}
