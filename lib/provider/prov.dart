import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';

class control extends ChangeNotifier {
  String ip = '192.168.1.7';
  late Box idbox = Hive.box("id");
  late Box namebox = Hive.box("name");
  late Box phonebox = Hive.box("phone");
  late Box passbox = Hive.box("pass");
  late Box agebox = Hive.box("age");
  int gender = 0;

  List<String> specialty = [
    "",
    "اسنان",
    "اطفال وحديثي الولاده",
    "جلدية",
    "مخ واعصاب",
    "عظام",
    "نساء وتوليد",
    "باطنة",
    "عيون",
    "كبد",
    "كلى",
    "انف وازن وحنجر",
    "جراحة تجميل",
    "قلب واوعية دمويه",
    "الآشعة التداخلية",
    "امراض الدم",
    "اورام",
    "تخسيس وتغذية",
    "نفسي",
    "جراحة اطفال",
    "جراحةأورام",
    "جراحة اوعية دموية",
    "جراحة سمنة ومناظر",
    "جراحة عامة",
    "جراحة عمود فقري",
    "جراحة قلب وصدر",
    "جراحة مخ واعصاب",
    "جهاز هضمي ومناظير",
    "حساسية ومناعة",
    "حقن مجهري واطفال انابيب",
    "ذكورة وعقم",
    "روماتيزم",
    "سكر وغدد صماء",
    "سمعيات",
    "صدر وجهاز تنفسي",
    "طب الاسرة",
    "طب المسنين",
    "طب تقويمي",
    "علاج الآلام",
    "علاج طبيعي واصابات ملاعب",
    "مراكز اشعه",
    "مسالك بوليه",
    "معامل تحاليل",
    "ممارسة عامة",
    "نطق وتخاطب"
  ];
  List<String> city = [
    "",
    "القاهرة",
    "الجيزة",
    "الأسكندرية",
    "الدقهلية",
    "الشرقية",
    "المنوفية",
    "القليوبية",
    "البحيرة",
    "الغربية",
    "بور سعيد",
    "دمياط",
    "الإسماعلية",
    "السويس",
    "كفر الشيخ",
    "الفيوم",
    "بني سويف",
    "مطروح",
    "شمال سيناء",
    "جنوب سيناء",
    "المنيا",
    "أسيوط",
    "سوهاج",
    "قنا",
    "البحر الأحمر",
    "الأقصر",
    "أسوان",
    "الواحات",
    "الوادي الجديد"
  ];

  int indcity = 0;
  int indspecialty = 0;
  //signup////////////////////////////////////////////////////
  TextEditingController name = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  TextEditingController pass1 = new TextEditingController();
  TextEditingController age = new TextEditingController();
  String genderform = '';

  var datarigester = null;

  void registernew() async {
    datarigester = null;
    String url =
        "http://$ip/doctor/view/siginup.php?name=${name.text}&phone=${phone.text}&pass=${pass.text}&age=${age.text}&gender=${genderform}";

    try {
      var responseregister = await http.get(Uri.parse(url));
      if (!responseregister.body.isEmpty) {
        var responsebody = jsonDecode(responseregister.body);

        datarigester = responsebody;
      }
    } catch (e) {
      print(e);
    }
    print(datarigester);
    print(datarigester);
    print(datarigester);
    notifyListeners();
  }

  //signin///////////////////////////////////////////
  TextEditingController phonesignin = new TextEditingController();
  TextEditingController passsignin = new TextEditingController();

  //get account

