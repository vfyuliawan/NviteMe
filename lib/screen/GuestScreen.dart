// ignore_for_file: public_member_api_docs, sort_constructors_first, unnecessary_new
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, sized_box_for_whitespace, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:nvite_me/constans.dart';
import 'package:nvite_me/controller/OurProjectController.dart';
import 'package:nvite_me/model/GuestModel.dart';
import 'package:nvite_me/model/UserIdModel.dart';
import 'package:nvite_me/screen/ListContact.dart';
import 'package:nvite_me/service/WhatsAppService.dart';
import 'package:nvite_me/utils/utils.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class GuestScreen extends StatefulWidget {
  final GuestModel? guests;
  final String slug;
  const GuestScreen({
    Key? key,
    this.guests,
    required this.slug,
  }) : super(key: key);

  @override
  _GuestScreenState createState() => _GuestScreenState();
}

class _GuestScreenState extends State<GuestScreen> {
  late bool loading = false;
  late bool enableApply = true;
  late bool isOpenBalance = true;

  final FlutterContactPicker _contactPicker = new FlutterContactPicker();
  List<Contact>? _contacts;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: !loading
          ? Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor:
                        !enableApply ? Colors.grey : Constans.secondaryColor),
                onPressed: () async {
                  Contact? contact = await _contactPicker.selectContact();
                  setState(() {
                    _contacts = contact == null ? null : [contact];
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.qr_code_2, color: Colors.white),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        'Guest CheckIn',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : null,
      body: loading
          ? Container(
              decoration: BoxDecoration(
                color: Constans.secondaryColor,
              ),
              child: Center(
                child: CircularProgressIndicator(
                  color: Constans.fourthColor,
                ),
              ),
            )
          : Column(
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 300,
                          decoration: BoxDecoration(
                            color: Constans.secondaryColor,
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                            margin: const EdgeInsets.only(top: 35),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    child: const Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const Text(
                                  "Guest Book",
                                  style: TextStyle(
                                    fontFamily: 'Pacifico',
                                    fontWeight: FontWeight.w200,
                                    fontSize: 25,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height - 150,
                          margin: const EdgeInsets.only(top: 80),
                          decoration: BoxDecoration(
                              color: Constans.thirdColor,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                              )),
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(top: 0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 12,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Balance",
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontFamily: 'Pacifico',
                                            color: Constans.textColor,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => setState(() {
                                          isOpenBalance = !isOpenBalance;
                                        }),
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          child: !isOpenBalance
                                              ? Icon(
                                                  Icons.keyboard_arrow_left,
                                                  size: 28,
                                                  color: Constans.textColor,
                                                )
                                              : Icon(
                                                  Icons.keyboard_arrow_down,
                                                  size: 28,
                                                  color: Constans.textColor,
                                                ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                isOpenBalance
                                    ? balanceDashboard()
                                    : Container(),
                                Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  height: widget.guests!.guest!.length < 3
                                      ? MediaQuery.of(context).size.height
                                      : null,
                                  decoration: BoxDecoration(
                                      color: Constans.fourthColor,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        topRight: Radius.circular(25),
                                      )),
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 4),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                    padding: EdgeInsets.only(
                                                        left: 8),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "List Tamu",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                      ),
                                                    )),
                                                GestureDetector(
                                                  onTap: () => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (_) =>
                                                          ListContact(
                                                        slug: widget.slug,
                                                        guest: widget.guests!,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Container(
                                                    height: 40,
                                                    width: 40,
                                                    child: Icon(
                                                      Icons.add_call,
                                                      size: 28,
                                                      color: Colors.white,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Constans
                                                          .secondaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          _listGuestBody(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 90, right: 20),
                          alignment: Alignment.centerRight,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  Widget _listContact() {
    print(_contacts);
    return _contacts != null && _contacts!.isNotEmpty
        ? Container(
            height: 100, // Adjust the height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _contacts!.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      SizedBox(height: 5),
                      Text(_contacts![index].fullName!),
                    ],
                  ),
                );
              },
            ),
          )
        : Container();
  }

  Widget _listGuestBody() {
    return StreamBuilder<UserIdModel>(
      stream: OurProjectController().getData(widget.slug),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("Error Ditemukan"),
          );
        } else if (snapshot.data == null) {
          return const Center(
            child: Text("Tidak Ada Data"),
          );
        } else {
          final dataGuest = snapshot.data!.guest!.guest;
          return Column(
            children: dataGuest!
                .map(
                  (
                    item,
                  ) =>
                      Card(
                    color: Constans.fourthColor,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(8),
                      title: Text(
                        item.name!,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Constans.textColor,
                        ),
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.phone!,
                            style: TextStyle(
                              fontSize: 15,
                              color: Constans.textColor,
                            ),
                          ),
                          Row(
                            children: [
                              Card(
                                color: item.attendance!
                                    ? Colors.green
                                    : Colors.red,
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    item.attendance!
                                        ? "Sudah Checkin"
                                        : "Blum Checkin",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                color: item.share ? Colors.green : Colors.red,
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    item.share ? "Shared" : "NotShare",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: GestureDetector(
                        onTap: () async {
                          await WhatsAppService()
                              .openWhatsAppChat(
                            Utility().removeSpaces(item.phone!),
                            '${Constans.baseUrlDeploy}${widget.slug}',
                            item.name!,
                            item.guestId!,
                          )
                              .then((value) {
                            if (value) {
                              //edit share
                              Alert(
                                context: context,
                                type: AlertType.success,
                                title: "Akan Dialihkan ke whatsapp",
                                style: AlertStyle(
                                  titleStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  descStyle: TextStyle(fontSize: 16),
                                ),
                                desc:
                                    "Kirim undangan ke tamu anda via whatsapp.",
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "Oke",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      // Navigator.pop(context);
                                    },
                                    width: 120,
                                  )
                                ],
                              ).show();
                            }
                          });
                        },
                        child: Icon(
                          Icons.share,
                          color: Constans.textColor,
                          size: 30,
                        ),
                      ),
                      leading: Container(
                        alignment: Alignment.center,
                        height: 60,
                        width: 60,
                        child: Text(
                          "C",
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: item.attendance! ? Colors.green : Colors.red,
                          borderRadius: BorderRadius.circular(
                            30,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          );
        }
      },
    );
  }

  Widget balanceDashboard() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 55,
                    width: 55,
                    margin: EdgeInsets.only(left: 8),
                    child: Image.asset(
                      "assets/icons/present.png",
                      fit: BoxFit.cover,
                      width: 20,
                      height: 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        30,
                      ),
                      color: Constans.thirdColor,
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(
                      left: 5,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Guest",
                          style: TextStyle(
                              color: Constans.thirdColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Roboto"),
                        ),
                        Text(
                          "200",
                          style: TextStyle(
                            color: Constans.thirdColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Roboto",
                          ),
                        ),
                      ],
                    ),
                  ))
                ],
              ),
              width: 180,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                color: Constans.secondaryColor,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: 180,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                color: Constans.seventh,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 55,
                    width: 55,
                    child: Image.asset("assets/icons/allUser.png",
                        fit: BoxFit.cover),
                    margin: EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        30,
                      ),
                      color: Constans.thirdColor,
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(
                      left: 5,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Guest Present",
                          style: TextStyle(
                              color: Constans.thirdColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Roboto"),
                        ),
                        Text(
                          "20",
                          style: TextStyle(
                            color: Constans.thirdColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Roboto",
                          ),
                        ),
                      ],
                    ),
                  ))
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 180,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(0),
                ),
                color: Constans.seventh,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 55,
                    width: 55,
                    margin: EdgeInsets.only(left: 8),
                    child: Image.asset("assets/icons/notCome.png",
                        fit: BoxFit.cover),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        30,
                      ),
                      color: Constans.thirdColor,
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(
                      left: 5,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Not Came",
                          style: TextStyle(
                              color: Constans.thirdColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Roboto"),
                        ),
                        Text(
                          "20",
                          style: TextStyle(
                            color: Constans.thirdColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Roboto",
                          ),
                        ),
                      ],
                    ),
                  ))
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: 180,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(30),
                ),
                color: Constans.secondaryColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 55,
                    width: 55,
                    margin: EdgeInsets.only(left: 8),
                    child: Image.asset("assets/icons/difference.png",
                        fit: BoxFit.cover),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        30,
                      ),
                      color: Constans.thirdColor,
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(
                      left: 5,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Difference",
                          style: TextStyle(
                              color: Constans.thirdColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Roboto"),
                        ),
                        Text(
                          "20",
                          style: TextStyle(
                            color: Constans.thirdColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Roboto",
                          ),
                        ),
                      ],
                    ),
                  ))
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
