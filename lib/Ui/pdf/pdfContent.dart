// ignore_for_file: file_names

import 'package:flutter/services.dart';
import 'package:janssen_cusomer_service/Ui/screens/repotrs/R1.dart';
import 'package:janssen_cusomer_service/app/actions.dart';
import 'package:janssen_cusomer_service/app/extentions.dart';
import 'package:janssen_cusomer_service/models/customer.dart';
import 'package:janssen_cusomer_service/models/models.dart';
import 'package:janssen_cusomer_service/models/ticket.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PDF1 {
  static Future<Document> generate(
      c, CustomerModel shosenCustomer, TicketModel chosenTicket) async {
    var data = await rootBundle.load("assets/fonts/HacenTunisia.ttf");

    var arabicFont = Font.ttf(data);
    final pdf = Document();

    pdf.addPage(
      Page(
        textDirection: TextDirection.rtl,
        theme: ThemeData(
            tableCell: TextStyle(font: arabicFont, fontSize: 16),
            defaultTextStyle: TextStyle(font: arabicFont, fontSize: 12)),
        pageFormat: PdfPageFormat.a4,
        orientation: PageOrientation.natural,
        margin: const EdgeInsets.symmetric(vertical: 15),
        build: (context) {
          return Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: PdfColors.black,
                      width: 3,
                      style: BorderStyle.solid)),
              margin: const EdgeInsets.all(22),
              child: Expanded(
                  child: ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(children: [
                              Text(
                                  'Ticket Serial : ${chosenTicket.ticket_Num}'),
                              Text(
                                  'شركة مصطفى محمد محمد بيد يانسن                          m.m.m.m Bed Hanssen Co '),
                              SizedBox(height: 33),
                              Column(children: [
                                Text(
                                    '    نموذج ابلاغ عن حالة وجود شكاوى العملاء    ',
                                    style: const TextStyle(
                                      fontSize: 16,
                                    )),
                                Container(
                                    height: 1.5,
                                    width: 240,
                                    color: PdfColors.black)
                              ]),
                              SizedBox(height: 33),
                              Row(children: [
                                SizedBox(width: 22),
                                Text('التاريخ : '),
                                // Text('${df.format(chosenTicket.datecreated)} ')
                                Text(
                                    '${chosenTicket.datecreated.formatt_yMd()} ')
                              ]),
                              SizedBox(height: 10),
                              Row(children: [
                                SizedBox(width: 22),
                                Text('اسم العميل : '),
                                Text('${shosenCustomer.cusotmerName} '),
                              ]),
                              SizedBox(height: 10),
                              Row(children: [
                                SizedBox(width: 22),
                                Text('العنوان : '),
                                Text('${shosenCustomer.adress} '),
                              ]),
                              Row(children: [
                                SizedBox(width: 22),
                                Text('المحافظه : '),
                                Text('${shosenCustomer.covernorate} '),
                              ]),
                              Row(children: [
                                SizedBox(width: 22),
                                Text('المدينه : '),
                                Text('${shosenCustomer.area} '),
                              ]),
                              SizedBox(height: 10),
                              ...shosenCustomer.mobilenum.map(
                                (e) => Row(children: [
                                  SizedBox(width: 22),
                                  Text('تيليفون العميل : '),
                                  Text(e),
                                ]),
                              ),
                              SizedBox(height: 10),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Table(children: [
                                      TableRow(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.full,
                                          children: [
                                            Container(
                                                width: 88,
                                                child: Center(
                                                    child: Text('اسم المنتج')),
                                                decoration: BoxDecoration(
                                                    border: Border.all())),
                                            Container(
                                                width: 80,
                                                child: Center(
                                                    child: Text('المقاس')),
                                                decoration: BoxDecoration(
                                                    border: Border.all())),
                                            Container(
                                                width: 35,
                                                child: Center(
                                                    child: Text('الكميه')),
                                                decoration: BoxDecoration(
                                                    border: Border.all())),
                                            Container(
                                                width: 82,
                                                child: Center(
                                                    child:
                                                        Text('تاريخ الشراء')),
                                                decoration: BoxDecoration(
                                                    border: Border.all())),
                                            Container(
                                                width: 88,
                                                child: Center(
                                                    child: Text('مكان الشراء')),
                                                decoration: BoxDecoration(
                                                    border: Border.all())),
                                            Container(
                                                width: 160,
                                                child: Center(
                                                    child: Text('سبب الشكوى')),
                                                decoration: BoxDecoration(
                                                    border: Border.all())),
                                          ].reversed.toList())
                                    ])
                                  ]),
                              ...chosenTicket.requests.map((e) => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Table(children: [
                                          TableRow(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .full,
                                              children: [
                                                Container(
                                                    width: 88,
                                                    child: Center(
                                                        child: Text(e.pfodcut
                                                            .ProductName)),
                                                    decoration: BoxDecoration(
                                                        border: Border.all())),
                                                Container(
                                                    width: 80,
                                                    child: Center(
                                                        child: Text(
                                                            '${e.pfodcut.L}*${e.pfodcut.W}*${e.pfodcut.H}')),
                                                    decoration: BoxDecoration(
                                                        border: Border.all())),
                                                Container(
                                                    width: 35,
                                                    child: Center(
                                                        child: Text(e
                                                            .pfodcut.Quantity
                                                            .toString())),
                                                    decoration: BoxDecoration(
                                                        border: Border.all())),
                                                Container(
                                                    width: 82,
                                                    child: Center(
                                                        child: Text(
                                                      e.pfodcut.PurcheDate
                                                                  .year ==
                                                              0
                                                          ? ''
                                                          : e.pfodcut.PurcheDate
                                                              .formatt_yMd(),
                                                      style: const TextStyle(
                                                          fontSize: 8),
                                                    )),
                                                    decoration: BoxDecoration(
                                                        border: Border.all())),
                                                Container(
                                                    width: 88,
                                                    child: Center(
                                                        child: Text(e.pfodcut
                                                            .PurcheLocation)),
                                                    decoration: BoxDecoration(
                                                        border: Border.all())),
                                                Container(
                                                    width: 160,
                                                    child: Center(
                                                        child:
                                                            Text(e.reqreqson)),
                                                    decoration: BoxDecoration(
                                                        border: Border.all())),
                                              ].reversed.toList())
                                        ])
                                      ])),
                              Column(children: [
                                SizedBox(height: 12),
                                Padding(
                                    padding:
                                        const EdgeInsetsDirectional.symmetric(
                                            horizontal: 10),
                                    child: Text(
                                        '      ملاحظات :${chosenTicket.notes}')),
                              ]),
                            ]),
                            Row(children: [
                              SizedBox(width: 11),
                              Text("متلقى الشكوى : "),
                              Text(chosenTicket.actions.get_Who_Of(
                                  TicketAction.creat_NewTicket.getTitle))
                            ])
                          ]))));
        },
      ),
    );
    return pdf;
  }
}

