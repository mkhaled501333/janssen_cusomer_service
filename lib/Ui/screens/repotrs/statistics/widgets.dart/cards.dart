import 'package:flutter/material.dart';
import 'package:janssen_cusomer_service/Ui/screens/repotrs/statistics/crmProvider.dart';
import 'package:provider/provider.dart';

class Cards extends StatelessWidget {
  const Cards({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CrmProvider>(
      builder: (context, myType, child) {
        final calls = myType.ticketcalls + myType.cusomercalls;
        final incoming = calls.where((e) => e.calltype == "وارد");
        final tickets = myType.tickets;
        final closedTickets = tickets.where((e) => e.Ticketresolved == true);
        final pendingvisit = myType.requests.where((w) => w.visited == false);
        final pendingdelevery = myType.requests.where((w) =>
            (w.visited == true) &&
            (w.pulled1 == true || w.pulled2 == true || w.pulled3 == true) &&
            (w.deleverd1 == false &&
                w.deleverd2 == false &&
                w.deleverd3 == false));
        return Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [Text("Analytics")],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [


                   
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Container(
                    //     height: MediaQuery.of(context).size.height * .14,
                    //     width: MediaQuery.of(context).size.width * .13,
                    //     decoration: BoxDecoration(
                    //         color: const Color.fromARGB(255, 255, 153, 32),
                    //         borderRadius: BorderRadius.circular(9)),
                    //     child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //       children: [
                    //         Text(
                    //           "all Tickets  : ${tickets.length}",
                    //           style: const TextStyle(
                    //               color: Colors.white,
                    //               fontSize: 14,
                    //               fontWeight: FontWeight.bold),
                    //         ),
                    //         Text(
                    //           "closed Tickets : ${closedTickets.length}",
                    //           style: const TextStyle(
                    //               color: Colors.white,
                    //               fontSize: 14,
                    //               fontWeight: FontWeight.bold),
                    //         ),
                    //         Text(
                    //           "opend Tickets : ${tickets.length - closedTickets.length}",
                    //           style: const TextStyle(
                    //               color: Colors.white,
                    //               fontSize: 14,
                    //               fontWeight: FontWeight.bold),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * .14,
                        width: MediaQuery.of(context).size.width * .13,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 23, 43, 76),
                            borderRadius: BorderRadius.circular(9)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "All   calls :${calls.length}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "incaming calls :${incoming.length}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "outgoing calls : ${calls.length - incoming.length}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                   
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * .14,
                        width: MediaQuery.of(context).size.width * .13,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 254, 86, 47),
                            borderRadius: BorderRadius.circular(9)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "pending visit     : ${pendingvisit.length}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "pending delivery  : ${pendingdelevery.length}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
           
           
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
