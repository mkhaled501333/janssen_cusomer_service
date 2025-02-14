// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names, file_names, library_private_types_in_public_api, equal_keys_in_map
// ignore_for_file: must_be_immutable

import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:janssen_cusomer_service/Ui/screens/rightCard/searchWithName.dart';
import 'package:janssen_cusomer_service/app/extentions.dart';
import 'package:janssen_cusomer_service/models/callinfo.dart';
import 'package:janssen_cusomer_service/models/ticket.dart';
import 'package:provider/provider.dart';
import 'package:tabbed_view/tabbed_view.dart';

import 'package:janssen_cusomer_service/Ui/base.dart';
import 'package:janssen_cusomer_service/Ui/recourses/sharedWidgets/textformfield.dart';
import 'package:janssen_cusomer_service/data/localDB.dart';

class RightCard extends StatelessWidget {
  const RightCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Card(
        color: const Color.fromARGB(255, 185, 206, 177),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .17,
          child: Column(
            children: [
              const Gap(12),
              Search(),
              Consumer<HiveDB>(
                builder: (context, myType, child) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Gap(6),
                      Visibility(
                          visible: myType.shosenCustomer != null,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              NewCall(),
                              const NewTicketButton(),
                            ],
                          )),
                      Visibility(
                        visible: myType.shosenCustomer != null,
                        child: TabbedViewExamplePage(
                          myType: myType,
                        ),
                      )
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CallHeader extends StatelessWidget {
  const CallHeader({
    super.key,
    required this.call,
  });
  final CallInfo call;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width * .2,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: const Color.fromARGB(255, 238, 237, 231)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(call.callDate.formatt_yMd_hms()),
                  Column(
                    children: [
                      Text('(${call.calltype})'),
                      Text('(${call.callRecipient})'),
                    ],
                  ),
                ],
              ),
              Text(
                call.callReason,
                style: const TextStyle(color: Color.fromARGB(255, 107, 1, 84)),
              ),
              Text(call.callReasonINdetails, style: const TextStyle(color: Color.fromARGB(255, 4, 157, 177))),
              Text(call.callresult, style: const TextStyle(color: Color.fromARGB(255, 43, 107, 1))),
            ],
          ),
        ),
      ),
    );
  }
}

class Search extends StatelessWidget {
  Search({
    super.key,
  });
  TEDcontrollers vm = TEDcontrollers();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              context.read<HiveDB>().shosenCustomer = null;
              context.read<HiveDB>().chosenTicket = null;

              vm.TED_mobileNum.clear();
              context.read<HiveDB>().Refresh_UI();
            },
            icon: Container(height: 30, width: 30, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red), child: const Icon(Icons.clear))),
        IconButton(
            onPressed: () {
              searchWithName(context);
            },
            icon: Container(height: 30, width: 30, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.green), child: const Icon(Icons.person_search_rounded))),
      ],
    );
  }
}

class NewTicketButton extends StatelessWidget {
  const NewTicketButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            addNedwTicketDialog(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  border: Border.all(color: const Color.fromARGB(255, 67, 30, 232), width: 1),
                  color: const Color.fromARGB(255, 139, 172, 241)),
              child: const Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5, right: 7, left: 7),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'تذكرة جديده لهذا العميل',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color.fromARGB(255, 67, 30, 232)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class NewCall extends StatelessWidget {
  NewCall({super.key});
  TEDcontrollers con = TEDcontrollers();

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (c) => AlertDialog(
                    content: Form(
                      key: con.formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Center(
                            child: Text('مكالمة جديده لهذا العميل'),
                          ),
                          SearchWithSugestions(
                            validator: (value) => value!.isEmpty ? 'Please select ' : null,
                            labal: 'type',
                            listOfsugestions: const ['وارد', 'صادر'],
                            TEC_forgovernmoate: con.TED_TicketType,
                            onSubmitted: (f) {
                              FocusScope.of(context).nextFocus();
                            },
                          ),
                          const Gap(11),
                          SearchWithSugestions(
                            labal: 'سبب المكالمه',
                            listOfsugestions: context.read<HiveDB>().callTypes.values.map((e) => e.callType).toSet().toList(),
                            TEC_forgovernmoate: con.TED_callReason,
                            onSubmitted: (v) {
                              FocusScope.of(context).nextFocus();
                            },
                          ),
                          const Gap(11),
                          SearchWithSugestions(
                            labal: 'تفصيل',
                            listOfsugestions: const [],
                            TEC_forgovernmoate: con.TED_callReasondetails,
                            onSubmitted: (f) {
                              FocusScope.of(context).nextFocus();
                            },
                          ),
                          const Gap(11),
                          SearchWithSugestions(
                            labal: 'نتيجة المكالمه',
                            listOfsugestions: const [],
                            TEC_forgovernmoate: con.TED_callresult,
                            onSubmitted: (f) {
                              FocusScope.of(context).nextFocus();
                            },
                          ),
                          const Gap(11),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.red)),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('الغاء')),
                              const Gap(11),
                              ElevatedButton(
                                  style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.green)),
                                  onPressed: () {
                                    con.addcalltocustomer(context, con.TED_TicketType.text);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('تم')),
                            ],
                          )
                        ],
                      ),
                    ),
                  ));
        },
        icon: const Icon(Icons.call));
  }
}

