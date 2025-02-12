// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:janssen_cusomer_service/Ui/recourses/constants.dart';
import 'package:janssen_cusomer_service/app/actions.dart';
import 'package:janssen_cusomer_service/app/extentions.dart';

import 'package:janssen_cusomer_service/data/localDB.dart';
import 'package:janssen_cusomer_service/models/callinfo.dart';
import 'package:janssen_cusomer_service/models/customer.dart';
import 'package:janssen_cusomer_service/models/prodcutinfo.dart';
import 'package:janssen_cusomer_service/models/request.dart';
import 'package:janssen_cusomer_service/models/ticket.dart';
import 'package:provider/provider.dart';

class TEDcontrollers {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool validate() => formKey.currentState!.validate();

  TextEditingController TED_customerName = TextEditingController();
  TextEditingController TED_mobileNum = TextEditingController();
  TextEditingController TED_governomate = TextEditingController();
  TextEditingController TED_area = TextEditingController();
  TextEditingController TED_adress = TextEditingController();
  TextEditingController TED_productType = TextEditingController();
  get g => TED_productType.text;
  TextEditingController TED_ProdcutName = TextEditingController();
  TextEditingController TED_L = TextEditingController();
  TextEditingController TED_W = TextEditingController();
  TextEditingController TED_H = TextEditingController();
  TextEditingController TED_Quantity = TextEditingController();
  TextEditingController TED_purchePlace = TextEditingController();
  TextEditingController TED_purcheDate = TextEditingController();
  TextEditingController TED_TicketType = TextEditingController();
  TextEditingController TED_RequestReason = TextEditingController();
  TextEditingController TED_RequestReasonINDetails = TextEditingController();
  TextEditingController callType = TextEditingController();
  TextEditingController TED_callReason = TextEditingController();
  TextEditingController TED_callReasondetails = TextEditingController();
  TextEditingController TED_others = TextEditingController();
  TextEditingController TED_closeReason = TextEditingController();
  TextEditingController TED_callresult = TextEditingController();

  clearfields() {
    TED_customerName.clear();
    TED_governomate.clear();
  }

  closeTicket(BuildContext context) {
    final customer = context.read<HiveDB>().shosenCustomer!;
    final ticket = customer.tickets.firstWhere((e) => e.ticket_ID == context.read<HiveDB>().chosenTicket!.ticket_ID);
    ticket.Ticketresolved = true;
    ticket.colseReason = TED_closeReason.text;
    ticket.actions.add(TicketAction.Ticket_Resolved.add);
    context.read<HiveDB>().updatecustomer(customer);
  }