class PDF2 {
  static Future<Document> generate(
      c, CustomerModel shosenCustomer, TicketModel chosenTicket) async {
    var data = await rootBundle.load("assets/fonts/HacenTunisia.ttf");

    var arabicFont = Font.ttf(data);
    final pdf = Document();

    pdf.addPage(
      Page(
        textDirection: TextDirection.rtl,
        theme: ThemeData(
            tableCell: TextStyle(font: arabicFont, fontSize: 16),
            defaultTextStyle: TextStyle(font: arabicFont, fontSize: 12)),
        pageFormat: PdfPageFormat.a4,
        orientation: PageOrientation.natural,
        margin: const EdgeInsets.symmetric(vertical: 15),
        build: (context) {
          return Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: PdfColors.black,
                      width: 3,
                      style: BorderStyle.solid)),
              margin: const EdgeInsets.all(22),
              child: Expanded(
                  child: ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(children: [
                              Text(
                                  'Ticket Serial : ${chosenTicket.ticket_Num}'),
                              Text(
                                  'Bed janssen co. شركة بيد يانسن للمراتب و المفروشات '),
                              SizedBox(height: 8),
                              Column(children: [
                                Text(
                                    '    نموذج ابلاغ عن حالة وجود شكاوى العملاء    ',
                                    style: const TextStyle(
                                      fontSize: 14,
                                    )),
                                Container(
                                    height: 1.5,
                                    width: 240,
                                    color: PdfColors.black)
                              ]),
                              SizedBox(height: 10),
                              Row(children: [
                                SizedBox(width: 22),
                                Text('التاريخ : '),
                                Text(
                                    '${chosenTicket.datecreated.formatt_yMd()} ')
                              ]),
                              SizedBox(height: 10),
                              Row(children: [
                                SizedBox(width: 22),
                                Text('اسم العميل : '),
                                Text('${shosenCustomer.cusotmerName} '),
                              ]),
                              Row(children: [
                                SizedBox(width: 22),
                                Text('المحافظه : '),
                                Text('${shosenCustomer.covernorate} '),
                              ]),
                              Row(children: [
                                SizedBox(width: 22),
                                Text('المدينه : '),
                                Text('${shosenCustomer.area} '),
                              ]),
                              SizedBox(height: 10),
                              Row(children: [
                                SizedBox(width: 22),
                                Text('العنوان : '),
                                Text('${shosenCustomer.adress} '),
                              ]),
                              SizedBox(height: 10),
                              ...shosenCustomer.mobilenum.map(
                                (e) => Row(children: [
                                  SizedBox(width: 22),
                                  Text('تيليفون العميل : '),
                                  Text(e),
                                ]),
                              ),
                              SizedBox(height: 10),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Table(children: [
                                      TableRow(
                                          verticalAlignment:
                                              TableCellVerticalAlignment.full,
                                          children: [
                                            Container(
                                                width: 88,
                                                child: Center(
                                                    child: Text('اسم المنتج')),
                                                decoration: BoxDecoration(
                                                    border: Border.all())),
                                            Container(
                                                width: 80,
                                                child: Center(
                                                    child: Text('المقاس')),
                                                decoration: BoxDecoration(
                                                    border: Border.all())),
                                            Container(
                                                width: 35,
                                                child: Center(
                                                    child: Text('الكميه')),
                                                decoration: BoxDecoration(
                                                    border: Border.all())),
                                            Container(
                                                width: 82,
                                                child: Center(
                                                    child:
                                                        Text('تاريخ الشراء')),
                                                decoration: BoxDecoration(
                                                    border: Border.all())),
                                            Container(
                                                width: 88,
                                                child: Center(
                                                    child: Text('مكان الشراء')),
                                                decoration: BoxDecoration(
                                                    border: Border.all())),
                                            Container(
                                                width: 160,
                                                child: Center(
                                                    child: Text('سبب الشكوى')),
                                                decoration: BoxDecoration(
                                                    border: Border.all())),
                                          ].reversed.toList())
                                    ])
                                  ]),
                              ...chosenTicket.requests.map((e) => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Table(children: [
                                          TableRow(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .full,
                                              children: [
                                                Container(
                                                    width: 88,
                                                    child: Center(
                                                        child: Text(e.pfodcut
                                                            .ProductName)),
                                                    decoration: BoxDecoration(
                                                        border: Border.all())),
                                                Container(
                                                    width: 80,
                                                    child: Center(
                                                        child: Text(
                                                            '${e.pfodcut.L}*${e.pfodcut.W}*${e.pfodcut.H}')),
                                                    decoration: BoxDecoration(
                                                        border: Border.all())),
                                                Container(
                                                    width: 35,
                                                    child: Center(
                                                        child: Text(e
                                                            .pfodcut.Quantity
                                                            .toString())),
                                                    decoration: BoxDecoration(
                                                        border: Border.all())),
                                                Container(
                                                    width: 82,
                                                    child: Center(
                                                        child: Text(
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        8),
                                                            e.pfodcut.PurcheDate
                                                                        .year ==
                                                                    0
                                                                ? ''
                                                                : e.pfodcut
                                                                    .PurcheDate
                                                                    .formatt_yMd())),
                                                    decoration: BoxDecoration(
                                                        border: Border.all())),
                                                Container(
                                                    width: 88,
                                                    child: Center(
                                                        child: Text(e.pfodcut
                                                            .PurcheLocation)),
                                                    decoration: BoxDecoration(
                                                        border: Border.all())),
                                                Container(
                                                    width: 160,
                                                    child: Center(
                                                        child:
                                                            Text(e.reqreqson)),
                                                    decoration: BoxDecoration(
                                                        border: Border.all())),
                                              ].reversed.toList())
                                        ])
                                      ])),
                              Row(children: [
                                Column(children: [
                                  SizedBox(height: 12),
                                  Text(
                                      '     تم تسليم هذا النموذج لقسم الجوده بتاريخ :  '),
                                ]),
                              ]),
                              Column(children: [
                                SizedBox(height: 12),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                        '      ملاحظات :${chosenTicket.notes}')),
                              ]),
                              Row(children: [
                                Column(children: [
                                  SizedBox(height: 12),
                                  Text('    تقرير الفنى :'),
                                ]),
                              ]),
                            ]),
                            Row(children: [
                              SizedBox(width: 11),
                              Text("متلقى الشكوى : "),
                              Text(chosenTicket.actions.get_Who_Of(
                                  TicketAction.creat_NewTicket.getTitle))
                            ])
                          ]))));
        },
      ),
    );
    return pdf;
  }
}

