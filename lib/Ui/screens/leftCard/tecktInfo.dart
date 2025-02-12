// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:janssen_cusomer_service/Ui/base.dart';
import 'package:janssen_cusomer_service/Ui/recourses/sharedWidgets/textformfield.dart';
import 'package:janssen_cusomer_service/app/actions.dart';
import 'package:janssen_cusomer_service/app/extentions.dart';
import 'package:janssen_cusomer_service/data/localDB.dart';
import 'package:janssen_cusomer_service/main.dart';
import 'package:janssen_cusomer_service/models/models.dart';
import 'package:janssen_cusomer_service/models/ticket.dart';
import 'package:provider/provider.dart';

class TicketInfo extends StatelessWidget {
  const TicketInfo({
    super.key,
    required this.ticket,
  });
  final TicketModel ticket;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(color: Color.fromARGB(255, 211, 210, 210), borderRadius: BorderRadius.vertical(top: Radius.circular(5))),
          child: const Center(
              child: Text(
            "Ticket Info",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          )),
        ),
        Container(
          height: MediaQuery.of(context).size.height * .27,
          decoration: const BoxDecoration(color: Color.fromRGBO(246, 246, 248, 1), borderRadius: BorderRadius.vertical(top: Radius.circular(5))),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 9, bottom: 6),
                      child: Text(
                        " رقم التذكره : ${ticket.ticket_Num}",
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 9, bottom: 6),
                      child: Text(
                        textAlign: TextAlign.end,
                        "${df.format(ticket.datecreated)} : تاريخ الانشاء",
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 9, bottom: 6),
                      child: DropDdowenFor_cars(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 9, bottom: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Visibility(
                              visible: ticket.Ticketresolved == true,
                              child: Tooltip(
                                message:
                                    "${ticket.actions.get_Who_Of(TicketAction.Ticket_Resolved.getTitle)} ${ticket.actions.get_Date_of_action(TicketAction.Ticket_Resolved.getTitle).formatt_yMd_hms()}",
                                child: const Icon(Icons.info_outline),
                              )),
                          Text(
                            " ${ticket.Ticketresolved ? 'مغلقة' : 'مفتوحه'}",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: ticket.Ticketresolved ? Colors.green : Colors.red),
                          ),
                          const Text(
                            " : حالة التذكره",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5, right: 5),
                  child: TextButton(
                      style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.red)),
                      onPressed: () {
                        TEDcontrollers vm = TEDcontrollers();

                        showDialog(
                            context: context,
                            builder: (c) => AlertDialog(
                                  content: SizedBox(
                                    height: 111,
                                    child: Form(
                                      key: vm.formKey,
                                      child: Column(
                                        children: [
                                          CustomTextFormField(
                                              validator: (v) {
                                                if (v != '') {
                                                  return null;
                                                } else {
                                                  return 'فارغ';
                                                }
                                              },
                                              onsubmitted: (v) {
                                                FocusScope.of(context).nextFocus();
                                                return null;
                                              },
                                              autofocus: true,
                                              hint: 'السبب',
                                              width: 200,
                                              controller: vm.TED_closeReason),
                                          ElevatedButton(
                                              onPressed: () {
                                                if (vm.validate()) {
                                                  vm.closeTicket(context);
                                                  Navigator.of(context).pop();
                                                }
                                              },
                                              child: const Text('ok'))
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.close,
                            size: 18,
                          ),
                          Text(
                            'اغلاق التذكره',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class DropDdowenFor_cars extends StatelessWidget {
  DropDdowenFor_cars({
    super.key,
  });
  TEDcontrollers vm = TEDcontrollers();
  @override
  Widget build(BuildContext context) {
    return Consumer<HiveDB>(
      builder: (context, myType, child) {
        var a = ['طلب صيانه', 'شكوى', 'اخرى'];
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DropdownButton<String>(
                value: myType.chosenTicket!.TicketType,
                items: a
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (v) {
                  vm.UpdateTicketType(context, v!);
                }),
            const Gap(11),
            const Text(
              ' : نوع التذكره',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        );
      },
    );
  }
}