  UpdateTicketType(BuildContext context, String newType) {
    final customer = context.read<HiveDB>().shosenCustomer!;
    final ticket = context.read<HiveDB>().chosenTicket!;

    if (ticket.Ticketresolved == false) {
      ticket.TicketType = newType;
      customer.lastUpdated = DateTime.now().microsecondsSinceEpoch;
      context.read<HiveDB>().updatecustomer(customer);
    }
  }

//
  Add_NewCustomer_newTicket_newmantainceRequst(BuildContext context) {
    final customer = CustomerModel(
        cusotmerName: TED_customerName.text,
        customer_ID: DateTime.now().microsecondsSinceEpoch,
        mobilenum: [TED_mobileNum.text],
        covernorate: TED_governomate.text,
        area: TED_area.text,
        adress: TED_adress.text,
        clientStatus: '',
        tickets: [],
        calls: [],
        lastUpdated: DateTime.now().microsecondsSinceEpoch);
    final ticket = TicketModel(
      customer_ID: customer.customer_ID,
      requests: [],
      ticket_ID: DateTime.now().microsecondsSinceEpoch,
      ticket_Num: context.read<HiveDB>().tickets.length + 1,
      Ticketresolved: false,
      TicketType: 'طلب صيانه',
      datecreated: DateTime.now(),
      actions: [TicketAction.creat_NewTicket.add],
      notes: '',
      colseReason: '',
      others: '',
      calls: [],
    );
    final prodcut = ProductInfo(
        ID: DateTime.now().microsecondsSinceEpoch,
        ProdcutType: TED_productType.text,
        ProductName: TED_ProdcutName.text,
        L: TED_L.text.to_int(),
        W: TED_W.text.to_int(),
        H: TED_H.text.to_int(),
        Quantity: TED_Quantity.text.to_int(),
        PurcheLocation: TED_purchePlace.text,
        PurcheDate: DateTime.tryParse(TED_purcheDate.text) ?? DateTime(0));
//
    final requst = RequstesMolel(
        ticket_ID: ticket.ticket_ID,
        Request_ID: DateTime.now().microsecondsSinceEpoch,
        Request_serial: 0,
        pfodcut: prodcut,
        reqreqson: TED_RequestReason.text,
        reqreasonInDetails: TED_RequestReasonINDetails.text,

        // المعاينه
        visited: false,
        visitingdate: DateTime.utc(0),
        visitResult: '',
        choice1Accetp: false,
        choice1refuse: false,
        choice1refusereason: '',
// استبدال لنفس النوع
        replaceToSameModel: false,
        H2: '',
        L2: '',
        W2: '',
        cost1: 0,
        choice2Accetp: false,
        choice2refuse: false,
        choice2refusereason: '',
        deleverd1: false,
        pulled1: false,
        pulledDate1: DateTime(0),
        deleverdDate1: DateTime(0),
// استبدال لنوع الخر
        replaceTosnotherModel: false,
        replaceToBrandName: '',
        replaceToProdcutName: '',
        H3: '',
        L3: '',
        W3: '',
        cost2: 0,
        choice3Accetp: false,
        choice3refuse: false,
        choice3refusereason: '',
        deleverd2: false,
        pulled2: false,
        pulledDate2: DateTime(0),
        deleverdDate2: DateTime(0),
//صيانه
        maintainace: false,
        maintanancedescription: '',
        prductuionManagerdecision: '',
        choice4Accetp: false,
        choice4refuse: false,
        choice4refusereason: '',
        cost3: 0,
        finalDicition: '',
        deleverd3: false,
        pulled3: false,
        pulledDate3: DateTime(0),
        deleverdDate3: DateTime(0),
        actions: [],
        colsedMantananceReq: false,
        colsedMantananceReqreason: '');
    final call = CallInfo(
        Ticket_ID: ticket.ticket_ID,
        customer_ID: customer.customer_ID,
        CallInfo_ID: DateTime.now().microsecondsSinceEpoch,
        callSerial: 0,
        callRecipient: username,
        callDate: DateTime.now(),
        calltype: callType.text,
        callReason: TED_callReason.text,
        callresult: TED_callresult.text,
        callReasonINdetails: TED_callReasondetails.text,
        notes: "");
    ticket.calls.add(call);
    ticket.requests.add(requst);
    customer.tickets.add(ticket);

    if (formKey.currentState!.validate()) {
      context.read<HiveDB>().addtoCustomers(customer);
    }
  }

  addNewCustomer_Ticket_Others(BuildContext context) {
    final customer = CustomerModel(
        cusotmerName: TED_customerName.text,
        customer_ID: DateTime.now().microsecondsSinceEpoch,
        mobilenum: [TED_mobileNum.text],
        covernorate: TED_governomate.text,
        area: TED_area.text,
        adress: TED_adress.text,
        clientStatus: '',
        tickets: [],
        calls: [],
        lastUpdated: DateTime.now().microsecondsSinceEpoch);
    final ticket = TicketModel(
        customer_ID: customer.customer_ID,
        requests: [],
        ticket_ID: DateTime.now().microsecondsSinceEpoch,
        ticket_Num: context.read<HiveDB>().tickets.length + 1,
        Ticketresolved: false,
        TicketType: TED_TicketType.text,
        datecreated: DateTime.now(),
        actions: [TicketAction.creat_NewTicket.add],
        notes: '',
        colseReason: TED_others.text,
        others: '',
        calls: []);
    customer.tickets.add(ticket);
    if (formKey.currentState!.validate()) {
      context.read<HiveDB>().addtoCustomers(customer);
      TED_callReason.text = TED_others.text;
      addcall(context, 'وارد');
    }
  }

