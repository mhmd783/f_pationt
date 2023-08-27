import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import '../provider/prov.dart';

class signup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _signup();
  }
}

class _signup extends State<signup> {
  String date = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<control>(builder: (context, val, child) {
          return Container(
              margin: EdgeInsets.only(top: 60, left: 20, right: 20),
              child: Form(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Image.asset(
                        "images/logo.png",
                        height: 200,
                        width: 200,
                      ),
                      Text("Doctor Signup", style: TextStyle(fontSize: 30)),
                      ////

                      ///
                      TextFormField(
                        controller: val.name,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          label: Text("اسمك"),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: val.phone,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          label: Text("رقم تلفونك"),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'\d')),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: val.pass,
                        obscureText: true,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          label: Text("كلمه السري"),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          label: Text("تكرار كلمه السري"),
                        ),
                        controller: val.pass1,
                        obscureText: true,
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(
                        width: 12,
                        height: 20,
                      ),
                      TextFormField(
                        controller: val.age,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          label: Text("عمرك"),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'\d')),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: CircleAvatar(
                            radius: 25,
                            backgroundColor: val.gender == 1
                                ? const Color.fromARGB(255, 243, 243, 58)
                                : Colors.white,
                            child: IconButton(
                              icon: Icon(
                                Icons.male,
                                size: 30,
                              ),
                              onPressed: () {
                                val.chosegender('male');
                              },
                            ),
                          )),
                          Expanded(
                              child: CircleAvatar(
                            radius: 25,
                            backgroundColor: val.gender == 2
                                ? const Color.fromARGB(255, 243, 243, 58)
                                : Colors.white,
                            child: IconButton(
                              icon: Icon(
                                Icons.female,
                                size: 30,
                              ),
                              onPressed: () {
                                val.chosegender('fmale');
                              },
                            ),
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        onPressed: () async {
                          if (val.name.text != '' &&
                              val.phone.text.length > 10 &&
                              val.age.text != '' &&
                              val.pass.text == val.pass1.text &&
                              val.gender != '') {
                            val.registernew();

                            _check();
                          } else {
                            _message();
                          }
                        },
                        child: Text(
                          "تسجيل",
                          style: TextStyle(fontSize: 17),
                        ),
                        color: Colors.white30,
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed("signin");
                          },
                          child: Text(
                            "تسجيل الدخول...",
                            style: TextStyle(fontSize: 17),
                          )),
                    ],
                  ),
                ),
              ));
        }),
      ),
    );
  }

  addDateOfBirth() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    ).then((value) {
      if (value != null) {
        date = value.toString();
        date = Jiffy.parse('${date}').yMd;
      }
    });
  }

  Future<void> _check() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('تحقق'),
          elevation: 10,
          content: Form(
            child: Consumer<control>(builder: (context, val, child) {
              return Center(
                child: val.datarigester == null
                    ? Center(child: CircularProgressIndicator())
                    : val.datarigester[0]['mes'] == 'not'
                        ? Center(child: Text('هذا الرقم مسجل'))
                        : Center(child: Text('تم تسجيل الحساب بنجاح!')),
              );
            }),
          ),
          actions: <Widget>[
            Consumer<control>(builder: (context, val, child) {
              return val.datarigester != null &&
                      val.datarigester[0]['mes'] != 'not'
                  ? Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(50)),
                      child: MaterialButton(
                        child: Text("تسجل الدخول"),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pushReplacementNamed("signin");
                        },
                      ),
                    )
                  : Container();
            }),
          ],
        );
      },
    );
  }

  Future<void> _message() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: Icon(
            Icons.error,
            color: Colors.redAccent,
          ),
          elevation: 10,
          content: Form(
            child: Center(child: Text('هناك خطاء في البيانات !!!')),
          ),
        );
      },
    );
  }
}
