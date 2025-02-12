import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:janssen_cusomer_service/Ui/base.dart';
import 'package:janssen_cusomer_service/Ui/recourses/sharedWidgets/textformfield.dart';
import 'package:janssen_cusomer_service/Ui/screens/rightCard/rightCard.dart';
import 'package:janssen_cusomer_service/data/localDB.dart';
import 'package:provider/provider.dart';

searchWithName(BuildContext c) {
  TEDcontrollers con = TEDcontrollers();
  TextEditingController conroller = TextEditingController();
  final List<String> types = ['طلب صيانه', 'مكالمه'];

  valdition(v) {
    if (v != '') {
      return null;
    } else {
      return 'فارغ';
    }
  }

  return showDialog(
      barrierDismissible: false,
      context: c,
      builder: (context) => Consumer<HiveDB>(
            builder: (context, myType, child) {
              FocusNode mobilnum = FocusNode();
              con.TED_mobileNum.text = conroller.text;

              final filterd =
                  myType.customers.values.where((e) => (e.cusotmerName + e.adress + e.area + e.covernorate + e.mobilenum.map((e) => e).toString()).contains(conroller.text));

              return AlertDialog(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'البحث ب الاسم',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.close))
                  ],
                ),
                content: Form(
                  key: con.formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: conroller,
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                            fillColor: const Color.fromARGB(255, 255, 255, 255),
                            filled: true,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                            hintText: 'Search',
                            hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
                            prefixIcon: Container(
                              padding: const EdgeInsets.all(15),
                              width: 18,
                              child: const Icon(Icons.search),
                            )),
                        onFieldSubmitted: (d) {
                          FocusScope.of(context).requestFocus(mobilnum);
                        },
                        onChanged: (v) {
                          myType.Refresh_UI();
                        },
                      ),
                      filterd.isEmpty && conroller.text.isNotEmpty
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width * .6,
                              height: MediaQuery.of(context).size.height * .6,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            if (con.TED_TicketType.text == 'طلب صيانه') mantananceReq(con, context, valdition),
                                            const Gap(22),
                                            if (con.TED_TicketType.text == 'مكالمه')
                                              Visibility(
                                                  child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 11),
                                                    child: Column(
                                                      children: [
                                                        SearchWithSugestions(
                                                          autofocus: false,
                                                          validator: (value) => value!.isEmpty ? 'Please select ' : null,
                                                          labal: 'سبب المكالمه',
                                                          listOfsugestions: const ["وارد", "صادر"],
                                                          TEC_forgovernmoate: con.callType,
                                                          onSubmitted: (v) {
                                                            FocusScope.of(context).nextFocus();
                                                          },
                                                        ),
                                                        const Gap(5),
                                                        SearchWithSugestions(
                                                          labal: 'سبب المكالمه',
                                                          listOfsugestions: myType.callTypes.values.map((e) => e.callType).toSet().toList(),
                                                          TEC_forgovernmoate: con.TED_callReason,
                                                          onSubmitted: (v) {
                                                            FocusScope.of(context).nextFocus();
                                                          },
                                                        ),
                                                        const Gap(5),
                                                        CustomTextFormField(
                                                            onsubmitted: (v) {
                                                              FocusScope.of(context).nextFocus();
                                                              return null;
                                                            },
                                                            autofocus: true,
                                                            hint: 'تفصيل',
                                                            width: 200,
                                                            controller: con.TED_callReasondetails),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )),
                                            Column(
                                              children: [
                                                custmerDetails(
                                                  valdition,
                                                  context,
                                                  con,
                                                  g.keys.toSet().toList(),
                                                  mobilnum,
                                                  conroller.text,
                                                ),
                                                //نوع
                                                SearchWithSugestions(
                                                  validator: (value) => value!.isEmpty ? 'Please select ' : null,
                                                  labal: 'type',
                                                  listOfsugestions: types,
                                                  TEC_forgovernmoate: con.TED_TicketType,
                                                  onSubmitted: (f) {
                                                    FocusScope.of(context).nextFocus();
                                                  },
                                                ),
                                                Gap(12),
                                                // buttoms
                                                buttoms(context, con)
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(border: Border.all(), color: const Color.fromARGB(255, 197, 197, 202)),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text("العنوان"),
                                      Text("المنطقه"),
                                      Text("المحافظه"),
                                      Text("الاسم"),
                                      Text("رقم التيلفون"),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * .6,
                                  height: MediaQuery.of(context).size.height * .6,
                                  child: SingleChildScrollView(
                                    child: Column(children: [
                                      ...filterd.take(20).map((el) => TextButton(
                                          onPressed: () {
                                            myType.shosenCustomer = null;
                                            myType.chosenTicket = null;
                                            context.read<HiveDB>().shosenCustomer = el;

                                            context.read<HiveDB>().Refresh_UI();
                                            Navigator.of(context).pop();
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(border: Border.all()),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(el.adress),
                                                Text(el.area),
                                                Text(el.covernorate),
                                                Text(el.cusotmerName),
                                                Column(
                                                  children: el.mobilenum.map((r) => Text(r)).toList(),
                                                )
                                              ],
                                            ),
                                          )))
                                    ]),
                                  ),
                                ),
                              ],
                            )
                    ],
                  ),
                ),
              );
            },
          ));
}

