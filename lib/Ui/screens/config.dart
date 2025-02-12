// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';
import 'package:janssen_cusomer_service/Ui/screens/rightCard/rightCard.dart';
import 'package:janssen_cusomer_service/Ui/users/usersManagementView.dart';
import 'package:janssen_cusomer_service/app/actions.dart';
import 'package:janssen_cusomer_service/data/localDB.dart';
import 'package:janssen_cusomer_service/models/governomates.dart';
import 'package:janssen_cusomer_service/models/models.dart';
import 'package:provider/provider.dart';
import 'package:tabbed_view/tabbed_view.dart';

class Config extends StatelessWidget {
  Config({super.key});
  late TabbedViewController _controller;
  List<TabData> tabs = [
    TabData(
        value: 2,
        keepAlive: true,
        closable: false,
        text: ' العلامات التجاريه والمنتجات',
        content: Container(
          color: const Color.fromARGB(255, 185, 206, 177),
          child: const CompanysandProducts(),
        )),
    TabData(
        value: 1,
        closable: false,
        text: ' اسباب المكالمات',
        content: Container(
          color: const Color.fromARGB(255, 185, 206, 177),
          child: const CallTyeps(),
        ),
        keepAlive: true),
    TabData(
        value: 1,
        closable: false,
        text: ' اسباب الطلبات',
        content: Container(
          color: const Color.fromARGB(255, 185, 206, 177),
          child: const reqreasonss(),
        ),
        keepAlive: true),
    TabData(
        value: 1,
        closable: false,
        text: ' المحافظات',
        content: Container(
          color: const Color.fromARGB(255, 185, 206, 177),
          child: const Governomates(),
        ),
        keepAlive: true)
  ];

  @override
  Widget build(BuildContext context) {
    _controller = TabbedViewController(tabs);
    TabbedView tabbedView = TabbedView(controller: _controller);
    Widget w = TabbedViewTheme(
        data: TabbedViewThemeData.mobile(
            colorSet: Colors.green,
            fontSize: 16,
            accentColor: const Color.fromARGB(255, 202, 24, 107)),
        child: tabbedView);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 201, 207, 199),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 152, 137),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          color: const Color.fromARGB(255, 185, 206, 177),
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(11),
          child: w),
    );
  }
}

