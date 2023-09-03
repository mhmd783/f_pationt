import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pationt/provider/prov.dart';
import 'package:provider/provider.dart';

class quistion extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _quistion();
  }
}

class _quistion extends State<quistion> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<control>(context, listen: false).getallquistion();
    });
    

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'يمكنك طرح سؤال او استفسار طبي وهيتم الرد عليك بتعليق من الدكاتره ويمكنك رؤيه اسئله الاخرين والتعليقات وحفاظا علي سريه معلوماتك لا احد يعم من طرح السؤال منعا لاحراجك',
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
                          Navigator.of(context).pushReplacementNamed("notification");
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
                child: CircleAvatar(
              radius: 25,
              backgroundColor: const Color.fromARGB(255, 243, 243, 58),
              child: Consumer<control>(builder: (context, val, child) {
                return IconButton(
                    onPressed: () {
                      val.indexendquistion = 1;
                      val.quistion = [];
                      val.getallquistion();
                      //Navigator.of(context).pushReplacementNamed("quistion");
                    },
                    icon: Icon(
                      Icons.question_mark_rounded,
                      color: Colors.black,
                    ));
              }),
            )),
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
            'اسئله المرضى',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          );
        }),
        backgroundColor: const Color.fromARGB(255, 243, 243, 58),
      ),
      body: Consumer<control>(builder: (context, val, child) {
        return
            /////////////////////////////////////////////////////////////posts

            !val.quistion.isEmpty
                ? Container(
                    width: double.infinity,
                    //height: MediaQuery.of(context).size.height - 200,
                    child: ListView.builder(
                        itemCount: val.quistion.length + 1,
                        itemBuilder: (context, i) {
                          if (i < val.quistion.length) {
                            val.indexendquistion = val.quistion[i]['id'];
                          }
                          return i < val.quistion.length
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
                                            child: Text(
                                              "شخص ما",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
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
                                          left: 40,
                                          right: 40,
                                          top: 10,
                                          bottom: 10),
                                      child: Text(
                                        '${val.quistion[i]['post']}',
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
                                    Container(
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('عرض تعليقات الدكاتره '),
                                          IconButton(
                                              onPressed: () {
                                                val.getidquistion(i);
                                                _comment();
                                              },
                                              icon: Icon(
                                                Icons.comment,
                                                size: 30,
                                              )),
                                        ],
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
                                        val.getallquistion();
                                      },
                                      icon: Icon(
                                        Icons.refresh,
                                        size: 40,
                                        
                                      )),
                                );
                        }))
                : Center(
                    child: CircularProgressIndicator(),
                  );
        //:
        // Center(
        //   child: CircularProgressIndicator(),
        // );
      }),
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 243, 243, 58),
          child: Icon(
            Icons.post_add,
            color: Colors.black,
          ),
          onPressed: () {
            _addpost();
          },
        )
    );
  }

  //add comment
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
                                            //val.getiddoctor(i);
                                            // Navigator.of(context)
                                            //     .pushNamed('profile_doctor_visit');
                                          },
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

  
  //////////////////////////////////////////////////////add post
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
}