class PDF1_multi {
  static Future<Document> generate(c, List<s> datelist) async {
    var data = await rootBundle.load("assets/fonts/HacenTunisia.ttf");
    var arabicFont = Font.ttf(data);
    final pdf = Document();

    pdf.addPage(
      MultiPage(
        textDirection: TextDirection.rtl,
        theme: ThemeData(
            tableCell: TextStyle(font: arabicFont, fontSize: 16),
            defaultTextStyle: TextStyle(font: arabicFont, fontSize: 12)),
        pageFormat: PdfPageFormat.a4,
        orientation: PageOrientation.natural,
        margin: const EdgeInsets.symmetric(vertical: 15),
        build: (context) {
          return datelist.map((e) {
            return Container(
                height: 767,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: PdfColors.black,
                        width: 3,
                        style: BorderStyle.solid)),
                margin: const EdgeInsets.all(22),
                child: Expanded(
                    child: ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(children: [
                                Text('Ticket Serial : ${e.t.ticket_Num}'),
                                Text(
                                    'شركة مصطفى محمد محمد بيد يانسن                          m.m.m.m Bed Hanssen Co '),
                                SizedBox(height: 33),
                                Column(children: [
                                  Text(
                                      '    نموذج ابلاغ عن حالة وجود شكاوى العملاء    ',
                                      style: const TextStyle(
                                        fontSize: 16,
                                      )),
                                  Container(
                                      height: 1.5,
                                      width: 240,
                                      color: PdfColors.black)
                                ]),
                                SizedBox(height: 33),
                                Row(children: [
                                  SizedBox(width: 22),
                                  Text('التاريخ : '),
                                  Text('${e.t.datecreated.formatt_yMd()} ')
                                ]),
                                SizedBox(height: 33),
                                Row(children: [
                                  SizedBox(width: 22),
                                  Text('اسم العميل : '),
                                  Text('${e.c.cusotmerName} '),
                                ]),
                                SizedBox(height: 15),
                                Row(children: [
                                  SizedBox(width: 22),
                                  Text('المحافظه : '),
                                  Text('${e.c.covernorate} '),
                                ]),
                                SizedBox(height: 15),
                                Row(children: [
                                  SizedBox(width: 22),
                                  Text('المدينه : '),
                                  Text('${e.c.area} '),
                                ]),
                                SizedBox(height: 15),
                                Row(children: [
                                  SizedBox(width: 22),
                                  Text('العنوان : '),
                                  Text('${e.c.adress} '),
                                ]),
                                SizedBox(height: 15),
                                ...e.c.mobilenum.map(
                                  (e) => Row(children: [
                                    SizedBox(width: 22),
                                    Text('تيليفون العميل : '),
                                    Text(e),
                                  ]),
                                ),
                                SizedBox(height: 15),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Table(children: [
                                        TableRow(
                                            verticalAlignment:
                                                TableCellVerticalAlignment.full,
                                            children: [
                                              Container(
                                                  width: 88,
                                                  child: Center(
                                                      child:
                                                          Text('اسم المنتج')),
                                                  decoration: BoxDecoration(
                                                      border: Border.all())),
                                              Container(
                                                  width: 80,
                                                  child: Center(
                                                      child: Text('المقاس')),
                                                  decoration: BoxDecoration(
                                                      border: Border.all())),
                                              Container(
                                                  width: 35,
                                                  child: Center(
                                                      child: Text('الكميه')),
                                                  decoration: BoxDecoration(
                                                      border: Border.all())),
                                              Container(
                                                  width: 82,
                                                  child: Center(
                                                      child:
                                                          Text('تاريخ الشراء')),
                                                  decoration: BoxDecoration(
                                                      border: Border.all())),
                                              Container(
                                                  width: 88,
                                                  child: Center(
                                                      child:
                                                          Text('مكان الشراء')),
                                                  decoration: BoxDecoration(
                                                      border: Border.all())),
                                              Container(
                                                  width: 160,
                                                  child: Center(
                                                      child:
                                                          Text('سبب الشكوى')),
                                                  decoration: BoxDecoration(
                                                      border: Border.all())),
                                            ].reversed.toList())
                                      ])
                                    ]),
                                ...e.t.requests.map((e) => Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Table(children: [
                                            TableRow(
                                                verticalAlignment:
                                                    TableCellVerticalAlignment
                                                        .full,
                                                children: [
                                                  Container(
                                                      width: 88,
                                                      child: Center(
                                                          child: Text(e.pfodcut
                                                              .ProductName)),
                                                      decoration: BoxDecoration(
                                                          border:
                                                              Border.all())),
                                                  Container(
                                                      width: 80,
                                                      child: Center(
                                                          child: Text(
                                                              '${e.pfodcut.L}*${e.pfodcut.W}*${e.pfodcut.H}')),
                                                      decoration: BoxDecoration(
                                                          border:
                                                              Border.all())),
                                                  Container(
                                                      width: 35,
                                                      child: Center(
                                                          child: Text(e
                                                              .pfodcut.Quantity
                                                              .toString())),
                                                      decoration: BoxDecoration(
                                                          border:
                                                              Border.all())),
                                                  Container(
                                                      width: 82,
                                                      child: Center(
                                                          child: Text(
                                                        e.pfodcut.PurcheDate
                                                                    .year ==
                                                                0
                                                            ? ''
                                                            : e.pfodcut
                                                                .PurcheDate
                                                                .formatt_yMd(),
                                                        style: const TextStyle(
                                                            fontSize: 8),
                                                      )),
                                                      decoration: BoxDecoration(
                                                          border:
                                                              Border.all())),
                                                  Container(
                                                      width: 88,
                                                      child: Center(
                                                          child: Text(e.pfodcut
                                                              .PurcheLocation)),
                                                      decoration: BoxDecoration(
                                                          border:
                                                              Border.all())),
                                                  Container(
                                                      width: 160,
                                                      child: Center(
                                                          child: Text(
                                                              e.reqreqson)),
                                                      decoration: BoxDecoration(
                                                          border:
                                                              Border.all())),
                                                ].reversed.toList())
                                          ])
                                        ])),
                              Column(children: [
                                    SizedBox(height: 12),
                                    Text('      ملاحظات :${e.t.notes}'),
                                  ]),
                              ]),
                              Row(children: [
                                SizedBox(width: 11),
                                Text("متلقى الشكوى : "),
                                Text(e.t.actions.get_Who_Of(
                                    TicketAction.creat_NewTicket.getTitle))
                              ])
                            ]))));
          }).toList();
        },
      ),
    );
    return pdf;
  }
}

