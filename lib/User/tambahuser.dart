import 'package:audit_app_admin/Widget/isislider.dart';
import 'package:flutter/material.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TambahUser extends StatefulWidget {
  const TambahUser({super.key, required this.userdata});
  final String title = "Tambah User";

  final BackendlessUser userdata;
  @override
  State<TambahUser> createState() => _TambahUserState();
}

class _TambahUserState extends State<TambahUser> {
  bool pswdvisible = true;
  late final TextEditingController usernameController = TextEditingController();
  late final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String dropdown = 'Admin';
  String? onerror;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SliderDrawer(
        slider:
            SliderContent(selector: 5, userdata: widget.userdata), // ISI SLIDER
        appBar: SliderAppBar(
          //BLUE APPBAR
          appBarColor: Colors.white,
          isTitleCenter: true,
          appBarHeight: 50,
          appBarPadding: const EdgeInsets.all(5),
          title: Text(
            widget.title,
            style: const TextStyle(
                color: Colors.blue, fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: Container(
            //MAIN CONTENT
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Tambah User',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Isi form dibawah ini:',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 200.w,
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(20),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 38.w,
                                  padding: const EdgeInsets.all(5),
                                  child: const Text(
                                    "Nama Pengguna : ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const Spacer(
                                  flex: 1,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(5),
                                  width: 100.w,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      errorText: onerror,
                                      border: OutlineInputBorder(),
                                      hintText: 'Masukan Nama pengguna',
                                    ),
                                    controller: usernameController,
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return 'Nama Tidak boleh Kosong';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.text,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                const Spacer(
                                  flex: 4,
                                ),
                              ]),
                        ),
                        Container(
                          //next input
                          width: 200.w,

                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(20),

                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 38.w,
                                  padding: const EdgeInsets.all(5),
                                  child: const Text(
                                    "Password : ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const Spacer(
                                  flex: 1,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(5),
                                  width: 100.w,
                                  child: TextFormField(
                                    obscureText: pswdvisible,
                                    controller: passwordController,
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return 'Password Tidak boleh Kosong';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      errorText: onerror,
                                      border: const OutlineInputBorder(),
                                      hintText: 'Masukan Password',
                                      suffixIcon: InkWell(
                                        onTap: () => setState(
                                          () => pswdvisible = !pswdvisible,
                                        ),
                                        child: Icon(
                                          pswdvisible
                                              ? Icons.visibility_off_outlined
                                              : Icons.visibility_outlined,
                                          color: Colors.grey.shade400,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                const Spacer(
                                  flex: 4,
                                ),
                              ]),
                        ),
                        Container(
                          //next input
                          width: 200.w,

                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(20),

                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 38.w,
                                  padding: const EdgeInsets.all(5),
                                  child: const Text(
                                    "Kategori User : ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const Spacer(
                                  flex: 1,
                                ),
                                Container(
                                  width: 50.w,
                                  child: DropdownButton(
                                      isExpanded: true,
                                      value: dropdown,
                                      items: const [
                                        DropdownMenuItem(
                                          value: "Admin",
                                          child: Text("Admin"),
                                        ),
                                        DropdownMenuItem(
                                          value: "Supervisor",
                                          child: Text("Supervisor"),
                                        ),
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          dropdown = value.toString();
                                        });
                                      }),
                                ),
                                const Spacer(
                                  flex: 4,
                                ),
                              ]),
                        ),
                        Container(
                          //BUTTON
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(20),

                          child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  BackendlessUser newuser = BackendlessUser()
                                    ..password = passwordController.text;
                                  newuser.setProperty(
                                      'username', usernameController.text);
                                  newuser.setProperty('role', dropdown);
                                  Backendless.userService
                                      .register(newuser)
                                      .then((user) {
                                    final sbarnoticeabsen = SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      duration: Duration(seconds: 4),
                                      content: Text(
                                          "Registrasi Berhasi! ${user?.getProperty("username")} berhasil ditambahkan sebagai ${user?.getProperty("role")}"),
                                      action: SnackBarAction(
                                        label: 'OK',
                                        onPressed: () =>
                                            ScaffoldMessenger.of(context)
                                                .hideCurrentSnackBar(),
                                      ),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(sbarnoticeabsen);
                                    _formKey.currentState!.reset();
                                  }).catchError((onError, stackTrace) {
                                    print(
                                        "There has been an error outside: $onError");
                                    PlatformException platformException =
                                        onError;
                                    print("Server reported an error outside.");
                                    print(
                                        "Exception code: ${platformException.code}");
                                    print(
                                        "Exception details: ${platformException.details}");
                                    print("Stacktrace: $stackTrace");
                                    onerror = platformException.details;
                                    final sbarnoticeabsen = SnackBar(
                                      duration: Duration(seconds: 10),
                                      content: Text(
                                          "telah terjadi sebuah error. ${platformException.details}"),
                                      action: SnackBarAction(
                                        label: 'OK',
                                        onPressed: () =>
                                            ScaffoldMessenger.of(context)
                                                .hideCurrentSnackBar(),
                                      ),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(sbarnoticeabsen);
                                  }, test: (e) => e is PlatformException);
                                }
                              },
                              child: const Text("Tambah User",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                        )
                      ],
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
