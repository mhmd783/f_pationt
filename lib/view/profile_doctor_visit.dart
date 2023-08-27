import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:jiffy/jiffy.dart';

import 'package:provider/provider.dart';
import 'package:pationt/provider/prov.dart';

class profile_doctor_visit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _profile_doctor_visit();
  }
}

class _profile_doctor_visit extends State<profile_doctor_visit> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<control>(context, listen: false).getdatadoctorvesitprofile();
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<control>(context, listen: false)
          .get_work_time_profile_doctor_visit();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<control>(context, listen: false)
          .getpost_profile_doctor_visit();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "ملف الدكتور الشخصي يمكنك حجز كشف ومعرفه مواعيد عمل الدكتور وعنوانه وسعر الكشف ويمكنك رؤيه معلوماته الطبيه اللي بينشرها علي حسابه",
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
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 243, 243, 58),
        toolbarHeight: 0,
      ),
      body: Consumer<control>(builder: (context, val, child) {
        return !val.datadoctor.isEmpty
            ? Container(
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
                                  'images/back1.png',
                                  fit: BoxFit.cover,
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
                      Container(
                        margin: EdgeInsets.only(right: 20),
                        child: Text(
                          "${val.datadoctor[0]['f_name']} ${val.datadoctor[0]['s_name']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(left: 40, right: 25, bottom: 10),
                        child: Text(
                          'التخصص: ${val.datadoctor[0]['specialty']}',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            val.i_rating[0]['mes'] == 'not'
                                ? Container(
                                    color:
                                        const Color.fromARGB(255, 243, 243, 58),
                                    child: MaterialButton(
                                      onPressed: () {
                                        val.addrating();
                                        _check_add_rating();
                                      },
                                      child: Text('قيمني'),
                                    ),
                                  )
                                : Container(),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 40, right: 25, bottom: 10),
                              child: Text(
                                'التقييمات ${val.datadoctor[0]['rating']}',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              child: Icon(
                                val.i_rating[0]['mes'] == 'not'
                                    ? Icons.star_border
                                    : Icons.star,
                                size: 35,
                              ),
                              margin: EdgeInsets.only(right: 25),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: 40, right: 25, bottom: 10),
                              child: Text(
                                '${val.datadoctor[0]['salary']} الكشف ',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 15),
                              ),
                            ),
                            Container(
                              child: Icon(
                                Icons.money,
                                size: 35,
                              ),
                              margin: EdgeInsets.only(right: 25),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Container(
                                alignment: Alignment.topRight,
                                margin: EdgeInsets.only(
                                    left: 40, right: 25, bottom: 10),
                                child: Text(
                                  "${val.datadoctor[0]['city']}-${val.datadoctor[0]['area']}-${val.datadoctor[0]['streat']}-${val.datadoctor[0]['number_build']}",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                  maxLines: 10,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Icon(
                                  Icons.location_on,
                                  size: 35,
                                ),
                                margin: EdgeInsets.only(right: 25),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Center(
                            child: Text(
                          'مواعيد الحجز',
                          style: TextStyle(fontSize: 20),
                        )),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: 10, left: 25, right: 25, bottom: 10),
                        width: double.infinity,
                        height: 150,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: val.data_work_time_get == []
                                ? 0
                                : val.data_work_time_get.length,
                            itemBuilder: (context, i) {
                              return Container(
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  // color: const Color.fromARGB(255, 243, 243, 58),
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                    top: BorderSide(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                    right: BorderSide(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                    left: BorderSide(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                margin: EdgeInsets.only(left: 10),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${val.data_work_time_get[i]['day']}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${val.data_work_time_get[i]['start_time']}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${val.data_work_time_get[i]['end_time']}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    // IconButton(
                                    //     onPressed: () {

                                    //     },
                                    //     icon: Icon(Icons.delete)),
                                  ],
                                ),
                              );
                            }),
                      ),
                      Container(
                          margin: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width / 2 - 50,
                              bottom: 30,
                              top: 10),
                          width: 100,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 243, 243, 58),
                              borderRadius: BorderRadius.circular(10)),
                          child: MaterialButton(
                            onPressed: () {
                              _addpationt();
                              val.enterdatapationt();
                            },
                            child: Text('احجز'),
                          )),
                      /////////////////////////////////////
                      Container(
                        margin:
                            EdgeInsets.only(left: 40, right: 25, bottom: 10),
                        child: Text(
                          'معلومات عن الدكتور ',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(left: 40, right: 30, bottom: 10),
                        child: Text(
                          '${val.datadoctor[0]['description']} ',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      //Divider>
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                      ),
                      /////////////////////////////////////////////////////////////posts

                      !val.post_visit.isEmpty
                          ? Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height - 200,
                              child: ListView.builder(
                                  itemCount: val.post_visit.length,
                                  itemBuilder: (context, i) {
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              child: Text(
                                                "${val.post_visit[i]['f_name']} ${val.post_visit[i]['s_name']}",
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
                                        Container(
                                          alignment: Alignment.topRight,
                                          margin: EdgeInsets.only(
                                              left: 40, right: 40, bottom: 10),
                                          child: Text(
                                            ' ${val.post_visit[i]['post']}',
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
                                    );
                                  }))
                          : Center(
                              child: Text('لا يوجد بيانات '),
                            ),
                    ],
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      }),
    );
  }

  /////////////////////////////////////////////////add pationt
  Future<void> _addpationt() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('اضافه مريض'),
          elevation: 10,
          content: Consumer<control>(builder: (context, val, child) {
            return Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: val.namepationt,
                    decoration: InputDecoration(
                        label: Text('اسم المريض'),
                        prefixIcon: Icon(Icons.attribution)),
                  ),
                  TextFormField(
                    controller: val.phonepationt,
                    //initialValue: '01',
                    decoration: InputDecoration(
                        label: Text('رقم تلفون'),
                        prefixIcon: Icon(Icons.phone)),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'\d')),
                    ],
                  ),
                  TextFormField(
                    controller: val.agepationt,
                    decoration: InputDecoration(
                        label: Text('عمره'), prefixIcon: Icon(Icons.av_timer)),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'\d')),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      val.date == ''
                          ? Expanded(
                              flex: 5,
                              child: Text(
                                "اختار تاريخ حجز مناسب مع مواعيد عمل الدكنور",
                                textAlign: TextAlign.end,
                              ))
                          : Expanded(
                              flex: 5,
                              child: Text(
                                "${val.date}",
                                textAlign: TextAlign.end,
                              )),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                            onPressed: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2050),
                              ).then((value) {
                                if (value != null) {
                                  val.date = value.toString();
                                  val.date = Jiffy.parse('${val.date}').yMd;
                                  val.changedatepationt();
                                }
                              });
                            },
                            icon: Icon(Icons.date_range)),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
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
                    if (val.date != '' &&
                        val.namepationt.text != '' &&
                        val.phonepationt.text.length > 10) {
                      val.addpationt();
                      Navigator.of(context).pop();
                      _check_add_pationt();
                    } else {
                      _check_add_pationt_data();
                    }
                  },
                );
              }),
            ),
          ],
        );
      },
    );
  }

  Future<void> _check_add_pationt() async {
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
                    child: val.checkaddpationt[0]['mes'] == 'good'
                        ? Text(
                            'تم حجز الكشف ',
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

  Future<void> _check_add_pationt_data() async {
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
                      child: Text(
                    'خطاء في بيانات المريض المدخله!!',
                    style: TextStyle(color: Colors.red, fontSize: 15),
                  )),
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

  Future<void> _check_add_rating() async {
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
                    child: val.rating[0]['mes'] == 'good'
                        ? Text(
                            'شكرا لتقييمك',
                            style: TextStyle(
                                color: Colors.greenAccent, fontSize: 15),
                          )
                        :CircularProgressIndicator(),
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
