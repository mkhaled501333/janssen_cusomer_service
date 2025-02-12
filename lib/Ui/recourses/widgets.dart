import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:janssen_cusomer_service/data/networkDB.dart';

class ServerStutus extends StatelessWidget {
  const ServerStutus({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: isServerOnline(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return Row(
          children: [
            const Text(
              "server stutues :",
              style: TextStyle(fontSize: 13, color: Colors.black),
            ),
            const Gap(5),
            Container(
              height: 15,
              width: 15,
              decoration: BoxDecoration(
                color: snapshot.data == null
                    ? Colors.red
                    : snapshot.data!
                        ? const Color.fromARGB(255, 111, 255, 116)
                        : Colors.red,
                shape: BoxShape.circle,
              ),
            ),
            const Gap(5),
            Text(
              snapshot.data == null
                  ? 'offline'
                  : snapshot.data!
                      ? 'online'
                      : "offline",
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
          ],
        );
      },
    );
  }
}

bool isserveronline = false;
Stream<bool> isServerOnline() async* {
  while (true) {
    await Future.delayed(const Duration(seconds: 1));
    Uri uri = Uri.http(
      '$ip:8080',
    );
    try {
      var response = await http.get(uri).timeout(const Duration(seconds: 2));
      yield response.statusCode == 200;
      isserveronline = response.statusCode == 200;
      print("server is online");
    } catch (e) {
      print("server is ofline");

      yield false;
      isserveronline = false;
    }
  }
}

Future<bool> isServerOnline2() async {
  bool v = false;
  Uri uri = Uri.http(
    '$ip:8080',
  );
  try {
    var response = await http.get(uri);
    response.statusCode == 200 ? v = true : v = false;
  } catch (e) {}
  return v;
}
