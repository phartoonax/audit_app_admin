// ignore_for_file: camel_case_types

import 'package:audit_app_admin/Project/tambahproyek.dart';
import 'package:audit_app_admin/User/tambahuser.dart';
import 'package:audit_app_admin/mainmenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SliderContent extends StatefulWidget {
  const SliderContent({super.key, required this.selector});
  final int selector;

  @override
  State<SliderContent> createState() => _SliderContentState();
}

class _SliderContentState extends State<SliderContent> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          height: 100.h,
          decoration: const BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
          child: const Center(
            //profile sliderdrawer
            child: Text(
              'Profile',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        Container(
            padding:
                const EdgeInsets.only(left: 10, right: 10, bottom: 15, top: 5),
            child: Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ListTile(
                selected: widget.selector == 1 ? true : false,
                title: const Text("Main menu"),
                onTap: () {
                  setState(() {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyHomePage()));
                    });
                  });
                },
              ),
            )),
        Container(
            padding:
                const EdgeInsets.only(left: 10, right: 10, bottom: 15, top: 5),
            child: Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(title: const Text("Proyek"), children: [
                ListTile(
                  selected: widget.selector == 2 ? true : false,
                  title: const Text("Daftar Proyek"),
                  onTap: () {},
                ),
                ListTile(
                  selected: widget.selector == 3 ? true : false,
                  title: const Text("Tambah Proyek"),
                  onTap: () {
                    setState(() {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TambahProyek()));
                      });
                    });},
                ),
              ]),
            )),
        Container(
            padding:
                const EdgeInsets.only(left: 10, right: 10, bottom: 15, top: 5),
            child: Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(title: const Text("User"), children: [
                ListTile(
                  selected: widget.selector == 4 ? true : false,
                  title: const Text("Daftar user"),
                  onTap: () {},
                ),
                ListTile(
                  selected: widget.selector == 5 ? true : false,
                  title: const Text("Tambah User"),
                  onTap: () {
                    setState(() {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TambahUser()));
                      });
                    });
                  },
                ),
              ]),
            ))
      ],
    );
  }
}