class PDF2_multi {
  static Future<Document> generate(c, List<s> datelist) async {
    var data = await rootBundle.load("assets/fonts/HacenTunisia.ttf");
    var arabicFont = Font.ttf(data);
    final pdf = Document();

    pdf.addPage(
      MultiPage(
        textDirection: TextDirection.rtl,
        theme: ThemeData(
            tableCell: TextStyle(font: arabicFont, fontSize: 16),
            defaultTextStyle: TextStyle(font: arabicFont, fontSize: 12)),
        pageFormat: PdfPageFormat.a4,
        orientation: PageOrientation.natural,
        margin: const EdgeInsets.symmetric(vertical: 15),
        build: (context) {
          return datelist.map((e) {
            return Container(
                height: 767,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: PdfColors.black,
                        width: 3,
                        style: BorderStyle.solid)),
                margin: const EdgeInsets.all(22),
                child: Expanded(
                    child: ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(children: [
                                Text('Ticket Serial : ${e.t.ticket_Num}'),
                                Text(
                                    'Bed janssen co. شركة بيد يانسن للمراتب و المفروشات '),
                                SizedBox(height: 8),
                                Column(children: [
                                  Text(
                                      '    نموذج ابلاغ عن حالة وجود شكاوى العملاء    ',
                                      style: const TextStyle(
                                        fontSize: 14,
                                      )),
                                  Container(
                                      height: 1.5,
                                      width: 240,
                                      color: PdfColors.black)
                                ]),
                                SizedBox(height: 33),
                                Row(children: [
                                  SizedBox(width: 22),
                                  Text('التاريخ : '),
                                  Text('${e.t.datecreated.formatt_yMd()} ')
                                ]),
                                SizedBox(height: 33),
                                Row(children: [
                                  SizedBox(width: 22),
                                  Text('اسم العميل : '),
                                  Text('${e.c.cusotmerName} '),
                                ]),
                                SizedBox(height: 15),
                                Row(children: [
                                  SizedBox(width: 22),
                                  Text('المحافظه : '),
                                  Text('${e.c.covernorate} '),
                                ]),
                                SizedBox(height: 15),
                                Row(children: [
                                  SizedBox(width: 22),
                                  Text('المدينه : '),
                                  Text('${e.c.area} '),
                                ]),
                                SizedBox(height: 15),
                                Row(children: [
                                  SizedBox(width: 22),
                                  Text('العنوان : '),
                                  Text('${e.c.adress} '),
                                ]),
                                SizedBox(height: 15),
                                ...e.c.mobilenum.map(
                                  (e) => Row(children: [
                                    SizedBox(width: 22),
                                    Text('تيليفون العميل : '),
                                    Text(e),
                                  ]),
                                ),
                                SizedBox(height: 15),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Table(children: [
                                        TableRow(
                                            verticalAlignment:
                                                TableCellVerticalAlignment.full,
                                            children: [
                                              Container(
                                                  width: 88,
                                                  child: Center(
                                                      child:
                                                          Text('اسم المنتج')),
                                                  decoration: BoxDecoration(
                                                      border: Border.all())),
                                              Container(
                                                  width: 80,
                                                  child: Center(
                                                      child: Text('المقاس')),
                                                  decoration: BoxDecoration(
                                                      border: Border.all())),
                                              Container(
                                                  width: 35,
                                                  child: Center(
                                                      child: Text('الكميه')),
                                                  decoration: BoxDecoration(
                                                      border: Border.all())),
                                              Container(
                                                  width: 82,
                                                  child: Center(
                                                      child:
                                                          Text('تاريخ الشراء')),
                                                  decoration: BoxDecoration(
                                                      border: Border.all())),
                                              Container(
                                                  width: 88,
                                                  child: Center(
                                                      child:
                                                          Text('مكان الشراء')),
                                                  decoration: BoxDecoration(
                                                      border: Border.all())),
                                              Container(
                                                  width: 160,
                                                  child: Center(
                                                      child:
                                                          Text('سبب الشكوى')),
                                                  decoration: BoxDecoration(
                                                      border: Border.all())),
                                            ].reversed.toList())
                                      ])
                                    ]),
                                ...e.t.requests.map((e) => Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Table(children: [
                                            TableRow(
                                                verticalAlignment:
                                                    TableCellVerticalAlignment
                                                        .full,
                                                children: [
                                                  Container(
                                                      width: 88,
                                                      child: Center(
                                                          child: Text(e.pfodcut
                                                              .ProductName)),
                                                      decoration: BoxDecoration(
                                                          border:
                                                              Border.all())),
                                                  Container(
                                                      width: 80,
                                                      child: Center(
                                                          child: Text(
                                                              '${e.pfodcut.L}*${e.pfodcut.W}*${e.pfodcut.H}')),
                                                      decoration: BoxDecoration(
                                                          border:
                                                              Border.all())),
                                                  Container(
                                                      width: 35,
                                                      child: Center(
                                                          child: Text(e
                                                              .pfodcut.Quantity
                                                              .toString())),
                                                      decoration: BoxDecoration(
                                                          border:
                                                              Border.all())),
                                                  Container(
                                                      width: 82,
                                                      child: Center(
                                                          child: Text(
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          8),
                                                              e.pfodcut.PurcheDate
                                                                          .year ==
                                                                      0
                                                                  ? ''
                                                                  : e.pfodcut
                                                                      .PurcheDate
                                                                      .formatt_yMd())),
                                                      decoration: BoxDecoration(
                                                          border:
                                                              Border.all())),
                                                  Container(
                                                      width: 88,
                                                      child: Center(
                                                          child: Text(e.pfodcut
                                                              .PurcheLocation)),
                                                      decoration: BoxDecoration(
                                                          border:
                                                              Border.all())),
                                                  Container(
                                                      width: 160,
                                                      child: Center(
                                                          child: Text(
                                                              e.reqreqson)),
                                                      decoration: BoxDecoration(
                                                          border:
                                                              Border.all())),
                                                ].reversed.toList())
                                          ])
                                        ])),
                                Row(children: [
                                  Column(children: [
                                    SizedBox(height: 12),
                                    Text(
                                        '     تم تسليم هذا النموذج لقسم الجوده بتاريخ :  '),
                                  ]),
                                ]),
                                Column(children: [
                                    SizedBox(height: 12),
                                    Text('      ملاحظات :${e.t.notes}'),
                                  ]),
                                Row(children: [
                                  Column(children: [
                                    SizedBox(height: 12),
                                    Text('    تقرير الفنى :'),
                                  ]),
                                ]),
                              ]),
                              Row(children: [
                                SizedBox(width: 11),
                                Text("متلقى الشكوى : "),
                                Text(e.t.actions.get_Who_Of(
                                    TicketAction.creat_NewTicket.getTitle))
                              ])
                            ]))));
          }).toList();
        },
      ),
    );
    return pdf;
  }
}