class Governomates extends StatelessWidget {
  const Governomates({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HiveDB>(
      builder: (context, myType, child) {
        return SingleChildScrollView(
          child: Column(
            children: [
              ...myType.governamates.values.map((gov) => Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                      side: const BorderSide(
                        color: Colors.black,
                        width: 0.4,
                      ),
                    ),
                    child: ExpansionTile(
                      leading: const Icon(Icons.today),
                      title: Text(gov.governo),
                      subtitle: const Text(' '),
                      children: [
                        Wrap(
                          spacing: 9,
                          children: gov.cityies
                              .map((city) => ElevatedButton(
                                    style: const ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll(
                                            Color.fromARGB(
                                                255, 176, 224, 131))),
                                    onPressed: () {
                                      TextEditingController t =
                                          TextEditingController();
                                      t.text = city;
                                      showDialog(
                                          context: context,
                                          builder: (c) => AlertDialog(
                                                title:
                                                    const Text('تعديل او حذف'),
                                                content: SizedBox(
                                                  width: 100,
                                                  height: 170,
                                                  child: Column(
                                                    children: [
                                                      TextField(
                                                        controller: t,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          ElevatedButton(
                                                              onPressed: () {
                                                                List<String>
                                                                    cityies =
                                                                    gov.cityies;
                                                                cityies[gov
                                                                    .cityies
                                                                    .indexOf(
                                                                        city)] = t
                                                                    .text;
                                                                myType.addtogovernomates(governomate(
                                                                    id: gov.id,
                                                                    governo: gov
                                                                        .governo,
                                                                    cityies:
                                                                        cityies));
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                  "تعديل")),
                                                          ElevatedButton(
                                                              style: const ButtonStyle(
                                                                  backgroundColor:
                                                                      WidgetStatePropertyAll(
                                                                          Colors
                                                                              .red)),
                                                              onPressed: () {
                                                                gov.cityies
                                                                    .removeAt(gov
                                                                        .cityies
                                                                        .indexOf(
                                                                            city));

                                                                myType
                                                                    .addtogovernomates(
                                                                        gov);
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                  "حذف")),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ));
                                    },
                                    child: Text(city),
                                  ))
                              .toList(),
                        ),
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.end,
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     IconButton(
                        //       icon: const Icon(Icons.add),
                        //       onPressed: () {
                        //         TextEditingController t = TextEditingController();

                        //         showDialog(
                        //             context: context,
                        //             builder: (c) => AlertDialog(
                        //                   title: const Text('اضافة منتج'),
                        //                   content: SizedBox(
                        //                     width: 100,
                        //                     height: 170,
                        //                     child: Column(
                        //                       children: [
                        //                         TextField(
                        //                           controller: t,
                        //                         ),
                        //                         Row(
                        //                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //                           children: [
                        //                             ElevatedButton(
                        //                                 onPressed: () {
                        //                                   e.prodcuts.add(t.text);
                        //                                   myType.addProdcuts(e);
                        //                                   Navigator.pop(context);
                        //                                 },
                        //                                 child: const Text("تم")),
                        //                           ],
                        //                         )
                        //                       ],
                        //                     ),
                        //                   ),
                        //                 ));
                        //       },
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }
}

class CompanysandProducts extends StatelessWidget {
  const CompanysandProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HiveDB>(
      builder: (context, myType, child) {
        return SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    TextEditingController t = TextEditingController();
                    showDialog(
                        context: context,
                        builder: (c) => AlertDialog(
                              title: const Text('اضافة علامة تجاريه جديده'),
                              content: SizedBox(
                                width: 100,
                                height: 170,
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: t,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              myType.addProdcuts(ProdcutsModel(
                                                  id: DateTime.now()
                                                      .microsecondsSinceEpoch,
                                                  companyName: t.text,
                                                  prodcuts: [],
                                                  actions: []));
                                              Navigator.pop(context);
                                            },
                                            child: const Text("تم")),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ));
                  },
                  child: const Text("Add New")),
              ...myType.prodcuts.values.map((e) => Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                      side: const BorderSide(
                        color: Colors.black,
                        width: 0.4,
                      ),
                    ),
                    child: ExpansionTile(
                      trailing: ElevatedButton(
                          onPressed: () {
                            TextEditingController t = TextEditingController();
                            t.text = e.companyName;
                            showDialog(
                                context: context,
                                builder: (c) => AlertDialog(
                                      title: const Text('تعديل او حذف'),
                                      content: SizedBox(
                                        width: 100,
                                        height: 170,
                                        child: Column(
                                          children: [
                                            TextField(
                                              controller: t,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      e.companyName = t.text;

                                                      myType.addProdcuts(e);
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("تم")),
                                                ElevatedButton(
                                                    style: const ButtonStyle(
                                                        backgroundColor:
                                                            WidgetStatePropertyAll(
                                                                Colors.red)),
                                                    onPressed: () {
                                                      e.actions.add(
                                                          ProdcutsAction
                                                              .archive.add);

                                                      myType.addProdcuts(e);
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("حذف")),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ));
                          },
                          child: const Icon(Icons.edit)),
                      leading: const Icon(Icons.today),
                      title: Text(e.companyName),
                      subtitle: const Text(' '),
                      children: [
                        Wrap(
                          spacing: 9,
                          children: e.prodcuts
                              .map((p) => ElevatedButton(
                                    style: const ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll(
                                            Color.fromARGB(
                                                255, 176, 224, 131))),
                                    onPressed: () {
                                      TextEditingController t =
                                          TextEditingController();
                                      t.text = p;
                                      showDialog(
                                          context: context,
                                          builder: (c) => AlertDialog(
                                                title:
                                                    const Text('تعديل او حذف'),
                                                content: SizedBox(
                                                  width: 100,
                                                  height: 170,
                                                  child: Column(
                                                    children: [
                                                      TextField(
                                                        controller: t,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          ElevatedButton(
                                                              onPressed: () {
                                                                var i = e
                                                                    .prodcuts
                                                                    .indexOf(p);
                                                                e.prodcuts
                                                                    .removeAt(
                                                                        i);
                                                                e.prodcuts.add(
                                                                    t.text);
                                                                myType
                                                                    .addProdcuts(
                                                                        e);
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                  "تعديل")),
                                                          ElevatedButton(
                                                              style: const ButtonStyle(
                                                                  backgroundColor:
                                                                      WidgetStatePropertyAll(
                                                                          Colors
                                                                              .red)),
                                                              onPressed: () {
                                                                var i = e
                                                                    .prodcuts
                                                                    .indexOf(p);
                                                                e.prodcuts
                                                                    .removeAt(
                                                                        i);

                                                                myType
                                                                    .addProdcuts(
                                                                        e);
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                  "حذف")),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ));
                                    },
                                    child: Text(p.toString()),
                                  ))
                              .toList(),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                TextEditingController t =
                                    TextEditingController();

                                showDialog(
                                    context: context,
                                    builder: (c) => AlertDialog(
                                          title: const Text('اضافة منتج'),
                                          content: SizedBox(
                                            width: 100,
                                            height: 170,
                                            child: Column(
                                              children: [
                                                TextField(
                                                  controller: t,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          e.prodcuts
                                                              .add(t.text);
                                                          myType.addProdcuts(e);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child:
                                                            const Text("تم")),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ));
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }
}

class CallTyeps extends StatelessWidget {
  const CallTyeps({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HiveDB>(
      builder: (context, myType, child) {
        return SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    TextEditingController t = TextEditingController();
                    showDialog(
                        context: context,
                        builder: (c) => AlertDialog(
                              title: const Text('اضافة سبب مكالمة'),
                              content: SizedBox(
                                width: 100,
                                height: 170,
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: t,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              myType.addcallType(CallTypeModel(
                                                  id: DateTime.now()
                                                      .microsecondsSinceEpoch,
                                                  callType: t.text,
                                                  actions: []));
                                              Navigator.pop(context);
                                            },
                                            child: const Text("تم")),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ));
                  },
                  child: const Text("Add New")),
              const Gap(22),
              Wrap(
                alignment: WrapAlignment.start,
                spacing: 9,
                children: myType.callTypes.values
                    .map((e) => ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.amber)),
                        onPressed: () {
                          TextEditingController t = TextEditingController();
                          t.text = e.callType;
                          showDialog(
                              context: context,
                              builder: (c) => AlertDialog(
                                    title: const Text('تعديل او حذف'),
                                    content: SizedBox(
                                      width: 100,
                                      height: 170,
                                      child: Column(
                                        children: [
                                          TextField(
                                            controller: t,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    e.callType = t.text;

                                                    myType.addcallType(e);
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("تم")),
                                              ElevatedButton(
                                                  style: const ButtonStyle(
                                                      backgroundColor:
                                                          WidgetStatePropertyAll(
                                                              Colors.red)),
                                                  onPressed: () {
                                                    e.actions.add(ProdcutsAction
                                                        .archive.add);

                                                    myType.addcallType(e);
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("حذف")),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ));
                        },
                        child: Text(
                          e.callType,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )))
                    .toList(),
              )
            ],
          ),
        );
      },
    );
  }
}

class reqreasonss extends StatelessWidget {
  const reqreasonss({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HiveDB>(
      builder: (context, myType, child) {
        return SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    TextEditingController t = TextEditingController();
                    showDialog(
                        context: context,
                        builder: (c) => AlertDialog(
                              title: const Text('اضافة سبب طلب'),
                              content: SizedBox(
                                width: 100,
                                height: 170,
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: t,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              myType.addreqreason(ReqReasons(
                                                  id: DateTime.now()
                                                      .microsecondsSinceEpoch,
                                                  Reqreason: t.text,
                                                  actions: []));
                                              Navigator.pop(context);
                                            },
                                            child: const Text("تم")),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ));
                  },
                  child: const Text("Add New")),
              const Gap(22),
              Wrap(
                alignment: WrapAlignment.start,
                spacing: 9,
                children: myType.reqreasons.values
                    .map((e) => ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.amber)),
                        onPressed: () {
                          TextEditingController t = TextEditingController();
                          t.text = e.Reqreason;
                          showDialog(
                              context: context,
                              builder: (c) => AlertDialog(
                                    title: const Text('تعديل او حذف'),
                                    content: SizedBox(
                                      width: 100,
                                      height: 170,
                                      child: Column(
                                        children: [
                                          TextField(
                                            controller: t,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    e.Reqreason = t.text;

                                                    myType.addreqreason(e);
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("تم")),
                                              ElevatedButton(
                                                  style: const ButtonStyle(
                                                      backgroundColor:
                                                          WidgetStatePropertyAll(
                                                              Colors.red)),
                                                  onPressed: () {
                                                    e.actions.add(ProdcutsAction
                                                        .archive.add);

                                                    myType.addreqreason(e);
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("حذف")),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ));
                        },
                        child: Text(
                          e.Reqreason,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )))
                    .toList(),
              )
            ],
          ),
        );
      },
    );
  }
}
