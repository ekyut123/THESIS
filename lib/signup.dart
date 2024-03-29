import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_users/data_source/read_DB.dart';
import 'package:flutter_firebase_users/navpages/termsandconditions_page.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'widgets/loading.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
GlobalKey<FormState> _formKey = GlobalKey<FormState>();
bool loading = false;

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  static String verification = "";
  static String phoneNo = "";

  @override
  // ignore: library_private_types_in_public_api
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  late String countryCode;
  late PhoneNumber phone;
  String? errorEmail;
  bool emailtaken = false;
  bool value = false;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    _fnameController.dispose();
    _lnameController.dispose();
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loading = false;
    _emailController.clear();
    _passwordController.clear();
    _confirmController.clear();
    _fnameController.clear();
    _lnameController.clear();
    _otpController.clear();
  }

  //adds user inputted data including user id(uid) to the database
  Future createUser(
      String fname, String lname, String phone, String email, User user) async {
    String role = "consumer";
    final docUser =
        FirebaseFirestore.instance.collection('Users').doc(user.uid);
    final json = {
      'id': user.uid,
      'first name': fname,
      'last name': lname,
      'phone number': phone,
      'email': email,
      'role': role,
    };
    await docUser.set(json);

    QuerySnapshot snap =
        await FirebaseFirestore.instance.collection('BusinessList').get();

    for (var document in snap.docs) {
      saveJson(
          user.uid,
          document["businessid"],
          document["business address"],
          document["businessDescription"],
          document["businessEmail"],
          document["businessImage"],
          document["businessName"],
          document["businessPhone"],
          document["businessType"],
          document["closing day"],
          document["closing hour"],
          document["opening day"],
          document["opening hour"],
          document["personalEmail"],
          document["personalPhone"],
          document["isSubbed"]);
    }
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
  }

  Future<void> saveJson(
    String uid,
    String businessId,
    String add,
    String desc,
    String bemail,
    String image,
    String name,
    String phone,
    String type,
    String cday,
    String chour,
    String oday,
    String ohour,
    String pemail,
    String pphone,
    bool isSubbed,
  ) async {
    int counter = 0;
    final docCounter = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Booked Counter')
        .doc(businessId);
    final json = {
      'isSubbed': isSubbed,
      'businessid': businessId,
      'counter': counter,
      'business address': add,
      'businessDescription': desc,
      'businessEmail': bemail,
      'businessImage': image,
      'businessName': name,
      'businessPhone': phone,
      'businessType': type,
      'closing day': cday,
      'closing hour': chour,
      'opening day': oday,
      'opening hour': ohour,
      'personalEmail': pemail,
      'personalPhone': pphone
    };
    await docCounter.set(json);
  }

  void _register(String phonecontroller, BuildContext context) async {
    try {
      final User? user = (await _auth.createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text))
          .user;
      if (user != null) {
        createUser(_fnameController.text, _lnameController.text,
            _phoneController.text, _emailController.text, user);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        setState(() {
          loading = false;
          emailtaken == true;
          errorEmail = 'Email is already taken';
        });
      }
    }
  }

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(6, errorText: 'password must be at least 6 digits long'),
  ]);

  final emailValidator = MultiValidator(
    [
      RequiredValidator(errorText: 'Email is required'),
      EmailValidator(errorText: 'Email is not valid')
    ],
  );

  Widget _signupbutton(bool value) {
    //changes the signup button depending on terms and condition checkbox
    if (value) {
      return SizedBox(
        height: 40,
        child: Material(
          borderRadius: BorderRadius.circular(20),
          shadowColor: Colors.greenAccent,
          color: Colors.deepOrange,
          elevation: 7,
          child: GestureDetector(
            onTap: () async {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  loading = true;
                });
                _register(_phoneController.text, context);
              }
            },
            child: const Center(
              child: Text(
                'Signup',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return SizedBox(
        height: 40,
        child: Material(
          borderRadius: BorderRadius.circular(20),
          shadowColor: Colors.black,
          color: Colors.grey,
          elevation: 7,
          child: GestureDetector(
            onTap: () async {
              //returns null when terms and conditions isnt checked
              null;
            },
            child: const Center(
              child: Text(
                'Signup',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  String password = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            body: Scrollbar(
            thumbVisibility: true,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.fromLTRB(15, 110, 0, 0),
                        child: const Text(
                          "Signup",
                          style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Form(
                      key: _formKey,
                      child: Container(
                          padding: const EdgeInsets.only(
                              top: 35, left: 20, right: 30),
                          child: Column(children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                    child: TextFormField(
                                  validator: RequiredValidator(errorText: ''),
                                  controller: _fnameController,
                                  decoration: const InputDecoration(
                                      labelText: 'First Name',
                                      labelStyle: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.green),
                                      )),
                                )),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                Flexible(
                                  child: TextFormField(
                                      validator:
                                          RequiredValidator(errorText: ''),
                                      controller: _lnameController,
                                      decoration: const InputDecoration(
                                          labelText: 'Last Name',
                                          labelStyle: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.green),
                                          ))),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            IntlPhoneField(
                              onChanged: (phone) {
                                _phoneController.text = phone.completeNumber;
                              },
                              showCountryFlag: false,
                              initialCountryCode: 'PH',
                              decoration: const InputDecoration(
                                  labelText: 'Phone Number',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green),
                                  )),
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  errorText: errorEmail,
                                  labelText: 'EMAIL',
                                  labelStyle: const TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green),
                                  )),
                              validator: emailValidator,
                              controller: _emailController,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              controller: _passwordController,
                              decoration: const InputDecoration(
                                  labelText: 'PASSWORD',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green),
                                  )),
                              obscureText: true,
                              onChanged: (val) => password = val,
                              validator: passwordValidator,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                                controller: _confirmController,
                                decoration: const InputDecoration(
                                    labelText: 'Confirm Password',
                                    labelStyle: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green),
                                    )),
                                obscureText: true,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return '';
                                  } else if (val != _passwordController.text) {
                                    return 'Password does not match';
                                  } else {
                                    return null;
                                  }
                                }),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: value,
                                    onChanged: (value) {
                                      setState(() {
                                        this.value = value!;
                                      });
                                    }),
                                SizedBox(
                                  width: size.width * 0.01,
                                ),
                                // Expanded(
                                //   child: GestureDetector(
                                //     onTap: () {
                                //       Navigator.push(
                                //           context,
                                //           MaterialPageRoute(
                                //               builder: (BuildContext context) =>
                                //                   TermsAndConditions()));
                                //     },
                                Expanded(
                                    child: RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text:
                                            "By checking this box, I affirm that I have read and accepted the ",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      TextSpan(
                                          text: "Terms and Conditions.",
                                          style: const TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              color: Colors.blue),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          TermsAndConditions()));
                                            }),
                                    ],
                                  ),
                                ))
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(120, 0, 120, 0),
                              child: Container(child: _signupbutton(value)),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Go Back',
                                    style: TextStyle(
                                        color: Colors.deepOrange,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                          ])))
                ],
              ),
            ),
          ));
  }
}