class TicketHeader extends StatelessWidget {
  TicketHeader({
    super.key,
    required this.ticket,
  });
  final TicketModel ticket;
  TEDcontrollers vm = TEDcontrollers();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: GestureDetector(
        onTap: () {
          context.read<HiveDB>().chosenTicket = ticket;
          context.read<HiveDB>().Refresh_UI();
        },
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 100),
          child: Container(
            width: 222,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(11), color: const Color.fromARGB(255, 249, 250, 250)),
            child: Column(
              children: [
                const Gap(7),
                Row(
                  children: [
                    ticket.Ticketresolved
                        ? Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                                  border: Border.all(color: const Color.fromARGB(255, 0, 116, 41), width: 1.6),
                                  color: const Color.fromARGB(255, 228, 246, 236)),
                              child: const Padding(
                                padding: EdgeInsets.only(top: 5, bottom: 5, right: 16, left: 16),
                                child: Text(
                                  'Ticket resolved',
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Color.fromARGB(255, 0, 116, 41)),
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                                  border: Border.all(color: const Color.fromARGB(255, 232, 140, 30), width: 1),
                                  color: const Color.fromARGB(255, 255, 223, 175)),
                              child: const Padding(
                                padding: EdgeInsets.only(top: 5, bottom: 5, right: 16, left: 16),
                                child: Text(
                                  'Pending',
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Color.fromARGB(255, 232, 140, 30)),
                                ),
                              ),
                            ),
                          ),
                    const Gap(5),
                    Text(
                      '${ticket.ticket_Num}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 126, 125, 125)),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    ticket.TicketType,
                    style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                ),
                Visibility(
                  visible: ticket.colseReason != '',
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Text(
                      ticket.colseReason,
                      style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Row buttoms(BuildContext context, TEDcontrollers con) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ElevatedButton(
          style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.red)),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'الغاء',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          )),
      const Gap(7),
      ElevatedButton(
          style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.amber)),
          onPressed: () {
            if (con.validate()) {
              if (con.TED_TicketType.text == 'طلب صيانه') {
                con.Add_NewCustomer_newTicket_newmantainceRequst(context);
              } else {
                con.addNewCustomerWithNewCall(context);
              }
              Navigator.of(context).pop();
            }
          },
          child: const Text(
            '    تم    ',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ))
    ],
  );
}
   TextEditingController v1=TextEditingController();
   TextEditingController v2=TextEditingController();
class MyWidget extends StatelessWidget {
   MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
                SearchWithSugestions(
                                            validator: (p0) {
                                              if (g.keys
                                                  .where(
                                                    (element) => element == p0,
                                                  )
                                                  .isEmpty) {
                                                return 'اختر من المحافظات الموجوده';
                                              } else {
                                                return null;
                                              }
                                            },
                                            autofocus: false,
                                            labal: 'المحافظه',
                                            listOfsugestions:
                                                g.keys.toSet().toList(),
                                            TEC_forgovernmoate:
                                                v1,
                                            onSubmitted: (v) {
                                              FocusScope.of(context)
                                                  .nextFocus();
                                            },
                                          ),
                                          const Gap(11),
                                          SearchWithSugestions(
                                          validator: (p1) {
            
            if ( g[v2.text]==null) {
              return 'اختر من المدن الموجوده';
            } else {
              if ( g[v2.text]!.where((element) => element==p1,).isEmpty) {
                  return 'اختر من المدن الموجوده';
              } else {
                  return null;
              }
            
            }
          },
                                            autofocus: false,
                                            labal: 'المنظقه',
                                            listOfsugestions:
                                                g[v1.text] ??
                                                    [],
                                            TEC_forgovernmoate: v2,
                                            onSubmitted: (v) {
                                              FocusScope.of(context)
                                                  .nextFocus();
                                            },
                                          ),
    ],);
  }
}


