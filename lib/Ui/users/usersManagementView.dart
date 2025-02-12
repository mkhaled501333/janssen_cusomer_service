import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:janssen_cusomer_service/Ui/recourses/sharedWidgets/textformfield.dart';

import 'package:janssen_cusomer_service/Ui/users/data/local.dart';
import 'package:janssen_cusomer_service/models/user.dart';
import 'package:provider/provider.dart';

class UsersManagement extends StatelessWidget {
  const UsersManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 74, 81, 92),
      ),
      backgroundColor: backgrond,
      body: Consumer<AuthProvider>(
        builder: (context, myType, child) {
          return Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: cartHeader,
                      borderRadius: BorderRadius.circular(9)),
                  child: Column(
                    children: [
                      ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(buttonbackground)),
                          onPressed: () {
                            TextEditingController name =
                                TextEditingController();
                            TextEditingController username =
                                TextEditingController();
                            TextEditingController pass =
                                TextEditingController();
                            showDialog(
                                context: context,
                                builder: (c) => AlertDialog(
                                      content: SizedBox(
                                        height: 200,
                                        child: Column(
                                          children: [
                                            CustomTextFormField(
                                                hint: "الاسم",
                                                width: 200,
                                                controller: name),
                                            CustomTextFormField(
                                                hint: "username",
                                                width: 200,
                                                controller: username),
                                            CustomTextFormField(
                                                hint: "password",
                                                width: 200,
                                                controller: pass),
                                            const Gap(20),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                ElevatedButton(
                                                    style: const ButtonStyle(
                                                        backgroundColor:
                                                            WidgetStatePropertyAll(
                                                                Colors.green)),
                                                    onPressed: () {
                                                      if (name.text
                                                              .isNotEmpty &&
                                                          username.text
                                                              .isNotEmpty &&
                                                          pass.text
                                                              .isNotEmpty) {
                                                        myType.postUser(UserModel(
                                                            user_Id: DateTime
                                                                    .now()
                                                                .millisecond,
                                                            name: name.text,
                                                            email:
                                                                username.text,
                                                            password: pass.text,
                                                            uid: "",
                                                            permitions: [],
                                                            updatedat: 0,
                                                            actions: []));
                                                        Navigator.pop(context);
                                                      }
                                                    },
                                                    child: const Text("تم")),
                                                ElevatedButton(
                                                    style: const ButtonStyle(
                                                        backgroundColor:
                                                            WidgetStatePropertyAll(
                                                                Colors.red)),
                                                    onPressed: () {},
                                                    child: const Text("الغاء")),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ));
                          },
                          child: const Text(
                            "Add new",
                            style: TextStyle(color: textTittle),
                          )),
                      Container(
                        height: 2,
                        color: Colors.white24,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * .8,
                  decoration: BoxDecoration(
                      color: cartbody, borderRadius: BorderRadius.circular(9)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Right(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Right extends StatelessWidget {
  const Right({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final controller = context.read<AuthProvider>().getAllUsers();

    return SizedBox(
      child: FutureBuilder(
        future: controller,
        builder:
            (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
          return Visibility(
            visible: snapshot.data != null,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: snapshot.data == null
                    ? []
                    : snapshot.data!
                        .where((e) => e.name != "admin")
                        .map((e) => item(e, () {
                              context.read<AuthProvider>().deleteUser(e);
                            }))
                        .toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  Padding item(UserModel user, Function()? onLongPress) {
    return Padding(
      padding: const EdgeInsets.only(top: 9),
      child: InkWell(
          onLongPress: onLongPress,
          child: Container(
            decoration: BoxDecoration(
                color: notificationBackgroundbackground,
                borderRadius: BorderRadius.circular(11)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    user.name,
                    style: const TextStyle(
                        color: notificationText,
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    " username  :  ${user.email}",
                    style: const TextStyle(
                        color: notificationText,
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "  password  :  ${user.password}",
                    style: const TextStyle(
                        color: notificationText,
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

const backgrond = Color.fromARGB(255, 3, 21, 37);
const cartHeader = Color.fromARGB(255, 22, 44, 70);
const cartbody = Color.fromARGB(255, 33, 65, 99);
const textTittle = Color.fromARGB(255, 124, 172, 248);
const text = Color.fromARGB(255, 120, 138, 162);
const text2 = Color.fromARGB(255, 61, 77, 94);
const text3 = Color.fromARGB(255, 216, 90, 143);
const buttonbackground = Color.fromARGB(255, 8, 66, 160);
const notificationBackgroundbackground = Color.fromARGB(255, 23, 33, 34);
const notificationText = Color.fromARGB(255, 248, 170, 3);
