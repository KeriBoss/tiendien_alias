import 'dart:convert';

import 'package:tiendien_alias/models/user.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UserNameWidget extends StatelessWidget {
  final id;

  UserNameWidget(this.id) {
    getUrl = FirebaseDatabase.instance
        .ref()
        .child("user")
        .child(id)
        .child("name")
        .once();
  }

  late Future<DatabaseEvent> getUrl;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DatabaseEvent>(
        future: getUrl,
        builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (snapshot.data == null) {
            return Text("");
          }
          return Text(
            snapshot.data!.snapshot.value.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          );
        });
  }
}