addNedwTicketDialog(BuildContext c) {
  TEDcontrollers con = TEDcontrollers();
  valdition(v) {
    if (v != '') {
      return null;
    } else {
      return 'فارغ';
    }
  }

  return showDialog(
      context: c,
      builder: (context) => Consumer<HiveDB>(
            builder: (context, myType, child) {
              return AlertDialog(
                title: const Text(
                  '(طلب صيانه) تذكره جديده',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                content: Form(
                  key: con.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [MyWidget(),
                        const Gap(5),
                        Column(
                          children: [
                            SearchWithSugestions(
                              labal: 'العلامة التجاريه',
                              listOfsugestions: context.read<HiveDB>().prodcuts.values.map((convert) => convert.companyName).toList(),
                              TEC_forgovernmoate: con.TED_productType,
                              onSubmitted: (f) {
                                // con.validate();
                                FocusScope.of(context).nextFocus();
                              },
                            ),
                            const Gap(5),
                            SearchWithSugestions(
                              labal: 'اسم المنتج',
                              listOfsugestions: con.TED_productType.text.isEmpty
                                  ? []
                                  : context.read<HiveDB>().prodcuts.values.where((test) => test.companyName == con.TED_productType.text).expand((e) => e.prodcuts).toList(),
                              TEC_forgovernmoate: con.TED_ProdcutName,
                              onSubmitted: (f) {
                                // con.validate();
                                FocusScope.of(context).nextFocus();
                              },
                            ),
                            const Gap(5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomTextFormField(
                                    onsubmitted: (v) {
                                      FocusScope.of(context).nextFocus();
                                      return null;
                                    },
                                    autofocus: true,
                                    hint: 'ارتفاع',
                                    width: 64,
                                    controller: con.TED_H),
                                const Gap(4),
                                CustomTextFormField(
                                    onsubmitted: (v) {
                                      FocusScope.of(context).nextFocus();
                                      return null;
                                    },
                                    autofocus: true,
                                    hint: 'عرض',
                                    width: 64,
                                    controller: con.TED_W),
                                const Gap(4),
                                CustomTextFormField(
                                    onsubmitted: (v) {
                                      FocusScope.of(context).nextFocus();
                                      return null;
                                    },
                                    autofocus: true,
                                    hint: 'طول',
                                    width: 64,
                                    controller: con.TED_L),
                              ].reversed.toList(),
                            ),
                            const Gap(5),
                            CustomTextFormField(
                                onsubmitted: (v) {
                                  FocusScope.of(context).nextFocus();
                                  return null;
                                },
                                autofocus: true,
                                hint: 'كميه',
                                width: 200,
                                controller: con.TED_Quantity),
                            const Gap(5),
                            CustomTextFormField(
                                onsubmitted: (v) {
                                  FocusScope.of(context).nextFocus();
                                  return null;
                                },
                                autofocus: true,
                                hint: 'مكان الشراس',
                                width: 200,
                                controller: con.TED_purchePlace),
                            const Gap(5),
                            CustomTextFormField(
                                ontap: () {
                                  DateTime? pickedDate;
                                  showDatePicker(context: context, firstDate: DateTime(1950), lastDate: DateTime(2090)).then((onValue) {
                                    pickedDate = onValue;
                                    if (pickedDate != null) {
                                      con.TED_purcheDate.text = pickedDate!.toString();
                                      FocusScope.of(context).nextFocus();
                                    }
                                  });
                                  return null;
                                },
                                readOnly: true,
                                onsubmitted: (v) {
                                  return null;
                                },
                                autofocus: true,
                                hint: 'تاريخ الشراء',
                                width: 200,
                                controller: con.TED_purcheDate),
                            SearchWithSugestions(
                              TEC_forgovernmoate: con.TED_RequestReason,
                              listOfsugestions: context.read<HiveDB>().reqreasons.values.map((toElement) => toElement.Reqreason).toList(),
                              validator: valdition,
                              onSubmitted: (v) {
                                FocusScope.of(context).nextFocus();
                                return null;
                              },
                              autofocus: true,
                              labal: ' سبب الطلب',
                            ),
                            const Gap(5),
                            CustomTextFormField(
                                onsubmitted: (v) {
                                  FocusScope.of(context).nextFocus();
                                  return null;
                                },
                                autofocus: true,
                                hint: 'سبب الطلب ب التفصيل',
                                width: 200,
                                controller: con.TED_RequestReasonINDetails),
                            const Gap(5),
                          ],
                        ), // : const SizedBox(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.red)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'الغاء',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                                )),
                            const Gap(7),
                            ElevatedButton(
                                style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.amber)),
                                onPressed: () {
                                  if (con.validate()) {
                                    // if (con.TED_TicketType.text ==
                                    //     'طلب صيانه') {
                                    con.addTicket(context);
                                    // }
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: const Text(
                                  '    تم    ',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ));
}

class SearchWithSugestions extends StatelessWidget {
  SearchWithSugestions({
    super.key,
    required this.listOfsugestions,
    required this.labal,
    required this.TEC_forgovernmoate,
    this.onSubmitted,
    this.validator,
    this.onselected,
    this.autofocus = true,
  });
  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();
  final List<String> listOfsugestions;

  static List<String> getSuggestions(String query, List<String> governomets) {
    List<String> matches = <String>[];
    matches.addAll(governomets);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  bool autofocus;
  String? Function(String?)? validator;
  final TextEditingController TEC_forgovernmoate;
  final Function(String)? onSubmitted;
  final Function? onselected;
// ignore: unused_field
  String? _selectedFruit;
  final String labal;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        suggestionBoxController.close();
      },
      child: SizedBox(
        width: 200,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            DropDownSearchFormField(
              textFieldConfiguration: TextFieldConfiguration(
                autofocus: autofocus,
                style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                onSubmitted: onSubmitted,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(31, 184, 161, 161),
                    labelText: labal,
                    labelStyle: const TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                    border: const OutlineInputBorder()),
                controller: TEC_forgovernmoate,
              ),
              suggestionsCallback: (pattern) {
                return getSuggestions(pattern, listOfsugestions);
              },
              itemBuilder: (context, String suggestion) {
                return ListTile(
                  title: Text(suggestion),
                );
              },
              itemSeparatorBuilder: (context, index) {
                return const Divider();
              },
              transitionBuilder: (context, suggestionsBox, controller) {
                return suggestionsBox;
              },
              onSuggestionSelected: (String suggestion) {
                context.read<HiveDB>().Refresh_UI();
                TEC_forgovernmoate.text = suggestion;
              },
              suggestionsBoxController: suggestionBoxController,
              validator: validator,
              onSaved: (value) => _selectedFruit = value,
              displayAllSuggestionWhenTap: true,
            ),
          ],
        ),
      ),
    );
  }
}
class SearchWithSugestions3 extends StatelessWidget {
  SearchWithSugestions3({
    super.key,
    required this.listOfsugestions,
    required this.labal,
    required this.TEC_forgovernmoate,
    this.onSubmitted,
    this.validator,
    required this.onselected,
    this.autofocus = true,
  });
  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();
  final List<String> listOfsugestions;

  static List<String> getSuggestions(String query, List<String> governomets) {
    List<String> matches = <String>[];
    matches.addAll(governomets);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  bool autofocus;
  String? Function(String?)? validator;
  final TextEditingController TEC_forgovernmoate;
  final Function(String)? onSubmitted;
  final void Function(String) onselected;
// ignore: unused_field
  String? _selectedFruit;
  final String labal;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        suggestionBoxController.close();
      },
      child: SizedBox(
        width: 200,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            DropDownSearchFormField(
              textFieldConfiguration: TextFieldConfiguration(
                autofocus: autofocus,
                style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                onSubmitted: onSubmitted,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(31, 184, 161, 161),
                    labelText: labal,
                    labelStyle: const TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                    border: const OutlineInputBorder()),
                controller: TEC_forgovernmoate,
              ),
              suggestionsCallback: (pattern) {
                return getSuggestions(pattern, listOfsugestions);
              },
              itemBuilder: (context, String suggestion) {
                return ListTile(
                  title: Text(suggestion),
                );
              },
              itemSeparatorBuilder: (context, index) {
                return const Divider();
              },
              transitionBuilder: (context, suggestionsBox, controller) {
                return suggestionsBox;
              },
              onSuggestionSelected:onselected,
              suggestionsBoxController: suggestionBoxController,
              validator: validator,
              onSaved: (value) => _selectedFruit = value,
              displayAllSuggestionWhenTap: true,
            ),
          ],
        ),
      ),
    );
  }
}

