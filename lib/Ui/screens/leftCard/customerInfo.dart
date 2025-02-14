import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:janssen_cusomer_service/Ui/base.dart';
import 'package:janssen_cusomer_service/Ui/recourses/sharedWidgets/textformfield.dart';
import 'package:janssen_cusomer_service/Ui/screens/rightCard/rightCard.dart';
import 'package:janssen_cusomer_service/data/localDB.dart';
import 'package:janssen_cusomer_service/models/customer.dart';
import 'package:provider/provider.dart';

class CustomerInfo extends StatelessWidget {
  const CustomerInfo({
    super.key,
    required this.customer,
  });
  final CustomerModel customer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 211, 210, 210),
              borderRadius: BorderRadius.vertical(top: Radius.circular(5))),
          child: const Center(
              child: Text(
            "Customer Info",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          )),
        ),
        Container(
          height: MediaQuery.of(context).size.height * .27,
          decoration: const BoxDecoration(
              color: Color.fromRGBO(246, 246, 248, 1),
              borderRadius: BorderRadius.vertical(top: Radius.circular(5))),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 9, bottom: 6),
                      child: Text(
                        " اسم العميل : ${customer.cusotmerName}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    ...customer.mobilenum.map(
                      (e) => Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 9, bottom: 1),
                            child: Row(
                              children: [
                                Text(
                                  " موبايل ${customer.mobilenum.indexOf(e) + 1} : $e",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                              visible: customer.mobilenum.indexOf(e) == 0,
                              child: GestureDetector(
                                  onTap: () {
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
                                                            FocusScope.of(
                                                                    context)
                                                                .nextFocus();
                                                            return null;
                                                          },
                                                          autofocus: true,
                                                          hint: 'رقم تلفون',
                                                          width: 200,
                                                          controller: vm
                                                              .TED_callReason),
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            if (vm.validate()) {
                                                              context
                                                                  .read<
                                                                      HiveDB>()
                                                                  .shosenCustomer!
                                                                  .mobilenum
                                                                  .add(vm
                                                                      .TED_callReason
                                                                      .text);
                                                              context
                                                                  .read<
                                                                      HiveDB>()
                                                                  .updatecustomer(context
                                                                      .read<
                                                                          HiveDB>()
                                                                      .shosenCustomer!);
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            }
                                                          },
                                                          child:
                                                              const Text('ok'))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ));
                                  },
                                  child: const Icon(
                                      color: Colors.blue, Icons.add))),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 9, bottom: 6),
                      child: Text(
                        " المحافظه : ${customer.covernorate}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 9, bottom: 6),
                      child: Text(
                        " المنطقه : ${customer.area}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 9, bottom: 6),
                      child: Text(
                        " العنوان : ${customer.adress}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {
                      TEDcontrollers vm = TEDcontrollers();
                      vm.TED_governomate.text = customer.covernorate;
                      vm.TED_area.text = customer.area;
                      vm.TED_adress.text = customer.adress;
                      vm.TED_customerName.text = customer.cusotmerName;
                      showDialog(
                          context: context,
                          builder: (c) => AlertDialog(
                                content: SizedBox(
                                  height: 444,
                                  child: Form(
                                    key: vm.formKey,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          ...customer.mobilenum
                                              .map((e) => TextButton(
                                                    onPressed: () {
                                                      TextEditingController
                                                          controller =
                                                          TextEditingController();
                                                      controller.text = e;
                                                      showDialog(
                                                          context: context,
                                                          builder:
                                                              (c) =>
                                                                  AlertDialog(
                                                                    content:
                                                                        SizedBox(
                                                                      width:
                                                                          120,
                                                                      height:
                                                                          150,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          CustomTextFormField(
                                                                              onsubmitted: (v) {
                                                                                FocusScope.of(context).nextFocus();
                                                                                return null;
                                                                              },
                                                                              autofocus: true,
                                                                              hint: e,
                                                                              width: 200,
                                                                              controller: controller),
                                                                          ElevatedButton(
                                                                              onPressed: () {
                                                                                if (vm.validate()) {
                                                                                  context.read<HiveDB>().shosenCustomer!.mobilenum.removeWhere((test) => test == e);
                                                                                  context.read<HiveDB>().shosenCustomer!.mobilenum.add(controller.text);

                                                                                  context.read<HiveDB>().updatecustomer(context.read<HiveDB>().shosenCustomer!);
                                                                                  Navigator.of(context).pop();
                                                                                  Navigator.of(context).pop();
                                                                                }
                                                                              },
                                                                              child: const Text('ok'))
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ));
                                                    },
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                            border:
                                                                Border.all(),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        9),
                                                            color: const Color
                                                                .fromARGB(66,
                                                                137, 244, 219)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            e,
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        )),
                                                  )),
                                          CustomTextFormField(
                                              onsubmitted: (v) {
                                                FocusScope.of(context)
                                                    .nextFocus();
                                                return null;
                                              },
                                              autofocus: true,
                                              hint: 'الاسم',
                                              width: 200,
                                              controller: vm.TED_customerName),
                                          const Gap(11),
                                          NewWidget(vm: vm),
                                          const Gap(11),
                                          CustomTextFormField(
                                              onsubmitted: (v) {
                                                FocusScope.of(context)
                                                    .nextFocus();
                                                return null;
                                              },
                                              autofocus: true,
                                              hint: 'العنوان',
                                              width: 200,
                                              controller: vm.TED_adress),
                                          const Gap(11),
                                          ElevatedButton(
                                              onPressed: () {
                                                if (vm.validate()) {
                                                  context
                                                          .read<HiveDB>()
                                                          .shosenCustomer!
                                                          .covernorate =
                                                      vm.TED_governomate.text;
                                                  context
                                                      .read<HiveDB>()
                                                      .shosenCustomer!
                                                      .area = vm.TED_area.text;
                                                  context
                                                          .read<HiveDB>()
                                                          .shosenCustomer!
                                                          .adress =
                                                      vm.TED_adress.text;
                                                  context
                                                          .read<HiveDB>()
                                                          .shosenCustomer!
                                                          .cusotmerName =
                                                      vm.TED_customerName.text;
                                                  context
                                                      .read<HiveDB>()
                                                      .updatecustomer(context
                                                          .read<HiveDB>()
                                                          .shosenCustomer!);
                                                  Navigator.of(context).pop();
                                                }
                                              },
                                              child: const Text('ok'))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ));
                    },
                    icon: const Icon(Icons.edit))
              ],
            ),
          ),
        )
      ],
    );
  }
}

