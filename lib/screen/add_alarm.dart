import 'dart:math';

import 'package:alarm_app_with_notification/provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AddAlarm extends StatefulWidget {
  const AddAlarm({super.key});

  @override
  State<AddAlarm> createState() => _AddAlaramState();
}

class _AddAlaramState extends State<AddAlarm> {
  late TextEditingController controller;

  String? dateTime;
  bool repeat = false;

  DateTime? notificationtime;

  String? name = "none";
  int? Milliseconds;

  @override
  void initState() {
    controller = TextEditingController();
    context.read<alarmprovider>().GetData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Add Alarm',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              "Set Time",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: CupertinoDatePicker(
                backgroundColor: Colors.transparent,
                showDayOfWeek: true,
                minimumDate: DateTime.now(),
                dateOrder: DatePickerDateOrder.dmy,
                onDateTimeChanged: (va) {
                  dateTime = DateFormat().add_jms().format(va);

                  Milliseconds = va.microsecondsSinceEpoch;

                  notificationtime = va;

                  print(dateTime);
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Label",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            CupertinoTextField(
              placeholder: "Add Label",
              placeholderStyle: TextStyle(
                color: Colors.grey[400],
                fontSize: 16,
              ),
              controller: controller,
              padding: EdgeInsets.all(16.0),
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Repeat Daily",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                CupertinoSwitch(
                  value: repeat,
                  activeColor: Colors.black,
                  onChanged: (bool value) {
                    repeat = value;

                    if (repeat == false) {
                      name = "none";
                    } else {
                      name = "Everyday";
                    }

                    setState(() {});
                  },
                ),
              ],
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Random random = new Random();
                  int randomNumber = random.nextInt(100);

                  context.read<alarmprovider>().SetAlaram(controller.text,
                      dateTime!, true, name!, randomNumber, Milliseconds!);
                  context.read<alarmprovider>().SetData();

                  context
                      .read<alarmprovider>()
                      .SecduleNotification(notificationtime!, randomNumber);

                  Navigator.pop(context);
                },
                child: Text(
                  "Set Alarm",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