  var data = null;
  void getdata() async {
    data = null;
    String url =
        "http://$ip/doctor/view/signin.php?phone=${phonesignin.text}&pass=${passsignin.text}";

    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        data = responsebody;
        idbox.put('id', '${data[0]['id']}');
        namebox.put('name', '${data[0]['name']}');
        phonebox.put('phone', '${data[0]['phone']}');
        passbox.put('pass', '${data[0]['pass']}');
        agebox.put('age', '${data[0]['age']}');
      }
    } catch (e) {
      print(e);
    }
    print('object');
    print('object');
    print('object');
    print('object');
    print("${data}"); 
    notifyListeners();
  }

  // void changecity(i) {
  //   indcity = i;
  //   notifyListeners();
  // }

  // void changespecialty(i) {
  //   indspecialty = i;
  //   notifyListeners();
  // }

  void chosegender(String type) {
    if (type == 'male') {
      genderform = type;
      gender = 1;
    }
    if (type == 'fmale') {
      genderform = type;
      gender = 2;
    }
    notifyListeners();
  }

  //////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////
  ///

  TimeOfDay timestart = TimeOfDay.now();
  TimeOfDay timeend = TimeOfDay.now();
  String timestartnew = '00:00';
  String timeendnew = "00:00";

  String day = '';
  List<String> weak = [
    "",
    "السبت",
    "الاحد",
    "الاتنين",
    "الثلاثاء",
    "الاربعاء",
    "الخميس",
    "الجمعه",
  ];

  //page profile
  List data_work_time = [
    {'mes': 'not'}
  ];
  void add_work_time() async {
    data_work_time = [
      {'mes': 'not'}
    ];
    String url =
        "http://$ip/doctor/view/add_time_work.php?id_doctor=${idbox.get('id')}&start_time=${timestartnew}&end_time=${timeendnew}&day=${day}";

    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        data_work_time = responsebody;
      }
    } catch (e) {
      print(e);
    }

    get_work_time();

    notifyListeners();
  }

  List data_work_time_get = [];
  void get_work_time() async {
    data_work_time_get = [];
    String url =
        "http://$ip/doctor/view/get_time_work.php?id_doctor=${idbox.get('id')}";
    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        data_work_time_get = responsebody;
      }
    } catch (e) {
      print("$e");
    }
    print('${data_work_time_get}');

    notifyListeners();
  }

  String cityt = '';
  void changecity(i) {
    indcity = i;
    cityt = city[i];
    notifyListeners();
  }

  String specialtyt = '';
  void changespecialty(i) {
    indspecialty = i;
    specialtyt = specialty[i];
    notifyListeners();
  }

  void chosestarttime(String x) {
    timestartnew = x;
    notifyListeners();
  }

  void choseendtime(String x) {
    timeendnew = x;
    notifyListeners();
  }

  choseday(int x) {
    day = weak[x];

    notifyListeners();
  }

  int idday = 0;
  changeidday(int x) {
    idday = x;
    notifyListeners();
  }

  List delet = [
    {'mes': 'not'}
  ];
  void delet_work_time() async {
    delet = [
      {'mes': 'not'}
    ];
    String url =
        "http://$ip/doctor/view/get_time_work.php?id_doctordelet=${idbox.get('id')}&id_day=${data_work_time_get[idday]['id']}";
    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        delet = responsebody;
      }
    } catch (e) {
      print(e);
    }
    print('${delet}');
    get_work_time();

    notifyListeners();
  }

  TextEditingController post = new TextEditingController();
  List postlist = [
    {'mes': 'not'}
  ];
  //////share to page home profile
  void addpost() async {
    postlist = [
      {'mes': 'not'}
    ];
    String url =
        "http://$ip/doctor/view/add_post_pationt.php?id_pationt=${idbox.get('id')}&name=${namebox.get('name')}&post=${post.text}";
    post.text = '';
    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        postlist = responsebody;
      }
    } catch (e) {
      print(e);
    }
    print('${postlist}');
    getmypost();
    getallposts();

    notifyListeners();
    post.text = '';
  }

  List myposts = [];
  void getmypost() async {
    myposts = [];
    String url =
        "http://$ip/doctor/view/add_post_pationt.php?id_pationt=${idbox.get('id').toString()}&get=get";
    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        myposts = responsebody;
      }
    } catch (e) {
      print(e);
    }

    print('object');
    print('${myposts}');

    notifyListeners();
  }

  int idpost = 0;
  takeidofpost(int i) {
    idpost = myposts[i]['id'];
    notifyListeners();
  }

  List postsdelet = [
    {'mes': 'not'}
  ];
  void deletmypost() async {
    postsdelet = [
      {'mes': 'not'}
    ];
    String url =
        "http://$ip/doctor/view/add_post_pationt.php?id_pationt=${idbox.get('id').toString()}&id_post=$idpost";
    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        postsdelet = responsebody;
      }
    } catch (e) {
      print(e);
    }
    print('${postsdelet}');
    getmypost();
    getallposts();

    notifyListeners();
  }

  //page home doctor

  List posts = [];
  int indexendpost = 1;
  void getallposts() async {
    //posts = [];
    String url = "http://$ip/doctor/view/get_all_posts.php?id=$indexendpost";
    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        //posts.add(responsebody);
        for (var post in responsebody) {
          posts.add(post);
        }
      }
    } catch (e) {
      print(e);
    }
    print('${posts}');
    //changeIconlike();
    notifyListeners();
  }

  //page profile doctor visit ///////////////////////////////
  int id_doctor = 0;
  getiddoctor(int i) {
    id_doctor = int.parse(posts[i]['id_doctor']);
  }

  getiddoctorfrommyprofile(int i) {
    id_doctor = int.parse(reservation[i]['id_doctor']);
  }

  List datadoctor = [];
  void getdatadoctorvesitprofile() async {
    datadoctor = [];
    String url = "http://$ip/doctor/view/signindoc.php?id=$id_doctor";

    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);

        datadoctor = responsebody;
      }
    } catch (e) {
      print(e);
    }
    get_if_i_rating();
    print('${datadoctor}');
    notifyListeners();
  }

  void get_work_time_profile_doctor_visit() async {
    data_work_time_get = [
      {'mes': 'not'}
    ];
    String url =
        "http://$ip/doctor/view/get_time_work.php?id_doctor=${id_doctor.toString()}";
    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        data_work_time_get = responsebody;
      }
    } catch (e) {
      print("$e");
    }
    print('${data_work_time_get}');

    notifyListeners();
  }

  List post_visit = [];
  void getpost_profile_doctor_visit() async {
    post_visit = [];
    String url =
        "http://$ip/doctor/view/add_post_doc.php?id_doctor=${id_doctor.toString()}&get=get";
    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        post_visit = responsebody;
      }
    } catch (e) {
      print(e);
    }
    print('post');
    print('${post_visit}');
    print('post');

    notifyListeners();
  }

  //add pationt page profolr visit doctor

  String date = '';
  TextEditingController namepationt = new TextEditingController();
  TextEditingController phonepationt = new TextEditingController();
  TextEditingController agepationt = new TextEditingController();
  enterdatapationt() {
    namepationt.text = '${namebox.get('name')}';
    phonepationt.text = '${phonebox.get('phone')}';
    agepationt.text = '${agebox.get('age')}';
    date = '';
    notifyListeners();
  }

  changedatepationt() {
    date = date;
    notifyListeners();
  }

  //page quistion ////////////////////////////////////////////////
  List quistion = [];
  int indexendquistion = 1;
  void getallquistion() async {
    //posts = [];
    String url =
        "http://$ip/doctor/view/getallquistion.php?id=$indexendquistion";
    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        //posts.add(responsebody);
        for (var quis in responsebody) {
          quistion.add(quis);
        }
      }
    } catch (e) {
      print(e);
    }
    print('${quistion}');
    //changeIconlike();
    notifyListeners();
  }

  int idquistion = 0;
  getidquistion(int i) {
    idquistion = quistion[i]['id'];

    notifyListeners();
    getcommentpost();
  }

  getidmyquistion(int i) {
    idquistion = myposts[i]['id'];

    notifyListeners();
    getcommentpost();
  }

  List Comments = [];
  getcommentpost() async {
    Comments = [];
    String url =
        "http://$ip/doctor/view/comment.php?id_posts=${idquistion.toString()}";

    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);

        Comments = responsebody;
      }
    } catch (e) {
      print(e);
    }
    print('object');
    print('$Comments');
    notifyListeners();
  }

  getiddoctorfromcomment(int i) {
    id_doctor = int.parse(Comments[i]['id_doctor']);
  }

  //this function in page profile doctor visit but take it her becouse it not work
  List checkaddpationt = [
    {'mes': 'not'}
  ];
  addpationt() async {
    checkaddpationt = [
      {'mes': 'not'}
    ];
    if (date != '' && namepationt != '' && phonepationt != '') {
      String url =
          "http://$ip/doctor/view/addpationt.php?id_pationt=${idbox.get('id')}&id_doctor=${datadoctor[0]['id']}&name_doctor=${datadoctor[0]['f_name']} ${datadoctor[0]['s_name']}&namepationt=${namepationt.text}&phonepationt=${phonepationt.text}&agepationt=${agepationt.text}&date=$date";

      try {
        var response = await http.get(Uri.parse(url));
        if (!response.body.isEmpty) {
          var responsebody = jsonDecode(response.body);
          checkaddpationt = responsebody;
        }
      } catch (e) {
        print(e);
      }
    }
    print('${checkaddpationt}');

    notifyListeners();
  }

  //page notifiction
  List reservation = [];

  void getpationtreservation() async {
    reservation = [];
    String url =
        "http://$ip/doctor/view/addpationt.php?id_pationt_profile=${idbox.get('id').toString()}";
    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        reservation = responsebody;
      }
    } catch (e) {
      print(e);
    }
    print('${reservation}');

    notifyListeners();
  }

  List comments = [];
  void getcomments() async {
    comments = [];
    String url =
        "http://$ip/doctor/view/comment.php?id_pat=${idbox.get('id').toString()}";
    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        comments = responsebody;
      }
    } catch (e) {
      print(e);
    }
    print('${comments}');

    notifyListeners();
  }

  List numbercomment = [
    {'mes': 0}
  ];
  void getnumbercomment() async {
    numbercomment = [
      {'mes': 0}
    ];
    String url =
        "http://$ip/doctor/view/comment.php?id_pationt_number_comment=${idbox.get('id').toString()}";
    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        numbercomment = responsebody;
      }
    } catch (e) {
      print(e);
    }
    print('number');
    print('${numbercomment}');

    notifyListeners();
  }

  //page profile logout
  logout() {
    idbox.put('id', '');

    phonebox.put('phone', '');
    passbox.put('pass', '');
    agebox.put('age', '');
  }

  String idpostnotifiction = '';
  int idcommentinlist = 0;
  String iddoctorinnotification = '';
  int idcomment = 0;
  String namedoctor = '';
  String comment = '';
  getidmyquistioninnotification(int i) {
    idpostnotifiction = comments[i]['id_post'];
    idcommentinlist = i;
    id_doctor = int.parse(comments[idcommentinlist]['id_doctor']);
    idcomment = comments[idcommentinlist]['id'];
    namedoctor =
        '${comments[idcommentinlist]['f_name']} ${comments[idcommentinlist]['s_name']}';
    comment = comments[idcommentinlist]['comment'];
    print('mmmmm');
    getquistionnotification();
    notifyListeners();
    getcommentpost();
  }

  List quistionnotification = [];

  void getquistionnotification() async {
    quistionnotification = [];
    String url =
        "http://$ip/doctor/view/getallquistion.php?idnot=$idpostnotifiction";
    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        //posts.add(responsebody);

        quistionnotification = responsebody;
      }
    } catch (e) {
      print(e);
    }
    print('${quistionnotification}');
    notifyListeners();
  }

  //page doctor/////////////////////////////////////////////////////////////////
  List doctors = [];
  int indexenddoctor = 1;
  void getalldoctors() async {
    String url =
        "http://$ip/doctor/view/get_doctors.php?id=$indexenddoctor&specialty=$specialtyt&city=$cityt";
    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        //posts.add(responsebody);
        for (var doc in responsebody) {
          doctors.add(doc);
        }
      }
    } catch (e) {
      print(e);
    }
    print('${doctors}');
    //changeIconlike();
    notifyListeners();
  }

  getiddoctorfrompagedoctor(int i) {
    id_doctor = doctors[i]['id'];
  }

  TextEditingController search = new TextEditingController();
  List searches = [];
  void getsearch() async {
    searches = [];
    String url = "http://$ip/doctor/view/get_doctors.php?name=${search.text}";
    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        //posts.add(responsebody);
        searches = responsebody;
      }
    } catch (e) {
      print(e);
    }
    print('${searches}');
    //changeIconlike();
    notifyListeners();
  }

  getiddoctorfrompagesearch(int i) {
    id_doctor = searches[i]['id'];
  }

  List rating = [
    {'mes': 'not'}
  ];
  void addrating() async {
    rating = [
      {'mes': 'not'}
    ];
    String url =
        "http://$ip/doctor/view/rating.php?id_doctor=$id_doctor&id_pationt=${idbox.get('id')}&add=add";
    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        //posts.add(responsebody);
        rating = responsebody;
      }
    } catch (e) {
      print(e);
    }
    print('${rating}');
    getdatadoctorvesitprofile();

    //changeIconlike();
    notifyListeners();
  }

  List i_rating = [
    {'mes': 'not'}
  ];
  get_if_i_rating() async {
    i_rating = [
      {'mes': 'not'}
    ];
    String url =
        "http://$ip/doctor/view/rating.php?id_pationt=${idbox.get('id')}&id_doctor=$id_doctor&get=get";
    try {
      var response = await http.get(Uri.parse(url));
      if (!response.body.isEmpty) {
        var responsebody = jsonDecode(response.body);
        //posts.add(responsebody);
        i_rating = responsebody;
      }
    } catch (e) {
      print(e);
    }
    print('${i_rating}');
    print('${i_rating}');
    print('${i_rating}');
    //changeIconlike();
    notifyListeners();
  }
}
