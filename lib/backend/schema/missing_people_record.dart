import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MissingPeopleRecord extends FirestoreRecord {
  MissingPeopleRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "firstName" field.
  String? _firstName;
  String get firstName => _firstName ?? '';
  bool hasFirstName() => _firstName != null;

  // "familyName" field.
  String? _familyName;
  String get familyName => _familyName ?? '';
  bool hasFamilyName() => _familyName != null;

  // "birthDate" field.
  DateTime? _birthDate;
  DateTime? get birthDate => _birthDate;
  bool hasBirthDate() => _birthDate != null;

  // "state" field.
  String? _state;
  String get state => _state ?? '';
  bool hasState() => _state != null;

  // "nationalID" field.
  String? _nationalID;
  String get nationalID => _nationalID ?? '';
  bool hasNationalID() => _nationalID != null;

  // "IdNumber" field.
  String? _idNumber;
  String get idNumber => _idNumber ?? '';
  bool hasIdNumber() => _idNumber != null;

  // "photoUrl" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "personId" field.
  String? _personId;
  String get personId => _personId ?? '';
  bool hasPersonId() => _personId != null;

  // "fatherName" field.
  String? _fatherName;
  String get fatherName => _fatherName ?? '';
  bool hasFatherName() => _fatherName != null;

  // "grandfatherName" field.
  String? _grandfatherName;
  String get grandfatherName => _grandfatherName ?? '';
  bool hasGrandfatherName() => _grandfatherName != null;

  void _initializeFields() {
    _firstName = snapshotData['firstName'] as String?;
    _familyName = snapshotData['familyName'] as String?;
    _birthDate = snapshotData['birthDate'] as DateTime?;
    _state = snapshotData['state'] as String?;
    _nationalID = snapshotData['nationalID'] as String?;
    _idNumber = snapshotData['IdNumber'] as String?;
    _photoUrl = snapshotData['photoUrl'] as String?;
    _personId = snapshotData['personId'] as String?;
    _fatherName = snapshotData['fatherName'] as String?;
    _grandfatherName = snapshotData['grandfatherName'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('missingPeople');

  static Stream<MissingPeopleRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MissingPeopleRecord.fromSnapshot(s));

  static Future<MissingPeopleRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => MissingPeopleRecord.fromSnapshot(s));

  static MissingPeopleRecord fromSnapshot(DocumentSnapshot snapshot) =>
      MissingPeopleRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MissingPeopleRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MissingPeopleRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MissingPeopleRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MissingPeopleRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMissingPeopleRecordData({
  String? firstName,
  String? familyName,
  DateTime? birthDate,
  String? state,
  String? nationalID,
  String? idNumber,
  String? photoUrl,
  String? personId,
  String? fatherName,
  String? grandfatherName,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'firstName': firstName,
      'familyName': familyName,
      'birthDate': birthDate,
      'state': state,
      'nationalID': nationalID,
      'IdNumber': idNumber,
      'photoUrl': photoUrl,
      'personId': personId,
      'fatherName': fatherName,
      'grandfatherName': grandfatherName,
    }.withoutNulls,
  );

  return firestoreData;
}

class MissingPeopleRecordDocumentEquality
    implements Equality<MissingPeopleRecord> {
  const MissingPeopleRecordDocumentEquality();

  @override
  bool equals(MissingPeopleRecord? e1, MissingPeopleRecord? e2) {
    return e1?.firstName == e2?.firstName &&
        e1?.familyName == e2?.familyName &&
        e1?.birthDate == e2?.birthDate &&
        e1?.state == e2?.state &&
        e1?.nationalID == e2?.nationalID &&
        e1?.idNumber == e2?.idNumber &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.personId == e2?.personId &&
        e1?.fatherName == e2?.fatherName &&
        e1?.grandfatherName == e2?.grandfatherName;
  }

  @override
  int hash(MissingPeopleRecord? e) => const ListEquality().hash([
        e?.firstName,
        e?.familyName,
        e?.birthDate,
        e?.state,
        e?.nationalID,
        e?.idNumber,
        e?.photoUrl,
        e?.personId,
        e?.fatherName,
        e?.grandfatherName
      ]);

  @override
  bool isValidKey(Object? o) => o is MissingPeopleRecord;
}