class NewWidget extends StatefulWidget {
  const NewWidget({
    super.key,
    required this.vm,
  });

  final TEDcontrollers vm;

  @override
  State<NewWidget> createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchWithSugestions3(
          onselected: (p0) {
            setState(() {
              widget.vm.TED_governomate.text = p0;
            });
          },
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
          listOfsugestions: g.keys.toSet().toList(),
          TEC_forgovernmoate: widget.vm.TED_governomate,
          onSubmitted: (v) {
            FocusScope.of(context).nextFocus();
          },
        ),
        const Gap(11),
        SearchWithSugestions3(
          onselected: (p0) {
            widget.vm.TED_area.text = p0;
          },
          validator: (p1) {
            
            if ( g[widget.vm.TED_governomate.text]==null) {
              return 'اختر من المدن الموجوده';
            } else {
              if ( g[widget.vm.TED_governomate.text]!.where((element) => element==p1,).isEmpty) {
                  return 'اختر من المدن الموجوده';
              } else {
                  return null;
              }
            
            }
          },
          autofocus: false,
          labal: 'المنظقه',
          listOfsugestions: g[widget.vm.TED_governomate.text] ?? [],
          TEC_forgovernmoate: widget.vm.TED_area,
          onSubmitted: (v) {
            FocusScope.of(context).nextFocus();
          },
        ),
      ],
    );
  }
}