Column custmerDetails(String? Function(dynamic v) valdition, BuildContext context, TEDcontrollers con, List<String> governomets, FocusNode mobilnum, String d) {
  return Column(
    children: [
      const Gap(5),
      CustomTextFormField(
          focuasnode: mobilnum,
          validator: valdition,
          onsubmitted: (v) {
            FocusScope.of(context).nextFocus();
            return null;
          },
          hint: 'رقم الموبايل',
          width: 200,
          controller: con.TED_mobileNum),
      const Gap(5),
      CustomTextFormField(
          validator: valdition,
          onsubmitted: (v) {
            FocusScope.of(context).nextFocus();
            return null;
          },
          autofocus: true,
          hint: 'الاسم',
          width: 200,
          controller: con.TED_customerName),
      const Gap(5),
      SearchWithSugestions(
        validator: (p0) {
       if (g.keys.where((element) => element==p0,).isEmpty) {
         return 'اختر من المحافظات الموجوده';
       } else {
         return null;
       }
    },
        labal: 'المحافظه',
        listOfsugestions: governomets,
        TEC_forgovernmoate: con.TED_governomate,
        onSubmitted: (v) {
          FocusScope.of(context).nextFocus();
        },
      ),
    
    SearchWithSugestions(
              validator: (p1) {
       if (g.values.expand((e) => e,).toList().where((element) => element==p1,).isEmpty) {
         return 'اختر من المدن الموجوده';
       } else {
         return null;
       }
    },
        labal: 'منطقة',
        listOfsugestions: g[con.TED_governomate.text]??[],
        TEC_forgovernmoate: con.TED_area,
        onSubmitted: (v) {
          FocusScope.of(context).nextFocus();
        },
      ),
      const Gap(5),
      CustomTextFormField(
          onsubmitted: (v) {
            if (con.validate()) {
              Navigator.of(context).pop();
              context.read<HiveDB>().shosenCustomer = context.read<HiveDB>().customers.values.toList().where((e) => e.mobilenum.where((b) => b == d).isNotEmpty).first;
              context.read<HiveDB>().Refresh_UI();
            }
            return null;
          },
          autofocus: true,
          hint: 'العنوان تفصيل',
          width: 200,
          controller: con.TED_adress),
      const Gap(5),
      const Gap(5),
    ],
  );
}

Row mantananceReq(TEDcontrollers con, BuildContext context, String? Function(dynamic v) valdition) {
  FocusNode q = FocusNode();
  FocusNode place = FocusNode();
  FocusNode date = FocusNode();
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Visibility(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 11),
            child: Column(
              children: [
                SearchWithSugestions(
                  autofocus: false,
                  validator: (value) => value!.isEmpty ? 'Please select ' : null,
                  labal: 'نوع المكالمه',
                  listOfsugestions: const ["وارد", "صادر"],
                  TEC_forgovernmoate: con.callType,
                  onSubmitted: (v) {
                    FocusScope.of(context).nextFocus();
                  },
                ),
                const Gap(5),
                SearchWithSugestions(
                  validator: (value) => value!.isEmpty ? 'Please select ' : null,
                  autofocus: false,
                  labal: 'سبب المكالمه',
                  listOfsugestions: context.read<HiveDB>().callTypes.values.map((e) => e.callType).toSet().toList(),
                  TEC_forgovernmoate: con.TED_callReason,
                  onSubmitted: (v) {
                    FocusScope.of(context).nextFocus();
                  },
                ),
                const Gap(5),
                CustomTextFormField(
                    textInputAction: TextInputAction.newline,
                    onsubmitted: (v) {
                      con.TED_callresult.text = '${con.TED_callresult.text} \n';

                      return null;
                    },
                    autofocus: false,
                    hint: 'نتيجة المكالمه',
                    width: 200,
                    controller: con.TED_callresult),
              ],
            ),
          ),
        ],
      )),
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
          const Gap(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFormField(
                  onsubmitted: (v) {
                    FocusScope.of(context).requestFocus(q);
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
              focuasnode: q,
              onsubmitted: (v) {
                FocusScope.of(context).requestFocus(place);
                return null;
              },
              autofocus: true,
              hint: 'كميه',
              width: 200,
              controller: con.TED_Quantity),
          const Gap(5),
          CustomTextFormField(
              focuasnode: place,
              onsubmitted: (v) {
                FocusScope.of(context).requestFocus(date);
                return null;
              },
              autofocus: true,
              hint: 'مكان الشراس',
              width: 200,
              controller: con.TED_purchePlace),
          const Gap(5),
          CustomTextFormField(
              focuasnode: date,
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
          const Gap(5),
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
      ),
    ],
  );
}
