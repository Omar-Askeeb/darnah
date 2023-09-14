import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

String generateID() {
  // return a uniqe id
  var now = DateTime.now();
  var formatter = DateFormat('yyyyMMddHHmmss');
  String formattedDate = formatter.format(now);
  var random = math.Random().nextInt(10000);
  return 'Darna-$formattedDate$random';
}

String? notRecognizablePeople(List<MissingPeopleRecord>? docs) {
  docs = docs ?? [];
  int n = 0;
  docs.asMap().forEach((index, record) {
    if (record.state == 'لم يتعرف عليه') n++;
  });
  String count = n.toString();
  return count;
}

String? deadPeopleCopy(List<MissingPeopleRecord>? docs) {
  docs = docs ?? [];
  int n = 0;
  docs.asMap().forEach((index, record) {
    if (record.state == 'متوفى' || record.state == 'Dead') n++;
  });
  String count = n.toString();
  return count;
}

String? allPeople(List<MissingPeopleRecord>? docs) {
  docs = docs ?? [];
  int n = 0;
  docs.asMap().forEach((index, record) {
    n++;
  });
  String count = n.toString();
  return count;
}

String? missingPeople(List<MissingPeopleRecord>? docs) {
  docs = docs ?? [];
  int n = 0;
  docs.asMap().forEach((index, record) {
    if (record.state == 'Missing' || record.state == 'مفقود') n++;
  });
  String count = n.toString();
  return count;
}

String? foundPeople(List<MissingPeopleRecord>? docs) {
  docs = docs ?? [];
  int n = 0;
  docs.asMap().forEach((index, record) {
    if (record.state == 'Found' || record.state == 'تم ايجادة') n++;
  });
  String count = n.toString();
  return count;
}

String? injuredPeople(List<MissingPeopleRecord>? docs) {
  docs = docs ?? [];
  int n = 0;
  docs.asMap().forEach((index, record) {
    if (record.state == 'Injuried' || record.state == 'مصاب') n++;
  });
  String count = n.toString();
  return count;
}