  addNewCustomerWithNewCall(BuildContext context) {
    final customer = CustomerModel(
        cusotmerName: TED_customerName.text,
        customer_ID: DateTime.now().microsecondsSinceEpoch,
        mobilenum: [TED_mobileNum.text],
        covernorate: TED_governomate.text,
        area: TED_area.text,
        adress: TED_adress.text,
        clientStatus: '',
        tickets: [],
        calls: [],
        lastUpdated: DateTime.now().microsecondsSinceEpoch);
    var call = CallInfo(
        Ticket_ID: 0,
        customer_ID: customer.customer_ID,
        callSerial: 0,
        CallInfo_ID: DateTime.now().microsecondsSinceEpoch,
        callRecipient: username,
        callDate: DateTime.now(),
        calltype: callType.text,
        callReason: TED_callReason.text,
        callresult: '',
        callReasonINdetails: TED_callReasondetails.text,
        notes: "");
    customer.calls.add(call);
    if (formKey.currentState!.validate()) {
      context.read<HiveDB>().addtoCustomers(customer);
    }
  }

//add new ticket for existing customer
  addTicket(BuildContext context) {
    final customer = context.read<HiveDB>().shosenCustomer!;
    final ticket = TicketModel(
        customer_ID: customer.customer_ID,
        requests: [],
        ticket_ID: DateTime.now().microsecondsSinceEpoch,
        ticket_Num: context.read<HiveDB>().tickets.length + 2,
        Ticketresolved: false,
        TicketType: 'طلب صيانه',
        datecreated: DateTime.now(),
        actions: [TicketAction.creat_NewTicket.add],
        notes: '',
        colseReason: '',
        others: '',
        calls: []);

    var call = CallInfo(
        Ticket_ID: ticket.ticket_ID,
        customer_ID: customer.customer_ID,
        callSerial: 0,
        CallInfo_ID: DateTime.now().microsecondsSinceEpoch,
        callRecipient: username,
        callDate: DateTime.now(),
        calltype: 'وارد',
        callReason: 'طلب صيانه',
        callresult: '',
        callReasonINdetails: TED_callReasondetails.text,
        notes: "");
    final prodcut = ProductInfo(
        ID: DateTime.now().microsecondsSinceEpoch,
        ProdcutType: TED_productType.text,
        ProductName: TED_ProdcutName.text,
        L: TED_L.text.to_int(),
        W: TED_W.text.to_int(),
        H: TED_H.text.to_int(),
        Quantity: TED_Quantity.text.to_int(),
        PurcheLocation: TED_purchePlace.text,
        PurcheDate: DateTime.tryParse(TED_purcheDate.text) ?? DateTime(0));
    final requst = RequstesMolel(
      ticket_ID: ticket.ticket_ID,
      Request_ID: DateTime.now().microsecondsSinceEpoch,
      Request_serial: 0,
      pfodcut: prodcut,
      reqreqson: TED_RequestReason.text,
      reqreasonInDetails: TED_RequestReasonINDetails.text,
      // المعاينه
      visited: false,
      visitingdate: DateTime.utc(0),
      visitResult: '',
      choice1Accetp: false,
      choice1refuse: false,
      choice1refusereason: '',
// استبدال لنفس النوع
      replaceToSameModel: false,
      H2: '',
      L2: '',
      W2: '',
      cost1: 0,
      choice2Accetp: false,
      choice2refuse: false,
      choice2refusereason: '',
      deleverd1: false,
      pulled1: false,
      pulledDate1: DateTime(0),
      deleverdDate1: DateTime(0),
// استبدال لنوع الخر
      replaceTosnotherModel: false,
      replaceToBrandName: '',
      replaceToProdcutName: '',
      H3: '',
      L3: '',
      W3: '',
      cost2: 0,
      choice3Accetp: false,
      choice3refuse: false,
      choice3refusereason: '',
      deleverd2: false,
      pulled2: false,
      pulledDate2: DateTime(0), deleverdDate2: DateTime(0),
//صيانه
      maintainace: false,
      maintanancedescription: '',
      prductuionManagerdecision: '',
      choice4Accetp: false,
      choice4refuse: false,
      choice4refusereason: '',
      cost3: 0,
      finalDicition: '',
      deleverd3: false,
      pulled3: false,
      pulledDate3: DateTime(0), deleverdDate3: DateTime(0),
      //
      colsedMantananceReq: false,
      colsedMantananceReqreason: '',
      actions: [],
    );

    ticket.calls.add(call);
    ticket.requests.add(requst);
    customer.tickets.add(ticket);
    if (formKey.currentState!.validate()) {
      context.read<HiveDB>().addtoCustomers(customer);
      TED_callReason.text = 'طلب صيانه';
      addcall(context, 'وارد');
    }
  }

