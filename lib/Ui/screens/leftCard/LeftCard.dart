// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, camel_case_types, file_names, use_build_context_synchronously
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:janssen_cusomer_service/Ui/screens/leftCard/calls.dart';
import 'package:janssen_cusomer_service/Ui/screens/leftCard/customerInfo.dart';
import 'package:janssen_cusomer_service/Ui/screens/leftCard/mantaniceReq.dart';
import 'package:janssen_cusomer_service/Ui/screens/leftCard/printingAndeditnotes.dart';
import 'package:janssen_cusomer_service/Ui/screens/leftCard/tecktInfo.dart';
import 'package:provider/provider.dart';
import 'package:janssen_cusomer_service/Ui/base.dart';
import 'package:janssen_cusomer_service/data/localDB.dart';

class LeftCard extends StatelessWidget {
  LeftCard({
    super.key,
  });
  TEDcontrollers vm = TEDcontrollers();
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 185, 206, 177),
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 70,
        width: MediaQuery.sizeOf(context).width * .81,
        child: Consumer<HiveDB>(
          builder: (context, myType, child) {
            return myType.shosenCustomer == null
                ? SizedBox()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                 
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      width: .26 * (MediaQuery.sizeOf(context).width * .78),
                                      child: CustomerInfo(
                                        customer: myType.shosenCustomer!,
                                      ),
                                    ),
                                    Gap(11),
                                    myType.chosenTicket == null
                                        ? SizedBox()
                                        : SizedBox(
                                            width: .26 * (MediaQuery.sizeOf(context).width * .78),
                                            child: TicketInfo(
                                              ticket: myType.chosenTicket!,
                                            ),
                                          ),
                                  ],
                                ),
                                myType.chosenTicket == null
                                    ? SizedBox()
                                    : Column(
                                        children: [
                                          calls(vm: vm),
                                          pringingButtoms(),
                                          editNotes(),
                                        ],
                                      )
                              ],
                            ),
                            myType.chosenTicket == null
                                ? SizedBox()
                                : SizedBox(
                                    width: .45 * (MediaQuery.sizeOf(context).width * .78),
                                    child: MantainceRequestInfo(
                                      ticket: myType.chosenTicket!,
                                    ),
                                  )
                          ].reversed.toList(),
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
