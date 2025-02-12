// // ignore_for_file: public_member_api_docs, sort_constructors_first, camel_case_types, use_build_context_synchronously
// // ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables

// import 'package:collection/collection.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:janssen_cusomer_service/models/customer.dart';
// import 'package:janssen_cusomer_service/models/request.dart';
// import 'package:janssen_cusomer_service/models/ticket.dart';
// import 'package:provider/provider.dart';

// import 'package:janssen_cusomer_service/Ui/pdf/pdf.dart';
// import 'package:janssen_cusomer_service/Ui/pdf/pdfContent.dart';
// import 'package:janssen_cusomer_service/app/extentions.dart';
// import 'package:janssen_cusomer_service/app/funcs.dart';

// import '../../../data/localDB.dart';

// class Reports extends StatelessWidget {
//   Reports({super.key});
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width / 8;

//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 201, 207, 199),
//       appBar: AppBar(
//         title: const Text('reports'),
//         backgroundColor: const Color.fromARGB(255, 0, 152, 137),
//       ),
//       body: Consumer<HiveDB>(
//         builder: (context, myType, child) {
//           var data = myType.customers.values.toList().filterItemsPasedOngovernomates(context, myType.governamates).filterItemsPasedOnareas(context, myType.areas);

//           return Column(
//             children: [
//               const Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   DatepickerFrom4(),
//                   DatepickerTo4(),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     width: width,
//                     child: Dropdowen_doneOrNot(
//                       tittle: 'الاختيارات',
//                       items: const ['استبدال لنفس النوع', 'استبدال لنوع اخر', 'صيانه'],
//                       refrech: myType.Refresh_UI,
//                       selecteditems: myType.chosenActions,
//                     ),
//                   ),
//                   SizedBox(
//                     width: width,
//                     child: Dropdowen_doneOrNot(
//                       tittle: 'المحافظات',
//                       items: data.map((e) => e.covernorate.toString()).toList(),
//                       refrech: myType.Refresh_UI,
//                       selecteditems: myType.governamates,
//                     ),
//                   ),
//                   SizedBox(
//                     width: width,
//                     child: Dropdowen_doneOrNot(
//                       tittle: 'المناطق',
//                       items: data.map((e) => e.area.toString()).toList(),
//                       refrech: myType.Refresh_UI,
//                       selecteditems: myType.areas,
//                     ),
//                   ),
//                   SizedBox(
//                     width: width,
//                     child: Dropdowen_doneOrNot(
//                       tittle: 'حالة التذكره',
//                       items: const ['مفتوحه', 'مغلقه'],
//                       refrech: myType.Refresh_UI,
//                       selecteditems: myType.ticketstatus,
//                     ),
//                   ),
//                   SizedBox(
//                     width: width,
//                     child: Dropdowen_doneOrNot(
//                       tittle: 'السحب',
//                       items: const [
//                         'تم السحب',
//                         'لم يتم السحب',
//                       ],
//                       refrech: myType.Refresh_UI,
//                       selecteditems: myType.Pulleds,
//                     ),
//                   ),
//                   SizedBox(
//                     width: width,
//                     child: Dropdowen_doneOrNot(
//                       tittle: 'التسليم',
//                       items: const [
//                         'تم التسليم',
//                         'لم يتم التسليم',
//                       ],
//                       refrech: myType.Refresh_UI,
//                       selecteditems: myType.deleverd,
//                     ),
//                   ),
//                   SizedBox(
//                     width: width,
//                     child: Dropdowen_doneOrNot(
//                       tittle: 'المعاينه',
//                       items: const [
//                         'لم يتم المعاينه',
//                         'تم المعاينه',
//                       ],
//                       refrech: myType.Refresh_UI,
//                       selecteditems: myType.visiteds,
//                     ),
//                   ),
//                   SizedBox(
//                     width: width,
//                     child: Dropdowen_doneOrNot(
//                       tittle: 'النوع',
//                       items: data.expand((e) => e.tickets).expand((e) => e.requests).map((e) => e.pfodcut.ProdcutType).toList(),
//                       refrech: myType.Refresh_UI,
//                       selecteditems: myType.Types,
//                     ),
//                   ),
//                 ],
//               ),
//               Consumer<HiveDB>(
//                 builder: (context, myType, child) {
//                   return SizedBox(
//                     child: Towdirectonscroll(
//                       data: data,
//                     ),
//                   );
//                 },
//               )
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

