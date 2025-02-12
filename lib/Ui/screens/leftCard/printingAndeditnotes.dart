// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:janssen_cusomer_service/Ui/base.dart';
import 'package:janssen_cusomer_service/Ui/pdf/pdf.dart';
import 'package:janssen_cusomer_service/Ui/pdf/pdfContent.dart';
import 'package:janssen_cusomer_service/Ui/recourses/sharedWidgets/textformfield.dart';
import 'package:janssen_cusomer_service/app/funcs.dart';
import 'package:janssen_cusomer_service/data/localDB.dart';
import 'package:provider/provider.dart';

class editNotes extends StatelessWidget {
  const editNotes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HiveDB>(
      builder: (context, myType, child) {
        return Column(
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * .3,
              height: MediaQuery.sizeOf(context).height * .07,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      // overflow: TextOverflow.fade,
                      "  ملاحظات  :  ${myType.chosenTicket!.notes}",
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  TEDcontrollers con = TEDcontrollers();
                  con.TED_others.text = myType.chosenTicket!.notes;
                  showDialog(
                      context: context,
                      builder: (c) => AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Gap(11),
                                CustomTextFormField(
                                  width: 300,
                                  hint: 'ملاحظات ',
                                  controller: con.TED_others,
                                ),
                                TextButton(
                                    onPressed: () {
                                      if (myType.chosenTicket!.Ticketresolved == false) {
                                        myType.chosenTicket!.notes = con.TED_others.text;
                                        myType.updatecustomer(myType.shosenCustomer!);
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: const Text("تم"))
                              ],
                            ),
                          ));
                },
                icon: const Icon(Icons.edit)),
          ],
        );
      },
    );
  }
}

class pringingButtoms extends StatelessWidget {
  const pringingButtoms({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HiveDB>(
      builder: (context, myType, child) {
        return Row(
          children: [
            TextButton(
                onPressed: () {
                  permission().then((value) async {
                    PDF1.generate(context, myType.shosenCustomer!, myType.chosenTicket!).then((value) => Navigator.of(context).push(MaterialPageRoute(
                        builder: (e) => PDfpreview(
                              v: value.save(),
                            ))));
                  });
                },
                child: const Text(' نموذج انجلندر')),
            TextButton(
                onPressed: () {
                  permission().then((value) async {
                    PDF2.generate(context, myType.shosenCustomer!, myType.chosenTicket!).then((value) => Navigator.of(context).push(MaterialPageRoute(
                        builder: (e) => PDfpreview(
                              v: value.save(),
                            ))));
                  });
                },
                child: const Text('نموذج يانسن')),
          ],
        );
      },
    );
  }
}