class SearchWithSugestions2 extends StatelessWidget {
  SearchWithSugestions2({
    super.key,
    required this.listOfsugestions,
    required this.TEC_forgovernmoate,
    this.onSubmitted,
    required this.labal,
    required this.v,
  });
  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();
  final List<String> listOfsugestions;

  static List<String> getSuggestions(String query, List<String> governomets) {
    List<String> matches = <String>[];
    matches.addAll(governomets);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  final TextEditingController TEC_forgovernmoate;
  final Function(String)? onSubmitted;
// ignore: unused_field
  String? _selectedFruit;
  final String labal;
  final Function(String) v;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        suggestionBoxController.close();
      },
      child: SizedBox(
        width: 200,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            DropDownSearchFormField(
              textFieldConfiguration: TextFieldConfiguration(
                style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                onSubmitted: onSubmitted,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(31, 184, 161, 161),
                    labelText: labal,
                    labelStyle: const TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                    border: const OutlineInputBorder()),
                controller: TEC_forgovernmoate,
              ),
              suggestionsCallback: (pattern) {
                return getSuggestions(pattern, listOfsugestions);
              },
              itemBuilder: (context, String suggestion) {
                return ListTile(
                  title: Text(suggestion),
                );
              },
              itemSeparatorBuilder: (context, index) {
                return const Divider();
              },
              transitionBuilder: (context, suggestionsBox, controller) {
                return suggestionsBox;
              },
              onSuggestionSelected: v,
              suggestionsBoxController: suggestionBoxController,
              // validator: (value) => value!.isEmpty ? 'Please select ' : null,
              onSaved: (value) => _selectedFruit = value,
              displayAllSuggestionWhenTap: true,
            ),
          ],
        ),
      ),
    );
  }
}


 Map<String,List<String>> g={} ;
 
  Map<String,List<String>> g33=
 {
'اسوان':[ ' نصر النوبة',
 ' كوم أمبو',
 ' كلابشة',
 ' دراو',
 ' أسوان',
 ' أبو سمبل',
 ' إدفو',
 ' السباعية',
 ' الرديسية',
 ' البصيلية',
],
'اسيوط':[ ' منفلوط',
 ' باقور',
 ' منفلوط',
 ' صدفا',
 ' ساحل سليم',
 ' أسيوط',
 ' أبو تيج',
 ' أبنوب',
 ' القوصية',
 ' الغنايم',
 ' البداري',
 ' ديروط',
],


"الاسكندريه":[ ' برج العرب',
 ' مينا البصل',
 ' ميامي',
 ' محطة الرمل',
 ' محرم بك',
 ' كوم الدكة',
 ' كفر عبده',
 ' كرموز',
 ' اسكندرية',
 ' فيكتوريا',
 ' شدس',
 ' سيدي كرير',
 ' اسكندرية الصحراوى',
 ' سيدي جابر',
 ' سيدي بشر',
 ' سموحة',
 ' سبورتنج',
 ' سان ستيفانو',
 ' زيزينيا',
 ' رشدي',
 ' جناكليس',
 ' جليم',
 ' الابراهيمية',
 ' بولكلي',
 ' بحري',
 ' باكوس',
 ' أبو قير',
 ' أبو صير',
 ' الورديان',
 ' النهضة',
 ' النزهة',
 ' المنشية',
 ' المندرة',
 ' المنتزه',
 ' المعمورة',
 ' القباري',
 ' العصافرة',
 ' العجمي',
 ' العامرية',
 ' الساحل الشمالى',
 ' الظاهرية',
 ' الشيخ مبروك',
 ' الشاطبي',
 ' السيوف',
 ' الحضرة الجديدة',
 ' الحضرة',
 ' الأنفوشي',
],
"الاسماعيليه":[ ' نفيشة',
 ' فايد',
 ' عين غصين',
 ' أبو صوير',
 ' القنطرة غرب',
 ' القنطرة شرق',
 ' القصاصين',
 ' سرابيوم',
 ' التل الكبير',
 ' الاسماعلية',
],

"الاقصر":[ ' نجع بويل',
 ' كيمان المطاعنة',
 ' القرايا',
 ' العشي',
 ' الأقصر',
 ' ارمنت',
],

"البحر الاحمر":[ ' مرسى علم',
 ' سفاجا',
 ' زعفرانة',
 ' رأس غارب',
 ' راس سدر',
 ' حلايب',
 ' برنيس',
 ' أبو رماد',
 ' يبورت غالب',
 ' القصير',
 ' الغردقة',
 ' الشلاتين',
 ' الجونة',
],
"البحيرة":[ ' الرحمانية',
 ' كفر الدوار',
 ' البحيرة',
 ' وادي النطرون',
 ' نوبارية',
 ' منية بني موسى',
 ' مركوب',
 ' محلة فرنوي',
 ' كوم حمادة',
 ' كوم القناطر',
 ' كفر بولين',
 ' فزارة',
 ' صفط الحرية',
 ' شبراخيت',
 ' زاوية غزال',
 ' رشيد',
 ' دير الأنبا بيشوي',
 ' دمنهور',
 ' حوش عيسى',
 ' جزيرة نكلا',
 ' بويط',
 ' برج رشيد',
 ' بدر',
 ' أبو حمص',
 ' أبو المطامير',
 ' إيتاي البارود',
 ' إدكو',
 ' إدفينا',
 ' النوبارية الجديدة',
 ' النقراشي',
 ' المعركة',
 ' المحمودية',
 ' العطف',
 ' الشماس',
 ' الدواجن',
 ' الدلنجات',
 ' الدعبوسي',
 ' الجدي',
 ' البوصيلة',
],
"الجيزه":[ ' العمرانية',
 ' المنيب',
 ' المريوطية',
 ' ناهيا',
 ' ميت عقبة',
 ' منشأة القناطر',
 ' مدينة سفنكس الجديدة',
 ' مدينة أكتوبر الجديدة',
 ' مدينة 6 أكتوبر',
 ' كفر غطاطي',
 ' كرداسة',
 ' قصر الهرم',
 ' فيصل',
 ' المهندسين',
 ' طموه',
 ' سقارة',
 ' الجيزة الجديده',
 ' دهشور',
 ' حدائق أكتوبر',
 ' حدائق الأهرام',
 ' جزيرة الدهب',
 ' بولاق الدكرور',
 ' بشتيل',
 ' أوسيم',
 ' أطفيح',
 ' أبو رواش',
 ' أبو النمرس',
 ' البراجيل',
 ' امبابة',
 ' الوراق',
 ' الواحات البحرية الجديدة',
 ' الواحات البحرية',
 ' الهرم',
 ' المنصورية',
 ' المناشي',
 ' الكيت كات',
 ' محور اللبيني',
 ' القرية الذكية',
 ' مدينة الخمائل أكتوبر',
 ' العياط',
 ' العجوزة',
 ' الصف',
 ' الشيخ زايد',
 ' الدقي',
 ' الحوامدية',
 ' الجيزة',
 ' ارض اللواء',
 ' البدرشين',
 ' الباويطي',
 ' نزلة السمان',
 ' كفر طهرمس',
],
"الدقهليه":[ ' نوسا الغيط',
 ' نبروه',
 ' ميدوم',
 ' ميت غمر',
 ' ميت سلسيل',
 ' ميت بدر حلاوة',
 ' ميت أبو خالد',
 ' منية النصر',
 ' كفر هلال',
 ' كفر ميت فارس',
 ' كفر سنجاب',
 ' كفر النعيم',
 ' كفر العنانية',
 ' كفر الصلاحات',
 ' كفر الشيخ هلال',
 ' كفر الحطبة',
 ' كفر الترعة الجديد',
 ' كفر الأمير',
 ' طلخا',
 ' شربين',
 ' ديمشلت',
 ' دكرنس',
 ' جمصة',
 ' تمي الأمديد',
 ' بني عبيد',
 ' بلقاس',
 ' بسنديلة',
 ' أجا',
 ' المنصورة',
 ' المنزلة',
 ' الملعب',
 ' الكردي',
 ' السنبلاوين',
 ' الجوابر',
 ' الجمالية',
 ' البصراط',
 ' البدالة',
 ' محلة دمنة',
],
"السويس":[ ' العين السخنة',
 '  حى عتاقة',
 ' الالبان الجديدة',
 ' حي الجناين',
 ' الكبريت',
 ' حي الأربعين',
 ' السويس (حي السويس)',
 ' السويس',
],
"الشرقية":[ ' الغار',
 ' القرين',
 ' ههيا',
 ' منيا القمح',
 ' منشأة أبو عمر',
 ' منزل حيان',
 ' مشتول السوق',
 ' كفر صقر',
 ' كفر حماد',
 ' كفر أبو نجم',
 ' كفر أبراش',
 ' فاقوس',
 ' صفط زريق',
 ' صان الحجر',
 ' ديرب نجم',
 ' بيشة قايد',
 ' السماعنة',
 ' بني شبل',
 ' بلبيس',
 ' قصاصين الأزهار',
 ' بردين',
 ' أولاد صقر',
 ' أنشاص',
 ' المناجاة الكبرى',
 ' أبو مسعود',
 ' أبو كبير',
 ' أبو حماد',
 ' القنايات',
 ' القطاوية',
 ' العزيزية',
 ' العدلية',
 ' العاشر من رمضان',
 ' الصالحية',
 ' الطويلة',
 ' الصالحية الجديدة',
 ' الشوبك',
 ' الشبانات',
 ' الزهراء',
 ' الزقازيق',
 ' الحسينية',
 ' البلاشون',
 ' الإبراهيمية',
],
"الغربيه":[ ' مركز سمنود',
 ' كفر الزيات',
 ' المحله الكبرى',
 ' طنطا',
 ' طنبارة',
 ' شبرابيل',
 ' سمنود',
 ' زفتي',
 ' بسيون',
 ' محلة زايد',
 ' شبرا قاص',
 ' السجاعية',
 ' بشبيش',
 ' القطور',
 ' السنطة',
 ' بلكيم',
 ' محلة روح',
],
"الغربيه":[ ' يوسف الصديق',
 ' طامية',
 ' سنورس',
 ' إطسا',
 ' إبشواي',
 ' الناصرية',
 ' مناشي الخطيب',
 ' الفيوم الجديدة',
 ' الفيوم',
 ' تطون',
],
"القاهرة":[ ' الحلمية',
 ' وسط البلد',
 ' الخليفة المامون',
 ' منشية ناصر',
 ' النرجس',
 ' مصر القديمة',
 ' جسر السويس',
 ' المطرية',
 ' برج القاهرة',
 ' حلمية الزيتون',
 ' الف مسكان',
 ' ميدان طلعت حرب',
 ' مصر الجديدة',
 ' الدرب الأحمر',
 ' مدينتي',
 ' 15 مايو',
 ' القاهرة الجديدة',
 ' الأباجية',
 ' اللوتس',
 ' القلعة',
 ' مدينة هليوبوليس الجديدة',
 ' مدينة نصر',
 ' مدينة بدر',
 ' الشرابية',
 ' مدينة المعراج',
 ' موسسة الذكاة',
 ' مدينة السلام',
 ' مدينة الأمل (عزبة الهجانة سابقاً)',
 ' مدينة الأمل',
 ' غمرة',
 ' عين شمس',
 ' عزبة الوالدة',
 ' عزبة النخل',
 ' الجولف',
 ' عابدين',
 ' شيراتون',
 ' الزيتون',
 ' شبرا مصر',
 ' زهراء مدينة نصر',
 ' زهراء المعادي',
 ' روض الفرج',
 ' السواح',
 ' حى البنفسج',
 ' دار السلام',
 ' العتبة',
 ' ميدان التحرير',
 ' ميدان رابعة العدوية',
 ' حلوان',
 ' حدائق القبة',
 ' حدائق العاصمة',
 ' جزيرة الذهب',
 ' جاردن سيتي',
 ' بولاق أبو العلا',
 ' باب الشعرية',
 ' الوايلي',
 ' النزهة الجديدة',
 ' المنيل',
 ' المقطم',
 ' المعادي',
 ' المطرية',
 ' المرج الجديدة',
 ' المرج',
 ' القطامية',
 ' العباسية',
 ' الهضبة الوسطى',
 ' العاصمة الاداريه',
 ' الظاهر',
 ' الشروق',
 ' السيدة عائشة',
 ' السيدة زينب',
 ' جاردينيا سيتي',
 ' الزمالك',
 ' الزاوية الحمراء',
 ' الرحاب',
 ' التجمع الخامس',
 ' التجمع الثالث',
 ' التجمع الأول',
 ' التبين',
 ' البساتين',
 ' المعصرة',
],
"القليوبية":[ ' كفر الفقهاء',
 ' البرادعة',
 ' نوى',
 ' نامول',
 ' ميت كنانة',
 ' ميت العطار',
 ' مشتهر',
 ' نقابس',
 ' مرصفا',
 ' كفر شكر',
 ' كفر تصفا',
 ' كفر أبو زهرة',
 ' كفر العمار',
 ' كفر الجزار',
 ' قليوب',
 ' عرب الرمل',
 ' طوخ',
 ' طحوريا',
 ' شبين القناطر',
 ' شبرا الخيمة',
 ' سنديون',
 ' سندبيس',
 ' سرياقوس',
 ' ترسا',
 ' بنها',
 ' بلقس',
 ' بجيرم',
 ' بتمدة',
 ' باسوس',
 ' عزبة النخل',
 ' مسطورد',
 ' أجهور الكبرى',
 ' أبو زعبل',
 ' المنيرة',
 ' المنشأة الكبرى',
 ' القناطر الخيرية',
 ' العبور',
 ' السيفا',
 ' الدير',
 ' الخصوص',
 ' الخانكة',
 ' الجبل الأصفر',
 ' قها',
],
"المنوفية":[ ' منوف',
 ' منشأة سلطان',
 ' مليج',
 ' مركز قصر الشهداء',
 ' مركز تلا',
 ' اشمعون',
 ' مركز المنوفية',
 ' سمادون',
 ' مركز الشهداء',
 ' مركز الباجور',
 ' قويسنا',
 ' عزبة علي',
 ' شبين الكوم',
 ' ساقية المنوفية',
 ' بندر منوف',
 ' بركة السبع',
 ' أشمون',
 ' المنوفية',
 ' مدينة السادات',
 ' مدينة الشهداء',
],
"المنيا":[ ' الشيخ فضل',
 ' ملوي',
 ' مغاغة',
 ' مطاي',
 ' سمالوط',
 ' دير مواس',
 ' بني مزار',
 ' أبو قرقاص',
 ' البرجاية',
 ' الاشمونين',
 ' المنيا الجديدة',
 ' المنيا',
 ' العدوة',
],
"الوادى الجديد":[ ' موط',
 ' الفرافرة',
 ' أبو منقار',
 ' الداخلة',
 ' الخارجة',
],
"بنى سويف":[ ' ناصر',
 ' بني سويف',
 ' بني سليمان',
 ' باها',
 ' إهناسيا',
 ' سمساط الوقف',
 ' بهبشين',
 ' سفط راشين',
 ' الحبية',
 ' الواسطى',
 ' ببا',
 ' الميمون',
 ' الفشن',
],
"بورسعيد":[ ' حي غرب',
 ' حي المناخ',
 ' الحسينية',
 ' حي الضواحي',
 ' حي الزهور',
 ' بورفؤاد',
 ' بورسعيد ',
 ' الجنوب (منطقة بحر البقر)',
],
"جنوب سيناء":[ ' نويبع',
 ' طابا',
 ' شرم الشيخ',
 ' سانت كاترين',
 ' رأس سدر',
 ' دهب',
 ' أبو زنيمة',
 ' أبو رديس',
 ' الطور',
 ' الرويسات',
],
"دمياط":[ ' عزبة البرج',
 ' ميت أبو غالب',
 ' لروضة',
 ' كفر سعد',
 ' كفر البطيخ',
 ' فارسكور',
 ' راس البر',
 ' دمياط',
 '  لزرقا',
 ' مدينة دمياط الجديدة',
],
"سوهاج":[ ' طهطا',
 ' طما',
 ' سوهاج',
 ' جهينة',
 ' المنشاة',
 ' العسيرات',
 ' أبيدوس',
 ' المراغة',
 ' البلينا',
],
"شمال سيناء":[ ' نخل',
 ' رمانة',
 ' رفح',
 ' بئر العبد',
 ' القصيمة',
 ' العريش',
 ' الشيخ زويد',
 ' الحسنة',
 ' الجورة',
 ' البرث',
],
"قنا":[ ' ابوطشت',
 ' نجع حمادي',
 ' قوص',
 ' قنا',
 ' قفط',
 ' دشنا',
 ' الوقف',
 ' الحجيرات',
],
"كفر الشيخ":[ ' منشأة أبو علي',
 ' مطوبس',
 ' مصيف بلطيم',
 ' كفر الشيخ',
 ' فوه',
 ' سيدي سالم',
 ' دسوق',
 ' بيلا',
 ' بلطيم',
 ' الرياض',
 ' الحامول',
],
"مرسى مطروح":[ ' مرسى مطروح',
 ' سيوة',
 ' سيدي براني',
 ' رأس الحكمة',
 ' براني',
 ' النجيلة',
 ' العلمين',
 ' الضبعة',
 ' السلوم',
 ' الحمام',
],
};

