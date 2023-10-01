import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';

class AddReportView extends StatefulWidget {
  const AddReportView({Key? key}) : super(key: key);

  Widget build(context, AddReportController controller) {
    controller.view = this;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.grey,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            "Add New Report",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text(
              "Report Details",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 20,
            ),
            QTextField(
              label: "Report Name",
              validator: Validator.required,
              hint: "Type report name",
              onChanged: (value) {
                controller.reportName = (value);
              },
            ),
            SizedBox(
              height: 15,
            ),
            QTextField(
              label: "Refering Name",
              validator: Validator.required,
              hint: "Type Refering name",
              onChanged: (value) {
                controller.name = (value);
              },
            ),
            SizedBox(
              height: 15,
            ),
            QTextField(
              label: "University",
              validator: Validator.required,
              hint: "Select University",
              onChanged: (value) {
                controller.university = (value);
              },
            ),
            SizedBox(
              height: 15,
            ),
            QTextField(
              label: "Major",
              validator: Validator.required,
              hint: "Type major name",
              onChanged: (value) {
                controller.major = (value);
              },
            ),
            SizedBox(
              height: 15,
            ),
            QTextField(
              label: "Year of Study",
              validator: Validator.required,
              hint: "Type year of study",
              onChanged: (value) {
                controller.year = (value);
              },
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              maxLines: 3,
              validator: Validator.required,
              decoration: InputDecoration(
                hintText: "Type description",
                labelText: "Description",
                labelStyle: TextStyle(color: Color(0xFF9B51E0)),
                isDense: true,
                alignLabelWithHint: true,
              ),
              onChanged: (value) {
                controller.description = (value);
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Upload Attachment",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 15,
            ),
            QImagePicker(
              label: "Photo",
              validator: Validator.required,
              value: null,
              onChanged: (value) {
                controller.photo = (value);
              },
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF9B51E0),
                ),
                onPressed: () => controller.DoAddReport(),
                child: const Text("Request Report"),
              ),
            ),
          ],
        ));
  }

  @override
  State<AddReportView> createState() => AddReportController();
}
