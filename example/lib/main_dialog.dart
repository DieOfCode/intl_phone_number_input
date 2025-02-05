import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(appBar: AppBar(title: Text('Demo')), body: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'NG';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                setState(() {
                });
              },
              onSubmit: () {
                print("");
              },
              onInputValidated: (bool value) {
                print(value);
              },
              selectorConfig: const SelectorConfig(
                selectorType: PhoneInputSelectorType.DROPDOWN,
                useBottomSheetSafeArea: false,
              ),
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.disabled,
              selectorTextStyle:
              const TextStyle(color: Colors.red),
              textFieldController: controller,
              textStyle: TextStyle(
                color: Colors.white,
              ),
              formatInput: true,
              keyboardType: TextInputType.phone,
              cursorColor: Colors.black,
              inputDecoration: InputDecoration(
                filled: true,
                hintText: '+79000000000',
                hintStyle: TextStyle(color: Colors.black),
                fillColor: Colors.green,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 24),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              onSaved: (PhoneNumber number) {
                print('On Saved: $number');
              },
              popUpTextColor: Colors.black,
            ),
            ElevatedButton(
              onPressed: () {
                formKey.currentState?.validate();
              },
              child: Text('Validate'),
            ),
            ElevatedButton(
              onPressed: () {
                getPhoneNumber('+15417543010');
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');

    String parsableNumber = await PhoneNumber.getParsableNumber(number);
    controller.text = parsableNumber;

    setState(() {
      initialCountry = number.isoCode ?? '';
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
