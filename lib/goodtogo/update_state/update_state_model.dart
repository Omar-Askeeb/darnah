import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UpdateStateModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // State field(s) for nameField widget.
  TextEditingController? nameFieldController;
  String? Function(BuildContext, String?)? nameFieldControllerValidator;
  // State field(s) for fatherfield widget.
  TextEditingController? fatherfieldController;
  String? Function(BuildContext, String?)? fatherfieldControllerValidator;
  // State field(s) for grandfatherField widget.
  TextEditingController? grandfatherFieldController;
  String? Function(BuildContext, String?)? grandfatherFieldControllerValidator;
  // State field(s) for familyField widget.
  TextEditingController? familyFieldController;
  String? Function(BuildContext, String?)? familyFieldControllerValidator;
  // State field(s) for State widget.
  String? stateValue;
  FormFieldController<String>? stateValueController;
  // State field(s) for NationalIdField widget.
  TextEditingController? nationalIdFieldController;
  String? Function(BuildContext, String?)? nationalIdFieldControllerValidator;
  // State field(s) for IdNumberField widget.
  TextEditingController? idNumberFieldController;
  String? Function(BuildContext, String?)? idNumberFieldControllerValidator;
  // State field(s) for IDFeild widget.
  TextEditingController? iDFeildController;
  String? Function(BuildContext, String?)? iDFeildControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    nameFieldController?.dispose();
    fatherfieldController?.dispose();
    grandfatherFieldController?.dispose();
    familyFieldController?.dispose();
    nationalIdFieldController?.dispose();
    idNumberFieldController?.dispose();
    iDFeildController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