  addrequest(BuildContext context) {
    final chosenTicket = context.read<HiveDB>().shosenCustomer!.tickets.firstWhere((test) => test.ticket_ID == context.read<HiveDB>().chosenTicket!.ticket_ID);
    final prodcut = ProductInfo(
        ID: DateTime.now().microsecondsSinceEpoch,
        ProdcutType: TED_productType.text,
        ProductName: TED_ProdcutName.text,
        L: TED_L.text.to_int(),
        W: TED_W.text.to_int(),
        H: TED_H.text.to_int(),
        Quantity: TED_Quantity.text.to_int(),
        PurcheLocation: TED_purchePlace.text,
        PurcheDate: DateTime.tryParse(TED_purcheDate.text) ?? DateTime(0));
    final requst = RequstesMolel(
        ticket_ID: chosenTicket.ticket_ID,
        Request_ID: DateTime.now().microsecondsSinceEpoch,
        Request_serial: 0,
        pfodcut: prodcut,
        reqreqson: TED_RequestReason.text,
        reqreasonInDetails: TED_RequestReasonINDetails.text,

        // المعاينه
        visited: false,
        visitingdate: DateTime.utc(0),
        visitResult: '',
        choice1Accetp: false,
        choice1refuse: false,
        choice1refusereason: '',
// استبدال لنفس النوع
        replaceToSameModel: false,
        H2: '',
        L2: '',
        W2: '',
        cost1: 0,
        choice2Accetp: false,
        choice2refuse: false,
        choice2refusereason: '',
        deleverd1: false,
        pulled1: false,
        pulledDate1: DateTime(0),
        deleverdDate1: DateTime(0),
// استبدال لنوع الخر
        replaceTosnotherModel: false,
        replaceToBrandName: '',
        replaceToProdcutName: '',
        H3: '',
        L3: '',
        W3: '',
        cost2: 0,
        choice3Accetp: false,
        choice3refuse: false,
        choice3refusereason: '',
        deleverd2: false,
        pulled2: false,
        pulledDate2: DateTime(0),
        deleverdDate2: DateTime(0),
//صيانه
        maintainace: false,
        maintanancedescription: '',
        prductuionManagerdecision: '',
        choice4Accetp: false,
        choice4refuse: false,
        choice4refusereason: '',
        cost3: 0,
        finalDicition: '',
        deleverd3: false,
        pulled3: false,
        pulledDate3: DateTime(0),
        deleverdDate3: DateTime(0),
        actions: [],
        colsedMantananceReq: false,
        colsedMantananceReqreason: '');

    if (formKey.currentState!.validate() && chosenTicket.Ticketresolved == false) {
      chosenTicket.requests.add(requst);

      context.read<HiveDB>().updatecustomer(context.read<HiveDB>().shosenCustomer!);
      Navigator.of(context).pop();
    }
  }

  addcall(BuildContext context, String calltype) {
    if (validate()) {
      final customer = context.read<HiveDB>().shosenCustomer!;
      final ticket = customer.tickets.firstWhere((e) => e == context.read<HiveDB>().chosenTicket!);
      final call = CallInfo(
          Ticket_ID: ticket.ticket_ID,
          customer_ID: customer.customer_ID,
          CallInfo_ID: DateTime.now().microsecondsSinceEpoch,
          callSerial: 0,
          callRecipient: username,
          callDate: DateTime.now(),
          calltype: calltype,
          callReason: TED_callReason.text,
          callresult: TED_callresult.text,
          callReasonINdetails: '',
          notes: "");

      if (ticket.Ticketresolved == false) {
        ticket.calls.add(call);
        context.read<HiveDB>().updatecustomer(customer);
      }
    }
  }

  addcalltocustomer(BuildContext context, String calltype) {
    if (validate()) {
      final customer = context.read<HiveDB>().shosenCustomer!;

      final call = CallInfo(
          Ticket_ID: 0,
          customer_ID: customer.customer_ID,
          CallInfo_ID: DateTime.now().microsecondsSinceEpoch,
          callSerial: 0,
          callRecipient: username,
          callDate: DateTime.now(),
          calltype: calltype,
          callReason: TED_callReason.text,
          callresult: TED_callresult.text,
          callReasonINdetails: TED_callReasondetails.text,
          notes: "");
      customer.calls.add(call);
      context.read<HiveDB>().updatecustomer(customer);
    }
  }

  updateRequest(BuildContext context, RequstesMolel request) {
    final customer = context.read<HiveDB>().shosenCustomer!;
    final ticket = customer.tickets.firstWhere((e) => e == context.read<HiveDB>().chosenTicket!);
    if (ticket.Ticketresolved == false) {
      var index = ticket.requests.map((toElement) => toElement.Request_ID).toList().indexOf(request.Request_ID);
      ticket.requests.removeAt(index);
      ticket.requests.add(request);
      context.read<HiveDB>().updatecustomer(customer);
    }
  }
}
