import 'package:flutter/material.dart';
import 'package:flutter_firebase_users/admin/logoutAdmin.dart';

import 'package:form_field_validator/form_field_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

GlobalKey<FormState> _formKey3 = GlobalKey<FormState>();
bool haslogged = false;
bool loading = false;

class ChangePass extends StatefulWidget {
  const ChangePass({super.key});

  @override
  State<ChangePass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  String? errorAcc;
  Future<void> _signOut() async {
    print("here");
    FirebaseAuth.instance.signOut();
  }

  Future<void> _changePassword(String oldpass, String newpass) async {
    //Create an instance of the current user.
    User? user = FirebaseAuth.instance.currentUser;
    final cred =
        EmailAuthProvider.credential(email: user!.email!, password: oldpass);
    final docUser =
        FirebaseFirestore.instance.collection('Users').doc(user.uid);
    try {
      await user.reauthenticateWithCredential(cred);
      setState(() {
        loading = true;
      });
      try {
        await user.updatePassword(newpass);
        await docUser.update({'has logged': '1'});
        setState(() {
          haslogged = true;
          loading = false;
        });
      } on Exception catch (e) {
        setState(() {
          loading = false;
        });
        print(e);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("An Error Has Occured")));
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "wrong-password":
          {
            setState(() {
              loading = false;
              errorAcc = "Password is incorrect";
            });
            break;
          }
      }
    }

    // user.reauthenticateWithCredential(cred).then((value) {
    //   // user.updatePassword(newpass).then((_) async {
    //   //   print("Successfully changed password");
    //   //   await docUser.update({'has logged': '1'});
    //   //   setState(() {
    //   //     haslogged = true;
    //   //   });
    //   // }).catchError((error) {
    //   //   //Error, show something
    //   //   print("Password can't be changed" + error.toString());
    //   // });
    // }).catchError((err) {
    //   setState(() {
    //     errorAcc = "Email or Password is incorrect";
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController newpassController = TextEditingController();
    TextEditingController confirmpassController = TextEditingController();
    TextEditingController oldpassController = TextEditingController();
    return Scaffold(
      body: haslogged
          ? const LogoutAfter()
          : loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Form(
                    key: _formKey3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.fromLTRB(15, 110, 0, 0),
                              child: const Text(
                                "In order to keep your account secure, you are required to change your password",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              top: 35, left: 20, right: 30),
                          child: Column(children: <Widget>[
                            TextFormField(
                              obscureText: true,
                              controller: oldpassController,
                              validator: RequiredValidator(
                                  errorText: "Old Password Required"),
                              decoration: InputDecoration(
                                  errorText: errorAcc,
                                  hintStyle: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                  labelText: "Old Password",
                                  labelStyle: const TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green),
                                  )),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              obscureText: true,
                              controller: newpassController,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: "New Password Required"),
                                MinLengthValidator(6,
                                    errorText:
                                        'password must be at least 6 digits long'),
                              ]),
                              decoration: const InputDecoration(
                                  hintStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                  labelText: "New Password",
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green),
                                  )),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                                controller: confirmpassController,
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
                                  if (val != newpassController.text) {
                                    return 'Password does not match';
                                  } else {
                                    return null;
                                  }
                                }),
                            const SizedBox(
                              height: 5,
                            ),
                          ]),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Center(
                          child: SizedBox(
                            width: 200,
                            height: 40,
                            child: GestureDetector(
                              onTap: () async {
                                if (_formKey3.currentState!.validate()) {
                                  await _changePassword(oldpassController.text,
                                      newpassController.text);
                                  if (haslogged) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: const Text(
                                              'Please re-log to your account',
                                              style: TextStyle(
                                                  color: Colors.black)),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                _signOut();
                                                Navigator.of(context)
                                                    .pushNamedAndRemoveUntil(
                                                        '/main',
                                                        (Route<dynamic>
                                                                route) =>
                                                            false);
                                              },
                                              child: const Text(
                                                'Logout',
                                                style: TextStyle(
                                                    color: Colors.blue),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                }
                              },
                              child: Material(
                                borderRadius: BorderRadius.circular(20),
                                shadowColor: Colors.greenAccent,
                                color: Colors.black,
                                elevation: 7,
                                child: const MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: Center(
                                    child: Text(
                                      'Confirm',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Center(
                          child: Text(
                            "Please re-log after changing your password",
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
    );
  }
}
