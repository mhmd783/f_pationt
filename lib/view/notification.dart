import 'package:flutter/material.dart';

import 'package:pationt/provider/prov.dart';
import 'package:provider/provider.dart';

class notification extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _notification();
  }
}

class _notification extends State<notification> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<control>(context, listen: false).getcomments();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<control>(context, listen: false).getnumbercomment();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "كل تعليقات الدكاتره علي اسئلتك ",
            textAlign: TextAlign.center,
          ),
          duration: Duration(seconds: 3),
          
        ),
      );
    });
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
              backgroundColor: const Color.fromARGB(255, 243, 243, 58),
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
                          Navigator.of(context)
                              .pushReplacementNamed("notification");
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
                      Navigator.of(context).pushReplacementNamed("profile");
                    },
                    icon: Icon(
                      Icons.person_outlined,
                      color: Colors.black,
                    ))),
            Expanded(
                child: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed("home");
              },
              icon: Icon(Icons.home_outlined, color: Colors.black),
            )),
            Expanded(
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed("quistion");
                    },
                    icon: Icon(
                      Icons.question_mark_rounded,
                      color: Colors.black,
                    ))),
            Expanded(
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed("doctor");
                    },
                    icon: Icon(
                      Icons.medical_services_outlined,
                      color: Colors.black,
                    ))),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          " اشعارات الرد علي اسئلتك",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color.fromARGB(255, 243, 243, 58),
      ),
      body: Consumer<control>(builder: (context, val, child) {
        return !val.comments.isEmpty
            ? Container(
                child: ListView.builder(
                    itemCount: val.comments.length,
                    itemBuilder: (context, i) {
                      return Card(
                        margin: EdgeInsets.all(10),
                        elevation: 10,
                        child: ListTile(
                          onTap: () {
                            val.getidmyquistioninnotification(i);
                            _comment();
                          },
                          title: Text(
                            'رد الدكتور: ${val.comments[i]['f_name']} ${val.comments[i]['s_name']}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('علي سؤال لك'),
                        ),
                      );
                    }),
              )
            : Center(
                  child: Text(
                    'لا يوجد بيانات',
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                );
      }),
    );
  }

  _comment() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('التعليق علي منشورك'),
          elevation: 10,
          content: Form(
            child: Consumer<control>(builder: (context, val, child) {
              return !val.quistionnotification.isEmpty
                  ? SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            width: 299,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    right: 5,
                                  ),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      " ${val.quistionnotification[0]['name']}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.only(right: 20, bottom: 10),
                                  child: CircleAvatar(
                                      radius: 22,
                                      backgroundColor: const Color.fromARGB(
                                          255, 243, 243, 58),
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.black,
                                        size: 20,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            margin: EdgeInsets.only(
                                left: 40, right: 40, bottom: 20),
                            child: Text(
                              '${val.quistionnotification[0]['post']} ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                              maxLines: 10,
                              textAlign: TextAlign.end,
                            ),
                          ),
                          Container(
                            height: 5,
                            color: Colors.grey.shade400,
                          ),
                          Container(child: Center(child: Text('التعليقات'))),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            width: 299,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    right: 3,
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      //val.getiddoctorfromcomment(int.parse(val.iddoctorinnotification));
                                      Navigator.of(context).pop();
                                      Navigator.of(context)
                                          .pushNamed('profile_doctor_visit');
                                    },
                                    child: Text(
                                      "د: ${val.namedoctor}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          //fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.only(right: 20, bottom: 10),
                                  child: CircleAvatar(
                                      radius: 17,
                                      backgroundColor: const Color.fromARGB(
                                          255, 243, 243, 58),
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.black,
                                        size: 20,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            margin: EdgeInsets.only(
                                left: 40, right: 40, bottom: 20),
                            child: Text(
                              '${val.comment} ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                              ),
                              maxLines: 10,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container();
            }),
          ),
          actions: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              child: Consumer<control>(builder: (context, val, child) {
                return IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
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
