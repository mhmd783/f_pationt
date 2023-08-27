import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pationt/provider/prov.dart';
import 'package:provider/provider.dart';

class doctor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _doctor();
  }
}

class _doctor extends State<doctor> {
  showdetails() {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Not Fount Patient'),
        duration: Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Doctor',
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<control>(context, listen: false).getalldoctors();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<control>(context, listen: false).getnumbercomment();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Text(
                "التعليقات",
                textAlign: TextAlign.center,
              )),
              Expanded(
                  child: Text(
                'الملف الشخصي',
                textAlign: TextAlign.center,
              )),
              Expanded(
                  child: Text(
                'معلومات طبيه',
                textAlign: TextAlign.center,
              )),
              Expanded(
                  child: Text(
                'اسئله المرضي',
                textAlign: TextAlign.center,
              )),
              Expanded(
                  child: Text(
                'الدكاتره',
                textAlign: TextAlign.center,
              )),
            ],
          ),
          duration: Duration(seconds: 3),
        ),
      );
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'اختار الدكتور بضغطه عليه واحجز كشفك وممكن تبحث عن الدكتور بالتخصص والمدينه عشان تشوف احسن الدكاتره والاقرب ليك',
            textAlign: TextAlign.center,
          ),
          duration: Duration(seconds: 3),
        ),
      );
    });

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   showDialog<void>(
    //         context: context,
    //         builder: (BuildContext context) {
    //           return AlertDialog(
    //             scrollable: true,
    //             title: const Text("رساله"),
    //             elevation: 10,
    //             content: Container(
    //               margin: EdgeInsets.all(10),
    //               child: Text(
    //                 'اختار الدكتور بضغطه عليه وممكن تبحث عن الدكتور بالتخصص والمدينه عشان تشوف احسن الدكاتره والاقرب ليك',
    //                 style: TextStyle(
    //                     color: Colors.black, fontWeight: FontWeight.bold),
    //               ),
    //             ),
    //             actions: <Widget>[
    //               CircleAvatar(
    //                 backgroundColor: Colors.grey.shade300,
    //                 child:  IconButton(
    //                     icon: Icon(
    //                       Icons.arrow_back,
    //                       color: Colors.black,
    //                     ),
    //                     onPressed: () {

    //                       Navigator.of(context).pop();
    //                     },
    //                   ),
    //               ),
    //             ],
    //           );
    //         },
    //       );

    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              Expanded(
                  child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white,
                child: Consumer<control>(builder: (context, val, child) {
                  return Stack(
                    children: [
                      CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 10,
                          child: Text(
                            '${val.numbercomment[0]['mes']}',
                            style: TextStyle(color: Colors.white),
                          )),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("notification");
                          },
                          icon: Icon(
                            Icons.comment,
                            color: Colors.black,
                          )),
                    ],
                  );
                }),
              )),
              Expanded(
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("profile");
                      },
                      icon: Icon(
                        Icons.person_outlined,
                        color: Colors.black,
                      ))),
              Expanded(
                  child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("home");
                },
                icon: Icon(Icons.home_outlined, color: Colors.black),
              )),
              Expanded(
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("quistion");
                      },
                      icon: Icon(
                        Icons.question_mark_rounded,
                        color: Colors.black,
                      ))),
              Expanded(
                  child: CircleAvatar(
                      radius: 25,
                      backgroundColor: const Color.fromARGB(255, 243, 243, 58),
                      child: Consumer<control>(builder: (context, val, child) {
                        return IconButton(
                            onPressed: () {
                              val.doctors = [];
                              val.indexenddoctor = 1;
                              val.getalldoctors();
                              // Navigator.of(context)
                              //     .pushReplacementNamed("doctor");
                            },
                            icon: Icon(
                              Icons.medical_services_outlined,
                              color: Colors.black,
                            ));
                      }))),
            ],
          ),
        ),
        appBar: AppBar(
          actions: [
            Container(
                margin: EdgeInsets.only(top: 5),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("search");
                  },
                  child: Text(
                    "بحث عن دكتور",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                )),
            Container(
              margin: EdgeInsets.only(right: 10),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("search");
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  )),
            )
          ],
          title: Consumer<control>(builder: (context, val, child) {
            return Text(
              'دكاتره',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            );
          }),
          backgroundColor: const Color.fromARGB(255, 243, 243, 58),
        ),
        body: Consumer<control>(builder: (context, val, child) {
          return !val.doctors.isEmpty
              ? Container(
                  child: ListView.builder(
                      itemCount: val.doctors.length + 1,
                      itemBuilder: (constant, i) {
                        if (i < val.doctors.length) {
                          if (val.indexenddoctor > val.doctors[i]['id'] ||
                              val.indexenddoctor == 1) {
                            val.indexenddoctor = val.doctors[i]['id'];
                          }
                        }
                        return i < val.doctors.length
                            ? Card(
                                color: Colors.white,
                                margin: EdgeInsets.all(10),
                                elevation: 20,
                                child: ListTile(
                                  onTap: () {
                                    val.getiddoctorfrompagedoctor(i);
                                    Navigator.of(context)
                                        .pushNamed("profile_doctor_visit");
                                  },
                                  leading: CircleAvatar(
                                      backgroundColor: const Color.fromARGB(
                                          255, 243, 243, 58),
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.black,
                                      )),
                                  title: Text(
                                    "د: ${val.doctors[i]['f_name']} ${val.doctors[i]['s_name']}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    '${val.doctors[i]['city']}-${val.doctors[i]['area']}-${val.doctors[i]['streat']}-${val.doctors[i]['number_build']}',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  trailing:
                                      Text('${val.doctors[i]['specialty']}'),
                                ))
                            : Center(
                                child: IconButton(
                                    onPressed: () {
                                      val.getalldoctors();
                                    },
                                    icon: Icon(Icons.refresh)));
                      }),
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 243, 243, 58),
          child: Icon(
            Icons.person_search,
            color: Colors.black,
          ),
          onPressed: () {
            _Search();
          },
        ));
  }

  //////////////////////////////////////////////////////
  Future<void> _Search() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('بحث'),
          elevation: 10,
          content: Form(
            child: Consumer<control>(builder: (context, val, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      'اختار التخصص',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 40,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: val.specialty.length,
                        itemBuilder: (context, i) {
                          return Container(
                            decoration: BoxDecoration(
                                color: val.indspecialty == i
                                    ? Colors.grey
                                    : const Color.fromARGB(255, 243, 243, 58),
                                borderRadius: BorderRadius.circular(50)),
                            margin: EdgeInsets.only(left: 10),
                            child: TextButton(
                                onPressed: () {
                                  val.changespecialty(i);
                                },
                                child: Text(
                                  '${val.specialty[i]}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )),
                          );
                        }),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      'اختار المدينه',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 40,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: val.city.length,
                        itemBuilder: (context, i) {
                          return Container(
                            decoration: BoxDecoration(
                                color: val.indcity == i
                                    ? Colors.grey
                                    : const Color.fromARGB(255, 243, 243, 58),
                                borderRadius: BorderRadius.circular(50)),
                            margin: EdgeInsets.only(left: 10),
                            child: TextButton(
                                onPressed: () {
                                  val.changecity(i);
                                },
                                child: Text(
                                  '${val.city[i]}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )),
                          );
                        }),
                  ),
                ],
              );
            }),
          ),
          actions: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              child: Consumer<control>(builder: (context, val, child) {
                return IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    val.doctors = [];
                    val.indexenddoctor = 1;
                    val.getalldoctors();
                    Navigator.of(context).pop();
                  },
                );
              }),
            ),
          ],
        );
      },
    );
  }
}
