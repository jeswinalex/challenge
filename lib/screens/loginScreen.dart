import 'package:codingchallenge/models/userModels.dart';
import 'package:codingchallenge/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'albumScreen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List<Users>? users;
  List<Users>? emailValue;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool? isloading;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    isloading = true;
  }

  getemailValue(int index) {
    String e = users![index].email;
    print(e);
  }

  getData() async {
    users = await Services().getUser();
    if (users != null) {
      setState(() {
        //print("post: $post");
        isloading = true;
      });
    }
  }

//   emailData()async{
// emailValue =await users.
//   }
  TextEditingController emailValidator = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: height / 4,
                ),
                const Text(
                  'Hi ! Again ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Please use email id to Login ',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                    ),
                    child: Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: 1,
                              itemBuilder: ((context, index) {
                                return TextFormField(
                                  controller: emailValidator,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Your email id ',
                                  ),
                                  onTap: () {},
                                  validator: (value) {},
                                );
                              }))),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password ',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 60,
                  ),
                  child: Container(
                    width: width / 2,
                    height: height / 15,
                    child: ElevatedButton(
                      onPressed: (() {
                        final FormState? form = _formKey.currentState;
                        if (form!.validate()) {
                          Get.offAll(
                            () => AlbumPage(),
                          );
                        } else {
                          print('Error Textfield');
                        }
                      }),
                      child: Center(
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 23,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        shadowColor: Colors.black,
                        elevation: 30,
                      ),
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
