// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';
import 'package:janssen_cusomer_service/Ui/recourses/constants.dart';
import 'package:janssen_cusomer_service/Ui/screens/leftCard/LeftCard.dart';
import 'package:janssen_cusomer_service/Ui/screens/repotrs/R2/R2.dart';
import 'package:janssen_cusomer_service/Ui/screens/repotrs/R2/R2provider.dart';
import 'package:janssen_cusomer_service/Ui/screens/repotrs/R3.dart';
import 'package:janssen_cusomer_service/Ui/screens/config.dart';
import 'package:janssen_cusomer_service/Ui/screens/login.dart';
import 'package:janssen_cusomer_service/Ui/screens/repotrs/statistics/crm.dart';
import 'package:janssen_cusomer_service/Ui/screens/repotrs/statistics/crmProvider.dart';
import 'package:janssen_cusomer_service/Ui/screens/rightCard/rightCard.dart';
import 'package:janssen_cusomer_service/Ui/recourses/widgets.dart';
import 'package:janssen_cusomer_service/Ui/users/data/local.dart';
import 'package:janssen_cusomer_service/Ui/users/usersManagementView.dart';
import 'package:janssen_cusomer_service/data/localDB.dart';
import 'package:janssen_cusomer_service/models/callinfo.dart';
import 'package:janssen_cusomer_service/models/customer.dart';
import 'package:janssen_cusomer_service/models/governomates.dart';
import 'package:janssen_cusomer_service/models/models.dart';
import 'package:janssen_cusomer_service/models/prodcutinfo.dart';
import 'package:janssen_cusomer_service/models/request.dart';
import 'package:janssen_cusomer_service/models/ticket.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

var df = DateFormat('yyyy/MMMM/dd');
var YMDHM = DateFormat('hh:mm  yyyy/MMMM/dd');
late SharedPreferences sharedPrefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  Hive.registerAdapter(TicketModelAdapter());
  Hive.registerAdapter(CustomerModelAdapter());
  Hive.registerAdapter(ProductInfoAdapter());
  Hive.registerAdapter(CallInfoAdapter());
  Hive.registerAdapter(RequstesMolelAdapter());
  Hive.registerAdapter(ActionModelAdapter());
  Hive.registerAdapter(ProdcutsModelAdapter());
  Hive.registerAdapter(CallTypeModelAdapter());
  Hive.registerAdapter(ReqReasonsAdapter());
  Hive.registerAdapter(governomateAdapter());
  final path = Directory.current.path;

  final Directory appDocumentsDir = await getApplicationDocumentsDirectory();

  if (Platform.isAndroid) {
    print(appDocumentsDir.path);
    Hive.init(appDocumentsDir.path);
  } else {
    print(appDocumentsDir.path + "ddd");

    Hive.init('$path/data');
  }
  await Hive.openBox<CustomerModel>(
    "customers",
    compactionStrategy: (entries, deletedEntries) => false,
  );
  await Hive.openBox<CustomerModel>(
    "pendingCustomers",
    compactionStrategy: (entries, deletedEntries) => false,
  );
  await Hive.openBox<ProdcutsModel>(
    "prodcuts",
    compactionStrategy: (entries, deletedEntries) => false,
  );
  await Hive.openBox<ProdcutsModel>(
    "pendingprodcuts",
    compactionStrategy: (entries, deletedEntries) => false,
  );
  await Hive.openBox<CallTypeModel>(
    "callTypes",
    compactionStrategy: (entries, deletedEntries) => false,
  );
  await Hive.openBox<CallTypeModel>(
    "pendincallTypes",
    compactionStrategy: (entries, deletedEntries) => false,
  );
  await Hive.openBox<ReqReasons>(
    "reqreasons",
    compactionStrategy: (entries, deletedEntries) => false,
  );
  await Hive.openBox<ReqReasons>(
    "pendingreqreason",
    compactionStrategy: (entries, deletedEntries) => false,
  );
  await Hive.openBox<governomate>(
    "governomates",
    compactionStrategy: (entries, deletedEntries) => false,
  );
  await Hive.openBox<governomate>(
    "pendinggovernomates",
    compactionStrategy: (entries, deletedEntries) => false,
  );
  sharedPrefs = await SharedPreferences.getInstance();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider(sharedPrefs)),
          ChangeNotifierProvider(create: (context) => HiveDB()),
          ChangeNotifierProvider(create: (context) => CrmProvider()),
          ChangeNotifierProvider(create: (context) => R2Provider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: Consumer<AuthProvider>(
            builder: (context, myType, child) {
              username = myType.nameLoged ?? '';
              return myType.isLoggedIn ? HomePage() : LoginPage();
            },
          ),
        ));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // context.read<HiveDB>().addtttt(g);
    context.read<HiveDB>().SendPending_GetAll_ConnectAndListenchannels();
    
    
  context.read<HiveDB>().governamates.values.forEach((element) {
      g.addAll({element.governo:element.cityies});
    },);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 201, 207, 199),
      appBar: AppBar(
        title: Row(
          children: [
            ServerStutus(),
            Gap(111),
            Text(
              " loged as : $username",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 0, 152, 137),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      'assets/1.jpg',
                    )),
                color: Colors.green[200],
              ),
              child: SizedBox(),
            ),
            // ElevatedButton(
            //   style: ButtonStyle(
            //       backgroundColor: WidgetStatePropertyAll(Colors.green[100])),
            //   onPressed: () {
            //     Navigator.of(context)
            //         .push(MaterialPageRoute(builder: (context) => Reports()));
            //   },
            //   child: ListTile(
            //     title: Row(
            //       children: [
            //         Icon(Icons.report_gmailerrorred_rounded),
            //         Gap(11),
            //         const Text('تقرير 1'),
            //       ],
            //     ),
            //   ),
            // ),
            Gap(22),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.green[100])),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => R22()));
              },
              child: ListTile(
                title: Row(
                  children: [
                    Icon(Icons.report_gmailerrorred_rounded),
                    Gap(11),
                    const Text('تقرير 1'),
                  ],
                ),
              ),
            ),    Gap(22),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.green[100])),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => CrmView()));
              },
              child: ListTile(
                title: Row(
                  children: [
                    Icon(Icons.report_gmailerrorred_rounded),
                    Gap(11),
                    const Text('statistics'),
                  ],
                ),
              ),
            ),
            Gap(22),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.green[100])),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => R3()));
              },
              child: ListTile(
                title: Row(
                  children: [
                    Icon(Icons.report_gmailerrorred_rounded),
                    Gap(11),
                    const Text('تقرير المكالمات'),
                  ],
                ),
              ),
            ),
            Gap(22),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.green[100])),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Config()));
              },
              child: ListTile(
                title: Row(
                  children: [
                    Icon(Icons.report_gmailerrorred_rounded),
                    Gap(11),
                    const Text('config'),
                  ],
                ),
              ),
            ),
            Gap(22),
            Visibility(
              visible: username == "admin",
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.green[100])),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UsersManagement()));
                },
                child: ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.report_gmailerrorred_rounded),
                      Gap(11),
                      const Text('users'),
                    ],
                  ),
                ),
              ),
            ),
            Gap(22),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.green[100])),
              onPressed: () {
                context.read<AuthProvider>().logout();
              },
              child: ListTile(
                title: Row(
                  children: [
                    Icon(Icons.report_gmailerrorred_rounded),
                    Gap(11),
                    const Text('logout'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          LeftCard(),
          RightCard(),
        ],
      ),
    );
  }
}
