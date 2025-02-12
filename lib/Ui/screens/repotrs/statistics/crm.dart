import 'package:flutter/material.dart';
import 'package:janssen_cusomer_service/Ui/screens/repotrs/statistics/crmProvider.dart';
import 'package:janssen_cusomer_service/Ui/screens/repotrs/statistics/widgets.dart/actions.dart';
import 'package:janssen_cusomer_service/Ui/screens/repotrs/statistics/widgets.dart/callreciepeint.dart';
import 'package:janssen_cusomer_service/Ui/screens/repotrs/statistics/widgets.dart/callsCart.dart';
import 'package:janssen_cusomer_service/Ui/screens/repotrs/statistics/widgets.dart/callsreasons.dart';
import 'package:janssen_cusomer_service/Ui/screens/repotrs/statistics/widgets.dart/cards.dart';
import 'package:janssen_cusomer_service/Ui/screens/repotrs/statistics/widgets.dart/complainReasons.dart';
import 'package:janssen_cusomer_service/Ui/screens/repotrs/statistics/widgets.dart/prodcuts.dart';
import 'package:janssen_cusomer_service/main.dart';
import 'package:provider/provider.dart';


class CrmView extends StatelessWidget {
  const CrmView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 30,),
      backgroundColor: const Color.fromARGB(255, 234, 237, 247),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  const Cards(),
                  // SizedBox(
                  //     width: MediaQuery.of(context).size.width * .38,
                  //     height: MediaQuery.of(context).size.height * .4,
                  //     child: const LineChartSample2()),
                ],
              ),
          
            ],
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // ComplainReasons(),
              // Prodcuts(),
              // CallsReasons(),
              // CallRecepient(),
              // Actionstaken(),
            ],
          )
        ],
      ),
    );
  }
  

}