// class Towdirectonscroll extends StatelessWidget {
//   Towdirectonscroll({
//     super.key,
//     required this.data,
//   });

//   final yourScrollController = ScrollController();
//   final yourScrollController2 = ScrollController();
//   final List<CustomerModel> data;
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width,
//       child: Scrollbar(
//         thumbVisibility: true,
//         controller: yourScrollController,
//         child: SingleChildScrollView(
//           reverse: true,
//           controller: yourScrollController,
//           scrollDirection: Axis.horizontal,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Row(
//                 children: [
//                   IconButton(
//                       onPressed: () {
//                         permission().then((value) async {
//                           PDF1_multi.generate(context, selected).then((value) => Navigator.of(context).push(MaterialPageRoute(
//                               builder: (e) => PDfpreview(
//                                     v: value.save(),
//                                   ))));
//                         });
//                       },
//                       icon: const Icon(Icons.picture_as_pdf)),
//                   const Text(": يانسن  "),
//                   IconButton(
//                       onPressed: () {
//                         permission().then((value) async {
//                           PDF2_multi.generate(context, selected).then((value) => Navigator.of(context).push(MaterialPageRoute(
//                               builder: (e) => PDfpreview(
//                                     v: value.save(),
//                                   ))));
//                         });
//                       },
//                       icon: const Icon(Icons.picture_as_pdf)),
//                   const Text(": انجلندر  ")
//                 ],
//               ),
//               RecordHeader(),
//               SizedBox(
//                 height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.horizontal - 290,
//                 child: Scrollbar(
//                   controller: yourScrollController2,
//                   thumbVisibility: true,
//                   child: SingleChildScrollView(
//                     controller: yourScrollController2,
//                     scrollDirection: Axis.vertical,
//                     child: Column(
//                       children: data
//                           .map((e) => RecordWidg(
//                                 customer: e,
//                               ))
//                           .toList(),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// List<s> selected = [];


