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
import 'update_state_model.dart';
export 'update_state_model.dart';

class UpdateStateWidget extends StatefulWidget {
  const UpdateStateWidget({
    Key? key,
    required this.personID,
  }) : super(key: key);

  final String? personID;

  @override
  _UpdateStateWidgetState createState() => _UpdateStateWidgetState();
}

class _UpdateStateWidgetState extends State<UpdateStateWidget> {
  late UpdateStateModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UpdateStateModel());

    _model.iDFeildController ??= TextEditingController(text: widget.personID);
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.chevron_left,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          actions: [],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: AlignmentDirectional(0.00, 0.00),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
                    child: StreamBuilder<List<MissingPeopleRecord>>(
                      stream: queryMissingPeopleRecord(
                        queryBuilder: (missingPeopleRecord) =>
                            missingPeopleRecord.where('personId',
                                isEqualTo: widget.personID),
                        singleRecord: true,
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  FlutterFlowTheme.of(context).primary,
                                ),
                              ),
                            ),
                          );
                        }
                        List<MissingPeopleRecord> dataMissingPeopleRecordList =
                            snapshot.data!;
                        // Return an empty Container when the item does not exist.
                        if (snapshot.data!.isEmpty) {
                          return Container();
                        }
                        final dataMissingPeopleRecord =
                            dataMissingPeopleRecordList.isNotEmpty
                                ? dataMissingPeopleRecordList.first
                                : null;
                        return Container(
                          width: MediaQuery.sizeOf(context).width * 0.95,
                          height: 750.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                10.0, 10.0, 10.0, 10.0),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Align(
                                    alignment:
                                        AlignmentDirectional(-1.00, 0.00),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 10.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          'qdhv5f7z' /* Person Data */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .headlineMedium,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      final selectedMedia =
                                          await selectMediaWithSourceBottomSheet(
                                        context: context,
                                        allowPhoto: true,
                                      );
                                      if (selectedMedia != null &&
                                          selectedMedia.every((m) =>
                                              validateFileFormat(
                                                  m.storagePath, context))) {
                                        setState(() =>
                                            _model.isDataUploading = true);
                                        var selectedUploadedFiles =
                                            <FFUploadedFile>[];

                                        var downloadUrls = <String>[];
                                        try {
                                          selectedUploadedFiles = selectedMedia
                                              .map((m) => FFUploadedFile(
                                                    name: m.storagePath
                                                        .split('/')
                                                        .last,
                                                    bytes: m.bytes,
                                                    height:
                                                        m.dimensions?.height,
                                                    width: m.dimensions?.width,
                                                    blurHash: m.blurHash,
                                                  ))
                                              .toList();

                                          downloadUrls = (await Future.wait(
                                            selectedMedia.map(
                                              (m) async => await uploadData(
                                                  m.storagePath, m.bytes),
                                            ),
                                          ))
                                              .where((u) => u != null)
                                              .map((u) => u!)
                                              .toList();
                                        } finally {
                                          _model.isDataUploading = false;
                                        }
                                        if (selectedUploadedFiles.length ==
                                                selectedMedia.length &&
                                            downloadUrls.length ==
                                                selectedMedia.length) {
                                          setState(() {
                                            _model.uploadedLocalFile =
                                                selectedUploadedFiles.first;
                                            _model.uploadedFileUrl =
                                                downloadUrls.first;
                                          });
                                        } else {
                                          setState(() {});
                                          return;
                                        }
                                      }
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        valueOrDefault<String>(
                                          dataMissingPeopleRecord?.photoUrl,
                                          'https://firebasestorage.googleapis.com/v0/b/clone-1b5b4.appspot.com/o/darnah.png?alt=media&token=3c22169a-bec1-4c37-aa20-e8bda49bccca',
                                        ),
                                        width: 200.0,
                                        height: 200.0,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Form(
                                    key: _model.formKey,
                                    autovalidateMode: AutovalidateMode.always,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    8.0, 5.0, 8.0, 5.0),
                                            child: TextFormField(
                                              controller:
                                                  _model.nameFieldController ??=
                                                      TextEditingController(
                                                text: dataMissingPeopleRecord
                                                    ?.firstName,
                                              ),
                                              autofocus: true,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelText:
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                  'sy7d00pj' /* First Name */,
                                                ),
                                                labelStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium,
                                                hintStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium,
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .alternate,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                errorBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                focusedErrorBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium,
                                              validator: _model
                                                  .nameFieldControllerValidator
                                                  .asValidator(context),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    8.0, 0.0, 8.0, 0.0),
                                            child: TextFormField(
                                              controller: _model
                                                      .fatherfieldController ??=
                                                  TextEditingController(
                                                text: dataMissingPeopleRecord
                                                    ?.fatherName,
                                              ),
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelText:
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                  '5v274jsr' /* father Name */,
                                                ),
                                                labelStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium,
                                                hintStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium,
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .alternate,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                errorBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                focusedErrorBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium,
                                              validator: _model
                                                  .fatherfieldControllerValidator
                                                  .asValidator(context),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    8.0, 0.0, 8.0, 0.0),
                                            child: TextFormField(
                                              controller: _model
                                                      .grandfatherFieldController ??=
                                                  TextEditingController(
                                                text: dataMissingPeopleRecord
                                                    ?.grandfatherName,
                                              ),
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelText:
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                  'vsy1mly3' /* grandfather name */,
                                                ),
                                                labelStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium,
                                                hintStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium,
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .alternate,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                errorBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                focusedErrorBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium,
                                              validator: _model
                                                  .grandfatherFieldControllerValidator
                                                  .asValidator(context),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    8.0, 5.0, 8.0, 5.0),
                                            child: TextFormField(
                                              controller: _model
                                                      .familyFieldController ??=
                                                  TextEditingController(
                                                text: dataMissingPeopleRecord
                                                    ?.familyName,
                                              ),
                                              autofocus: true,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelText:
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                  '7r4edi95' /* SurName */,
                                                ),
                                                labelStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium,
                                                hintStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium,
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .alternate,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                errorBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                focusedErrorBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium,
                                              validator: _model
                                                  .familyFieldControllerValidator
                                                  .asValidator(context),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 5.0, 0.0, 5.0),
                                            child: FlutterFlowDropDown<String>(
                                              controller: _model
                                                      .stateValueController ??=
                                                  FormFieldController<String>(
                                                _model.stateValue ??=
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                  'du3gwg2f' /* Missing */,
                                                ),
                                              ),
                                              options: [
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'uukrx2ag' /* Missing */,
                                                ),
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'mcvk9zzt' /* Found */,
                                                ),
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'izpoxhfo' /* Injuried */,
                                                ),
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'q4rzy6w7' /* Dead */,
                                                ),
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'bhwqheaz' /* لم يتعرف عليه */,
                                                )
                                              ],
                                              onChanged: (val) => setState(() =>
                                                  _model.stateValue = val),
                                              width: 300.0,
                                              height: 50.0,
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium,
                                              hintText:
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                'nb3gfsbh' /* state */,
                                              ),
                                              icon: Icon(
                                                Icons
                                                    .keyboard_arrow_down_rounded,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 24.0,
                                              ),
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              elevation: 2.0,
                                              borderColor:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                              borderWidth: 2.0,
                                              borderRadius: 8.0,
                                              margin: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      16.0, 4.0, 16.0, 4.0),
                                              hidesUnderline: true,
                                              isSearchable: false,
                                              isMultiSelect: false,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    8.0, 5.0, 8.0, 5.0),
                                            child: TextFormField(
                                              controller: _model
                                                      .nationalIdFieldController ??=
                                                  TextEditingController(
                                                text: dataMissingPeopleRecord
                                                    ?.nationalID,
                                              ),
                                              autofocus: true,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelText:
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                  '7n0glqau' /* National ID */,
                                                ),
                                                labelStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium,
                                                hintStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium,
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .alternate,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                errorBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                focusedErrorBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium,
                                              validator: _model
                                                  .nationalIdFieldControllerValidator
                                                  .asValidator(context),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    8.0, 5.0, 8.0, 5.0),
                                            child: TextFormField(
                                              controller: _model
                                                      .idNumberFieldController ??=
                                                  TextEditingController(
                                                text: dataMissingPeopleRecord
                                                    ?.idNumber,
                                              ),
                                              autofocus: true,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelText:
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                  'pzlvik5w' /* ID number */,
                                                ),
                                                labelStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium,
                                                hintStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium,
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .alternate,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                errorBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                focusedErrorBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium,
                                              validator: _model
                                                  .idNumberFieldControllerValidator
                                                  .asValidator(context),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    8.0, 5.0, 8.0, 5.0),
                                            child: TextFormField(
                                              controller:
                                                  _model.iDFeildController,
                                              readOnly: true,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelText:
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                  '6ulpaa6o' /* ID */,
                                                ),
                                                labelStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium,
                                                hintStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium,
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .alternate,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                errorBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                focusedErrorBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium,
                                              validator: _model
                                                  .iDFeildControllerValidator
                                                  .asValidator(context),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 10.0),
                                            child: FFButtonWidget(
                                              onPressed: () async {
                                                await dataMissingPeopleRecord!
                                                    .reference
                                                    .update(
                                                        createMissingPeopleRecordData(
                                                  state: _model.stateValue,
                                                  firstName: _model
                                                      .nameFieldController.text,
                                                  familyName: _model
                                                      .familyFieldController
                                                      .text,
                                                  nationalID: _model
                                                      .nationalIdFieldController
                                                      .text,
                                                  idNumber: _model
                                                      .idNumberFieldController
                                                      .text,
                                                  personId: '',
                                                  fatherName: _model
                                                      .fatherfieldController
                                                      .text,
                                                  grandfatherName: _model
                                                      .grandfatherFieldController
                                                      .text,
                                                ));

                                                context.pushNamed('allMissing');
                                              },
                                              text: FFLocalizations.of(context)
                                                  .getText(
                                                'kplvskjo' /* Save */,
                                              ),
                                              options: FFButtonOptions(
                                                width: 300.0,
                                                height: 40.0,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        24.0, 0.0, 24.0, 0.0),
                                                iconPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .override(
                                                          fontFamily: 'Cairo',
                                                          color: Colors.white,
                                                        ),
                                                elevation: 3.0,
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
