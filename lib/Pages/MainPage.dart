// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:timer_app/Pages/CountdownPage.dart';
import 'package:timer_app/Services/ToastService.dart';
import 'package:timer_app/Utilities/AppColor.dart';
import 'package:timer_app/Utilities/Constants.dart';
import 'package:timer_app/Widgets/CustomDropdown.dart';
import 'package:timer_app/Widgets/CustomTextFormField.dart';
import 'package:timer_app/Widgets/custombutton.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _key = GlobalKey<FormState>();

  late TextEditingController _roundNamesController;
  late TextEditingController _roundSecondsController;
  late TextEditingController _restSecondsController;

  int? _secilenRoundNumber;

  @override
  void initState() {
    super.initState();

    _roundNamesController = TextEditingController();
    _roundSecondsController = TextEditingController();
    _restSecondsController = TextEditingController();

    _secilenRoundNumber = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _key,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomDropdown(
                fillColor: AppColor.darkPrimaryColor,
                dropdownMenuItemList: _buildDropdown(dropdownItems: roundList),
                onChanged: (value) {
                  _secilenRoundNumber = value as int;
                },
                value: _secilenRoundNumber,
                labelText: "Choose Round Number",
                errorText: "Zorunlu",
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: _roundNamesController,
                labelText: "Enter Round Names",
                hintText: "Pushups, Burpees, Pullups...",
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: _roundSecondsController,
                labelText: "Enter Round Seconds",
                hintText: "20, 10, 50...",
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: _restSecondsController,
                labelText: "Enter Rest Seconds",
                hintText: "20",
              ),
              const SizedBox(height: 50),
              CustomButton(
                buttonWidth: 200,
                labelText: "Start Workout",
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    if (_roundSecondsController.text.split(",").length ==
                        _secilenRoundNumber) {
                      if (_roundNamesController.text.split(",").length ==
                          _secilenRoundNumber) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CountdownPage(
                              roundNumber: _secilenRoundNumber!,
                              roundNames: _roundNamesController.text.split(","),
                              roundSeconds:
                                  _roundSecondsController.text.split(","),
                              restSeconds: _restSecondsController.text,
                            ),
                          ),
                        );
                      } else {
                        ToastService.instance.errorToast(
                          context,
                          "Wrong Input",
                          "Your chosen round number and count of round names do not meet. Please check your input.",
                          Alignment.bottomCenter,
                        );
                      }
                    } else {
                      ToastService.instance.errorToast(
                        context,
                        "Wrong Input",
                        "Your chosen round number and count of seconds do not meet. Please check your input.",
                        Alignment.bottomCenter,
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<dynamic>> _buildDropdown({
    required List<dynamic>? dropdownItems,
  }) {
    List<DropdownMenuItem<dynamic>> _items = [];
    if (dropdownItems != null) {
      for (dynamic dropdownItem in dropdownItems) {
        _items.add(
          DropdownMenuItem(
            child: SizedBox(
              width: double.infinity,
              child: Text(
                dropdownItem.toString(),
                overflow: TextOverflow.visible,
                style: const TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                  color: AppColor.white,
                ),
              ),
            ),
            value: dropdownItem,
          ),
        );
      }
    }

    return _items;
  }
}
