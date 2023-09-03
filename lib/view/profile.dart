import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';
import 'package:pationt/provider/prov.dart';

class profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _profile();
  }
}

class _profile extends State<profile> {
  @override
  void initState() {
    //TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<control>(context, listen: false).get_work_time();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<control>(context, listen: false).getmypost();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<control>(context, listen: false).getpationtreservation();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<control>(context, listen: false).getlinkapp();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "الملف الشخصي فيه كل حجوزاتك للدكاتره وكل اسئلتك والتعليقات ويمكنك حزف اسئلتك واضافه سؤال جديد ",
            textAlign: TextAlign.center,
          ),
          duration: Duration(seconds: 3),
          
        ),
      );
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _shar();
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
                child: CircleAvatar(
              radius: 25,
              backgroundColor: const Color.fromARGB(255, 243, 243, 58),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed("profile");
                  },
                  icon: Icon(
                    Icons.person_outlined,
                    color: Colors.black,
                  )),
            )),
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
        backgroundColor: const Color.fromARGB(255, 243, 243, 58),
        title: Text(
          'الملف الشخصي',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {
                setting();
              },
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ))
        ],
        leading: IconButton(
              onPressed: () {
                _shar();
              },
              icon: Icon(
                Icons.share,
                color: Colors.black,
              )),
      ),
      body: Consumer<control>(builder: (context, val, child) {
        return Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Column(
                      children: [
                        Container(
                          color: Colors.white,
                          height: 200,
                          width: double.infinity,
                          child: Image.asset(
                            'images/logo.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                          height: 1,
                          thickness: 1.0,
                        ),
                        Container(
                          //color: Colors.white,
                          height: 50,
                          width: double.infinity,
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      child: CircleAvatar(
                          radius: 50,
                          backgroundColor:
                              const Color.fromARGB(255, 243, 243, 58),
                          child: Icon(
                            Icons.person,
                            color: Colors.black,
                            size: 50,
                          )),
                    ),
                  ],
                ),
                //name who have profile
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Text(
                    "${val.namebox.get('name')}",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(bottom: 10, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin:
                            EdgeInsets.only(left: 40, right: 25, bottom: 10),
                        child: Text(
                          '${val.phonebox.get('phone')}',
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                        ),
                      ),
                      Container(
                        child: Icon(
                          Icons.call,
                          size: 30,
                          color: Colors.grey,
                        ),
                        margin: EdgeInsets.only(right: 25),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                  child: Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                ),
                //rserfation
                Container(
                    child: Center(
                        child: Text(
                  'الحوجزات',
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ))),

                Container(
                  width: double.infinity,
                  height: 300,
                  child: ListView.builder(
                      itemCount: val.reservation.length,
                      itemBuilder: (context, i) {
                        return Card(
                          margin: EdgeInsets.all(10),
                          elevation: 10,
                          child: ListTile(
                            onTap: () {
                              val.getiddoctorfrommyprofile(i);
                              Navigator.of(context)
                                  .pushNamed('profile_doctor_visit');
                            },
                            title: Text(
                              'د: ${val.reservation[i]['name_doctor']}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                                'المريض: ${val.reservation[i]['name_pationt']}'),
                            trailing: Text(
                                'تاريخ الحجز: ${val.reservation[i]['date_enter']}'),
                          ),
                        );
                      }),
                ),

                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                  child: Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                ),
                /////////////////////////////////////////////////////////////posts
                Container(
                    child: Center(
                        child: Text(
                  'المنشورات',
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ))),
                Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height - 300,
                    child: ListView.builder(
                        itemCount: val.myposts.length,
                        itemBuilder: (context, i) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Text(
                                      "${val.myposts[i]['name']} ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(right: 20, bottom: 10),
                                    child: CircleAvatar(
                                        radius: 20,
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
                              Container(
                                alignment: Alignment.topRight,
                                margin: EdgeInsets.only(
                                    left: 40, right: 40, bottom: 10),
                                child: Text(
                                  ' ${val.myposts[i]['post']}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.end,
                                  maxLines: 10,
                                ),
                              ),
                              Divider(
                                endIndent: 10,
                                indent: 10,
                                thickness: 0.5,
                                color: Colors.black,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: double.infinity,
                                      child: IconButton(
                                          onPressed: () {
                                            val.takeidofpost(i);
                                            _deletepost();
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            size: 30,
                                          )),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('عرض تعليقات الدكاتره '),
                                          IconButton(
                                              onPressed: () {
                                                val.getidmyquistion(i);
                                                _comment();
                                              },
                                              icon: Icon(
                                                Icons.comment,
                                                size: 30,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: double.infinity,
                                height: 10,
                                color: Colors.grey.shade400,
                              ),
                            ],
                          );
                        })),
              ],
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 243, 243, 58),
          onPressed: () {
            _addpost();
          },
          child: Icon(
            Icons.post_add,
            color: Colors.black,
          )),
    );
  }

  /////////////////////////////////////////////////////////////////////////////

  Future<void> _delet() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('مسح'),
          elevation: 10,
          content: Form(
            child: Consumer<control>(builder: (context, val, child) {
              return Column(
                children: [
                  Center(
                    child: Text(
                      '!!هل انت متاكد من عمليه الحذف',
                      style: TextStyle(color: Colors.redAccent, fontSize: 15),
                    ),
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
                    Icons.delete,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    val.delet_work_time();
                    val.get_work_time();
                    Navigator.of(context).pop();
                    _check_delete_work_time();
                  },
                );
              }),
            ),
          ],
        );
      },
    );
  }

  Future<void> _check_delete_work_time() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('تحقق'),
          elevation: 10,
          content: Form(
            child: Consumer<control>(builder: (context, val, child) {
              return Column(
                children: [
                  Center(
                    child: val.delet[0]['mes'] == 'good'
                        ? Text(
                            'تم الحذف',
                            style: TextStyle(
                                color: Colors.greenAccent, fontSize: 15),
                          )
                        : Text(
                            'هناك مشكله!!',
                            style: TextStyle(
                                color: Colors.redAccent, fontSize: 15),
                          ),
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

  Future<void> _addpost() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('اضافه سؤال طبي'),
          elevation: 10,
          content: Form(
            child: Consumer<control>(builder: (context, val, child) {
              return Center(
                child: TextFormField(
                  controller: val.post,
                  decoration: InputDecoration(
                    label: Text("السؤال"),
                  ),
                ),
              );
            }),
          ),
          actions: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              child: Consumer<control>(builder: (context, val, child) {
                return IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    if (val.post.text != '') {
                      val.addpost();
                    }
                    Navigator.of(context).pop();
                    _check_addpost();
                    val.getallposts();
                  },
                );
              }),
            ),
          ],
        );
      },
    );
  }

  Future<void> _check_addpost() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('تحقق'),
          elevation: 10,
          content: Form(
            child: Consumer<control>(builder: (context, val, child) {
              return Column(
                children: [
                  Center(
                    child: val.postlist[0]['mes'] == 'good'
                        ? Text(
                            'تم اضافه المعلومه الطبيه',
                            style: TextStyle(
                                color: Colors.greenAccent, fontSize: 15),
                          )
                        : CircularProgressIndicator(),
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

  Future<void> _deletepost() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('مسح'),
          elevation: 10,
          content: Form(
            child: Consumer<control>(builder: (context, val, child) {
              return Column(
                children: [
                  Center(
                    child: Text(
                      '!!هل انت متاكد من عمليه الحذف',
                      style: TextStyle(color: Colors.redAccent, fontSize: 15),
                    ),
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
                    Icons.delete,
                    color: Colors.black,
                  ),
                  onPressed: () async {
                    val.deletmypost();

                    Navigator.of(context).pop();
                    val.getmypost();
                    await _check_delete_post();
                  },
                );
              }),
            ),
          ],
        );
      },
    );
  }

  Future<void> _check_delete_post() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('تحقق'),
          elevation: 10,
          content: Form(
            child: Consumer<control>(builder: (context, val, child) {
              return Column(
                children: [
                  Center(
                    child: val.postsdelet[0]['mes'] == 'good'
                        ? Text(
                            'تم الحذف',
                            style: TextStyle(
                                color: Colors.greenAccent, fontSize: 15),
                          )
                        : CircularProgressIndicator(),
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

  setting() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('اعدادات'),
          elevation: 10,
          content: Form(
            child: Consumer<control>(builder: (context, val, child) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            checklogout();
                          },
                          child: Text(
                            "تسجيل الخروج من الحساب",
                            style: TextStyle(color: Colors.black),
                          )),
                      Icon(Icons.logout),
                    ],
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

  checklogout() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('تاكيد تسجيل الخروج'),
          elevation: 10,
          content: Form(
            child: Consumer<control>(builder: (context, val, child) {
              return Column(
                children: [
                  Text(
                    "هل انت متاكد من تسجل الخروج؟؟",
                    style: TextStyle(color: Colors.redAccent),
                  ),
                  //Icon(Icons.logout),
                ],
              );
            }),
          ),
          actions: <Widget>[
            Row(
              children: [
                Expanded(
                  child: Consumer<control>(builder: (context, val, child) {
                    return IconButton(
                        onPressed: () {
                          val.logout();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              'signin', (route) => false);
                        },
                        icon: Icon(
                          Icons.offline_pin_outlined,
                          color: Colors.greenAccent,
                          size: 30,
                        ));
                  }),
                ),
                Expanded(
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        //Navigator.of(context).pushNamed('routeName');
                      },
                      icon: Icon(
                        Icons.arrow_back_outlined,
                        color: Colors.black,
                        size: 30,
                      )),
                )
              ],
            ),
          ],
        );
      },
    );
  }

  _comment() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('كل تعليقات الدكاتره'),
          elevation: 10,
          content: Form(
            child: Consumer<control>(builder: (context, val, child) {
              return Center(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.sizeOf(context).height - 400,
                      width: 300,
                      child: ListView.builder(
                          itemCount: val.Comments.length,
                          itemBuilder: (context, i) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 30),
                                  width: 299,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                          right: 10,
                                        ),
                                        child: TextButton(
                                          onPressed: () {
                                            val.getiddoctorfromcomment(i);
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pushNamed(
                                                'profile_doctor_visit');
                                          },
                                          child: Text(
                                            "د: ${val.Comments[i]['f_name']} ${val.Comments[i]['s_name']}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                            textAlign: TextAlign.end,
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
                                      left: 40, right: 40, bottom: 20),
                                  child: Text(
                                    '${val.Comments[i]['comment']} ',
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
                                )
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              );
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
  Future<void> _shar() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text(
            "شارك رابط التطبيق مع اصدقائك ربما يحتاجونه لحجز دكتور لمرضاهم",
            textAlign: TextAlign.end,
          ),
          elevation: 10,
          content: Form(
            child: Consumer<control>(builder: (context, val, child) {
              return Column(
                children: [
                  Center(
                    child: Text(
                      " ${val.linkapp[0]['data']}",
                      style: TextStyle(color: Colors.redAccent, fontSize: 15),
                    ),
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
                    Icons.copy,
                    color: Colors.black,
                  ),
                  onPressed: () async {
                    Clipboard.setData(ClipboardData(
                        text:
                            "تطبيق دكتور لحجز معاد كشف مع افضل واقرب الدكاتره ليك واسعار الكشف وعنوان الدكتور وهيرد عليك حد ياكد حجزك حمل التطبيق وشاركه مع اصدقائك من هذا اللينك  \n https://google.com"));
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
