import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'reminders.g.dart';

@HiveType(typeId: 0)
class Reminders extends HiveObject {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late DateTime date;
  @HiveField(3)
  late bool getNotified;
  @HiveField(4)
  late String category;
  @HiveField(5)
  late bool done;
}