class TabbedViewExamplePage extends StatelessWidget {
  TabbedViewExamplePage({
    super.key,
    required this.myType,
  });
  late TabbedViewController _controller;
  final HiveDB myType;
  @override
  Widget build(BuildContext context) {
    List<TabData> tabs = [
      TabData(
          keepAlive: true,
          closable: false,
          text: '(${myType.shosenCustomer!.tickets.length}) Tickets',
          content: Container(
            color: const Color.fromARGB(255, 185, 206, 177),
            child: SingleChildScrollView(
              child: Column(
                children: myType.shosenCustomer != null
                    ? [
                        ...myType.shosenCustomer!.tickets.map((e) => TicketHeader(
                              ticket: e,
                            )),
                      ]
                    : [],
              ),
            ),
          )),
      TabData(
          closable: false,
          text: '(${myType.shosenCustomer!.calls.length}) المكالمات',
          content: Container(
            color: const Color.fromARGB(255, 185, 206, 177),
            child: SingleChildScrollView(
              child: Column(
                children: myType.shosenCustomer != null ? [...myType.shosenCustomer!.calls.map((e) => CallHeader(call: e))] : [],
              ),
            ),
          ),
          keepAlive: true)
    ];

    _controller = TabbedViewController(tabs);
    TabbedView tabbedView = TabbedView(controller: _controller);
    Widget w = TabbedViewTheme(data: TabbedViewThemeData.mobile(colorSet: Colors.green, fontSize: 16, accentColor: const Color.fromARGB(255, 202, 24, 107)), child: tabbedView);
    return SizedBox(
      child: Container(height: MediaQuery.of(context).size.height - 250, color: const Color.fromARGB(255, 185, 206, 177), width: 999, padding: const EdgeInsets.all(11), child: w),
    );
  }
}
