import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:email_validator/email_validator.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _fomkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Validation'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _fomkey,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Enter Name',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Name';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        helperText: 'Ex: abc@example.com',
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: 'Enter Email Id'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Email Id';
                      } else if (!EmailValidator.validate(value)) {
                        return 'Enter Valid Email';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        helperText: '798 265 8035',
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: mask.hint),
                    inputFormatters: [mask.formatter],
                    controller: mask.textController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Phone';
                      }
                      return null;
                    },
                  ),
                ),
                RaisedButton(
                  onPressed: check,
                  child: Text('Submit'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  var mask = _ExampleMask(
      formatter: MaskTextInputFormatter(mask: "### ### ####"),
      hint: "Enter Mobile Number");
  //Validate
  check() {
    if (_fomkey.currentState.validate()) {
      Fluttertoast.showToast(msg: 'Processing', toastLength: Toast.LENGTH_LONG);
    }
  }
}

class _ExampleMask {
  final TextEditingController textController = TextEditingController();
  final MaskTextInputFormatter formatter;
  final String hint;
  _ExampleMask({@required this.formatter, @required this.hint});
}
