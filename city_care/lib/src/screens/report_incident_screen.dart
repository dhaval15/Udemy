import 'dart:io';

import 'package:city_care/src/view_models/report_incident_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class ReportIncidentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ReportIncidentViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Report Incident'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: buildForm(vm),
      ),
    );
  }

  Widget buildForm(ReportIncidentViewModel vm) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Builder(builder: buildImage),
        SizedBox(height: 12),
        TextField(
          onChanged: (text) {
            vm.title = text;
          },
          decoration: InputDecoration(
            labelText: 'Title',
            hintText: 'Title',
          ),
        ),
        SizedBox(height: 12),
        TextField(
          onChanged: (text) {
            vm.title = text;
          },
          decoration: InputDecoration(
            labelText: 'Description',
            hintText: 'Description',
          ),
        ),
        RaisedButton(
          color: Colors.blue,
          child: Text('Report'),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget buildImage(context) {
    final vm = Provider.of<ReportIncidentViewModel>(context);
    return GestureDetector(
      onTap: () => _onTap(context, vm),
      child: Container(
        width: 300,
        height: 180,
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        child: vm.imagePath == null
            ? Center(
                child: Icon(
                  Icons.camera,
                  size: 72,
                ),
              )
            : Image.file(
                File(vm.imagePath),
                fit: BoxFit.cover,
              ),
      ),
    );
  }

  void _onTap(BuildContext context, ReportIncidentViewModel vm) {
    showModalBottomSheet(
        context: context,
        builder: (context) => BottomSheet(
              builder: (BuildContext context) => Column(
                children: [
                  ListTile(
                    title: Text('Gallery'),
                    onTap: () => _openGallery(context, vm),
                  ),
                  ListTile(
                    title: Text('Camera'),
                    onTap: () => _openCamera(context, vm),
                  ),
                ],
              ),
              onClosing: () {},
            ));
  }

  _openCamera(BuildContext context, ReportIncidentViewModel vm) async {
    Navigator.of(context).pop();
    final file = await ImagePicker().getImage(source: ImageSource.camera);
    if (file != null) vm.imagePath = file.path;
  }

  _openGallery(BuildContext context, ReportIncidentViewModel vm) async {
    Navigator.of(context).pop();
    final file = await ImagePicker().getImage(source: ImageSource.gallery);
    if (file != null) vm.imagePath = file.path;
  }
}