// class RecordWidg extends StatelessWidget {
//   const RecordWidg({
//     super.key,
//     required this.customer,
//   });
//   final CustomerModel customer;
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<HiveDB>(
//       builder: (context, myType, child) {
//         // customer.tickets
//         //     ;
//         return Column(
//           children: [
//             ...customer.tickets
//                 .filterDateBetween(myType.pickedDateFrom!, myType.pickedDateTO!)
//                 .filterItemsPasedonTicketStatus(context, myType.ticketstatus)
//                 .filterItemsPasedActionType(context, myType.chosenActions)
//                 .filterItemsPasedActionType(context, myType.chosenActions)
//                 .filterItemsPasedVisited(context, myType.visiteds)
//                 .filterItemsPasedPulled(context, myType.Pulleds)
//                 .filterItemsPasedonDeleverd(context, myType.deleverd)
//                 .filterItemsPasedProdcutType(context, myType.Types)
//                 .toSet()
//                 .toList()
//                 .map((ticket) => IntrinsicHeight(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Checkbox(
//                               value: selected.where((test) => test.c.customer_ID == customer.customer_ID).isNotEmpty,
//                               onChanged: (v) {
//                                 if (v == true) {
//                                   selected.add(s(c: customer, t: ticket));
//                                 } else {
//                                   selected.removeWhere((test) => test.c.customer_ID == customer.customer_ID);
//                                 }

//                                 myType.Refresh_UI();
//                               }),
//                           cell(ticket.ticket_Num.toString(), 100),
//                           cell(ticket.Ticketresolved ? 'مغلقه' : 'مفتوحه', 100),
//                           cell(customer.cusotmerName, 100),
//                           cell(customer.covernorate, 100),
//                           cell(customer.area, 100),
//                           cell2(ticket.requests, 800),
//                           cell3Print(60, context, customer, ticket),
//                           cell4Print(60, context, customer, ticket),
//                           cell4open(60, context, customer, ticket)
//                         ].reversed.toList(),
//                       ),
//                     )),
//           ],
//         );
//       },
//     );
//   }

//   Container cell(String tittle, double width) {
//     return Container(
//       width: width,
//       decoration: BoxDecoration(border: Border.all(), color: Colors.amber.shade100),
//       child: Padding(
//         padding: const EdgeInsets.all(3.0),
//         child: Center(
//           child: Text(
//             tittle,
//             style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
//           ),
//         ),
//       ),
//     );
//   }

//   Container cell2(List<RequstesMolel> requests, double width) {
//     return Container(
//       width: width,
//       decoration: BoxDecoration(border: Border.all(), color: Colors.amber.shade100),
//       child: Padding(
//         padding: const EdgeInsets.all(3.0),
//         child: Center(
//           child: Column(children: [
//             ...requests.map((e) => Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     if (e.replaceToSameModel)
//                       Row(
//                         children: [
//                           Text(
//                             e.deleverd1 == true ? 'تم التسليم' : 'لم بتم التسليم',
//                             style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: e.deleverd1 ? Colors.green : Colors.red),
//                           ),
//                           const Text('  &  '),
//                           Text(e.pulled1 == true ? 'تم السحب' : 'لم بتم السحب',
//                               style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: e.pulled1 ? Colors.green : Colors.red)),
//                           const Text(
//                             '  >>استبدال لنفس النوع<<',
//                             style: TextStyle(fontWeight: FontWeight.w800, color: Color.fromARGB(255, 94, 7, 255)),
//                           ),
//                         ],
//                       ),
//                     if (e.replaceTosnotherModel)
//                       Row(
//                         children: [
//                           Text(e.deleverd2 == true ? 'تم التسليم' : 'لم بتم التسليم',
//                               style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: e.deleverd2 ? Colors.green : Colors.red)),
//                           const Text('  &  '),
//                           Text(e.pulled2 == true ? 'تم السحب' : 'لم بتم السحب',
//                               style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: e.pulled2 ? Colors.green : Colors.red)),
//                           const Text(
//                             '  >>استبدال لنوع اخر<<',
//                             style: TextStyle(fontWeight: FontWeight.w800, color: Color.fromARGB(255, 94, 7, 255)),
//                           ),
//                         ],
//                       ),
//                     if (e.maintainace)
//                       Row(
//                         children: [
//                           Text(e.deleverd3 == true ? 'تم التسليم' : 'لم بتم التسليم',
//                               style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: e.deleverd3 ? Colors.green : Colors.red)),
//                           const Text('  &  '),
//                           Text(e.pulled3 == true ? 'تم السحب' : 'لم بتم السحب',
//                               style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: e.pulled3 ? Colors.green : Colors.red)),
//                           const Text(
//                             '  >>صيانه<<',
//                             style: TextStyle(fontWeight: FontWeight.w800, color: Color.fromARGB(255, 94, 7, 255)),
//                           ),
//                         ],
//                       ),
//                     Text(e.visited == true ? 'تمت المعاينه' : 'لم يتم المعاينه',
//                         style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: e.visited ? Colors.green : Colors.red)),
//                     const Text('    '),
//                     Text(
//                       e.pfodcut.ProductName,
//                       style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
//                     ),
//                     Text(
//                       "${e.pfodcut.L}*${e.pfodcut.W}*${e.pfodcut.H}",
//                       style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
//                     ),
//                     Text(
//                       e.pfodcut.ProdcutType,
//                       style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
//                     ),
//                   ],
//                 ))
//           ]),
//         ),
//       ),
//     );
//   }

//   Container cell3Print(double width, BuildContext context, CustomerModel customer, TicketModel ticket) => Container(
//         width: width,
//         decoration: BoxDecoration(border: Border.all(), color: Colors.amber.shade100),
//         child: Padding(
//           padding: const EdgeInsets.all(3.0),
//           child: Center(
//             child: IconButton(
//                 onPressed: () {
//                   permission().then((value) async {
//                     PDF2.generate(context, customer, ticket).then((value) => Navigator.of(context).push(MaterialPageRoute(
//                         builder: (e) => PDfpreview(
//                               v: value.save(),
//                             ))));
//                   });
//                 },
//                 icon: const Icon(Icons.picture_as_pdf)),
//           ),
//         ),
//       );
//   Container cell4Print(double width, BuildContext context, CustomerModel customer, TicketModel ticket) => Container(
//         width: width,
//         decoration: BoxDecoration(border: Border.all(), color: Colors.amber.shade100),
//         child: Padding(
//           padding: const EdgeInsets.all(3.0),
//           child: Center(
//             child: IconButton(
//                 onPressed: () {
//                   permission().then((value) async {
//                     PDF1.generate(context, customer, ticket).then((value) => Navigator.of(context).push(MaterialPageRoute(
//                         builder: (e) => PDfpreview(
//                               v: value.save(),
//                             ))));
//                   });
//                 },
//                 icon: const Icon(Icons.picture_as_pdf)),
//           ),
//         ),
//       );

//   Container cell4open(double width, BuildContext context, CustomerModel customer, TicketModel ticket) => Container(
//         width: width,
//         decoration: BoxDecoration(border: Border.all(), color: Colors.amber.shade100),
//         child: Padding(
//           padding: const EdgeInsets.all(3.0),
//           child: Center(
//             child: IconButton(
//                 onPressed: () {
//                   context.read<HiveDB>().chosenTicket = ticket;
//                   context.read<HiveDB>().shosenCustomer = customer;
//                   Navigator.of(context).pop();
//                   context.read<HiveDB>().Refresh_UI();
//                 },
//                 icon: const Icon(Icons.open_in_browser_rounded)),
//           ),
//         ),
//       );
// }

// class RecordHeader extends StatelessWidget {
//   RecordHeader({super.key});
//   final color = const Color.fromARGB(255, 197, 150, 8);
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         cell(32, ''),
//         cell(100, 'رقم التذكره'),
//         cell(100, 'حالة التذكره'),
//         cell(100, 'اسم'),
//         cell(100, 'محافظه'),
//         cell(100, 'منظقه'),
//         cell(800, 'الطلبات'),
//         cell(60, 'يانسن'),
//         cell(60, 'انجلندر'),
//         cell(60, 'فتح'),
//       ].reversed.toList(),
//     );
//   }

//   Container cell(double width, String tittl) {
//     return Container(
//       width: width,
//       decoration: BoxDecoration(border: Border.all(), color: color),
//       child: Padding(
//         padding: const EdgeInsets.all(3.0),
//         child: Center(
//           child: Text(
//             tittl,
//             style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class DatepickerFrom4 extends StatelessWidget {
//   const DatepickerFrom4({super.key});

//   @override
//   Widget build(BuildContext context) {
//     context.read<HiveDB>().pickedDateFrom = DateTime.now();
//     return Consumer<HiveDB>(
//       builder: (context, myType, child) {
//         return Column(
//           children: [
//             TextButton(
//                 onPressed: () async {
//                   DateTime? pickedDate =
//                       await showDatePicker(context: context, initialDate: myType.pickedDateFrom, firstDate: myType.AllDatesOfOfData().min, lastDate: DateTime.now());

//                   if (pickedDate != null) {
//                     myType.pickedDateFrom = pickedDate;
//                     myType.Refresh_UI();
//                   } else {}
//                 },
//                 child: Column(
//                   children: [
//                     const Text(
//                       "من",
//                       style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.all(7),
//                       decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.teal), borderRadius: BorderRadius.circular(5)),
//                       child: Text(
//                         myType.pickedDateFrom!.formatt_yMd(),
//                         style: const TextStyle(fontSize: 15, color: Color.fromARGB(255, 97, 92, 92), fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ],
//                 )),
//           ],
//         );
//       },
//     );
//   }
// }

// class DatepickerTo4 extends StatelessWidget {
//   const DatepickerTo4({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // context.read<HiveDB>().pickedDateFrom = DateTime.now();

//     context.read<HiveDB>().pickedDateTO = DateTime.now();
//     return Consumer<HiveDB>(
//       builder: (context, myType, child) {
//         if (myType.pickedDateFrom!.microsecondsSinceEpoch > myType.pickedDateTO!.microsecondsSinceEpoch) {
//           myType.pickedDateTO = myType.pickedDateFrom;
//         }
//         return Column(
//           children: [
//             TextButton(
//                 onPressed: () async {
//                   DateTime? pickedDate = await showDatePicker(context: context, initialDate: myType.pickedDateTO!, firstDate: myType.pickedDateFrom!, lastDate: DateTime.now());

//                   if (pickedDate != null) {
//                     myType.pickedDateTO = pickedDate;
//                     myType.Refresh_UI();
//                   } else {}
//                 },
//                 child: Column(
//                   children: [
//                     const Text(
//                       "الى",
//                       style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.all(7),
//                       decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.teal), borderRadius: BorderRadius.circular(5)),
//                       child: Text(
//                         myType.pickedDateTO!.formatt_yMd(),
//                         style: const TextStyle(fontSize: 15, color: Color.fromARGB(255, 97, 92, 92), fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ],
//                 )),
//           ],
//         );
//       },
//     );
//   }
// }

// class Dropdowen_doneOrNot extends StatelessWidget {
//   Dropdowen_doneOrNot({
//     super.key,
//     required this.refrech,
//     required this.items,
//     required this.selecteditems,
//     required this.tittle,
//   });
//   final String tittle;
//   final Function refrech;
//   final List<String> items;
//   final List<String> selecteditems;
//   TextEditingController textEditingController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton2<String>(
//         isExpanded: true,
//         hint: Center(
//           child: Text(
//             tittle,
//             style: TextStyle(
//               fontSize: 18,
//               color: Theme.of(context).hintColor,
//             ),
//           ),
//         ),
//         items: items.toSet().map((item) {
//           return DropdownMenuItem(
//             value: item,
//             //disable default onTap to avoid closing menu when selecting an item
//             enabled: false,
//             child: StatefulBuilder(
//               builder: (context, menuSetState) {
//                 final isSelected = selecteditems.contains(item);
//                 return InkWell(
//                   onTap: () {
//                     isSelected ? selecteditems.remove(item) : selecteditems.add(item);

//                     //This rebuilds the StatefulWidget to update the button's text
//                     refrech();
//                     //This rebuilds the dropdownMenu Widget to update the check mark
//                     menuSetState(() {});
//                   },
//                   child: Container(
//                     height: double.infinity,
//                     padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                     child: Row(
//                       children: [
//                         if (isSelected) const Icon(Icons.check_box_outlined) else const Icon(Icons.check_box_outline_blank),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: Text(
//                             item,
//                             style: const TextStyle(
//                               fontSize: 14,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           );
//         }).toList(),
//         //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
//         value: selecteditems.isEmpty ? null : selecteditems.last,
//         onChanged: (value) {},
//         selectedItemBuilder: (context) {
//           return items.map(
//             (item) {
//               return Container(
//                 alignment: AlignmentDirectional.center,
//                 child: Text(
//                   selecteditems.join(', '),
//                   style: const TextStyle(
//                     fontSize: 14,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   maxLines: 1,
//                 ),
//               );
//             },
//           ).toList();
//         },
//         buttonStyleData: ButtonStyleData(
//           decoration: BoxDecoration(border: Border.all(), borderRadius: const BorderRadius.all(Radius.circular(7)), color: const Color.fromARGB(255, 204, 225, 241)),
//           padding: const EdgeInsets.only(left: 17, right: 8),
//           height: 50,
//           width: MediaQuery.of(context).size.width * .3,
//         ),
//         dropdownStyleData: const DropdownStyleData(
//           maxHeight: 200,
//         ),
//         menuItemStyleData: const MenuItemStyleData(
//           height: 40,
//           padding: EdgeInsets.zero,
//         ),
//         dropdownSearchData: DropdownSearchData(
//           searchController: textEditingController,
//           searchInnerWidgetHeight: 50,
//           searchInnerWidget: Container(
//             height: 50,
//             padding: const EdgeInsets.only(
//               top: 8,
//               bottom: 4,
//               right: 8,
//               left: 8,
//             ),
//             child: TextFormField(
//               expands: true,
//               maxLines: null,
//               controller: textEditingController,
//               decoration: InputDecoration(
//                 isDense: true,
//                 contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 10,
//                   vertical: 8,
//                 ),
//                 hintText: 'Search for an item...',
//                 hintStyle: const TextStyle(fontSize: 12),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//             ),
//           ),
//           searchMatchFn: (item, searchValue) {
//             return item.value.toString().contains(searchValue);
//           },
//         ));
//   }
// }

// class DropdwoenFOrVisited extends StatelessWidget {
//   DropdwoenFOrVisited({super.key});
//   List<String> a = ['مغلقه', 'مفتوحه', 'كلاهما'];
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<HiveDB>(
//       builder: (context, myType, child) {
//         return DropdownButton(
//             value: myType.x,
//             items: a
//                 .map((e) => DropdownMenuItem(
//                       value: e,
//                       child: Text(e),
//                     ))
//                 .toList(),
//             onChanged: (v) {
//               // myType.visited = v!;
//               myType.Refresh_UI();
//             });
//       },
//     );
//   }
// }

import 'package:janssen_cusomer_service/models/customer.dart';
import 'package:janssen_cusomer_service/models/ticket.dart';

class s {
  CustomerModel c;
  TicketModel t;
  s({
    required this.c,
    required this.t,
  });
}