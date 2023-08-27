import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pationt/provider/prov.dart';
import 'package:provider/provider.dart';

class home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _home();
  }
}

class _home extends State<home> {
  @override
  void initState() {
    
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<control>(context, listen: false).getallposts();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "معلومات من الدكاتره بينشروها للاستفاده القي نظره ويمكنك دخول حساب الدكتور وحجز كشف ",
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
                  child: CircleAvatar(
                radius: 25,
                backgroundColor: const Color.fromARGB(255, 243, 243, 58),
                child: Consumer<control>(builder: (context, val, child) {
                  return IconButton(
                    onPressed: () {
                      val.indexendpost = 1;
                      val.posts = [];
                      val.getallposts();
                      //Navigator.of(context).pushReplacementNamed("home");
                    },
                    icon: Icon(Icons.home_outlined, color: Colors.black),
                  );
                }),
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
          title: Consumer<control>(builder: (context, val, child) {
            return Text(
              //${val.f_namebox.get('f_name')} ${val.s_namebox.get('s_name')}
              'معلومات طبيه من الاطباء',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            );
          }),
          backgroundColor: const Color.fromARGB(255, 243, 243, 58),
        ),
        body: Consumer<control>(builder: (context, val, child) {
          return
              /////////////////////////////////////////////////////////////posts

              !val.posts.isEmpty
                  ? Container(
                      width: double.infinity,
                      //height: MediaQuery.of(context).size.height - 200,
                      child: ListView.builder(
                          itemCount: val.posts.length + 1,
                          itemBuilder: (context, i) {
                            if (i < val.posts.length) {
                              val.indexendpost = val.posts[i]['id'];
                            }
                            return i < val.posts.length
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 30),
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                right: 10,
                                              ),
                                              child: TextButton(
                                                onPressed: () {
                                                  val.getiddoctor(i);
                                                  Navigator.of(context).pushNamed(
                                                      'profile_doctor_visit');
                                                },
                                                child: Text(
                                                  "د: ${val.posts[i]['f_name']} ${val.posts[i]['s_name']}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: 20, bottom: 10),
                                              child: CircleAvatar(
                                                  radius: 20,
                                                  backgroundColor:
                                                      const Color.fromARGB(
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
                                            left: 40, right: 40, bottom: 30),
                                        child: Text(
                                          ' ${val.posts[i]['post']}',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                          ),
                                          maxLines: 10,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 10,
                                        color: Colors.grey.shade400,
                                      ),
                                    ],
                                  )
                                : Center(
                                    child: IconButton(
                                        onPressed: () {
                                          val.getallposts();
                                        },
                                        icon: Icon(
                                          Icons.refresh,
                                          size: 40,
                                          color: Colors.blue,
                                        )),
                                  );
                          }))
                  : Center(
                      child: CircularProgressIndicator(),
                    );
        }),
      );
  }

  
}
