// ignore_for_file: public_member_api_docs, sort_constructors_first, unnecessary_new
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, sized_box_for_whitespace, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:nvite_me/constans.dart';
import 'package:nvite_me/controller/OurProjectController.dart';
import 'package:nvite_me/model/GuestModel.dart';
import 'package:nvite_me/model/UserIdModel.dart';
import 'package:nvite_me/screen/ListContact.dart';
import 'package:nvite_me/service/WhatsAppService.dart';
import 'package:nvite_me/utils/utils.dart';
import 'package:nvite_me/widgets/DropDownButton.dart';
import 'package:nvite_me/widgets/NoDataFound.dart';

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

  // final FlutterContactPicker _contactPicker = new FlutterContactPicker();
  List<Contact>? _contacts;
  String _scanBarcode = 'Unknown';
  final List<String> listDropDown = [
    'All',
    'Belum Checkin',
    'Checkin',
    'Shared',
    'Not Shared',
  ];
  String? selectedValue;

  @override
  void initState() {
    super.initState();
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    // if (!mounted) return;
    OurProjectController()
        .scanBarcodeUpdateAttend(
      widget.slug,
      barcodeScanRes.split("nviteMe")[1],
      widget.guests!,
    )
        .then((value) {
      if (value["update"]) {
        Utility().themeAlert(
            context: context,
            title: "${value["user"]} Berhasil Checkin",
            subtitle: "Dipersilakan Masuk",
            callback: () {
              Navigator.pop(context);
            });
      } else {
        Utility().themeAlert(
            context: context,
            isError: true,
            title: "Tamu Tidak Ditemukan",
            subtitle: "Priksa Kembali E-Ticket",
            callback: () {
              Navigator.pop(context);
            });
      }
    });
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
                  scanQR();
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
                                  height: widget.guests!.guest!.length < 4
                                      ? MediaQuery.of(context).size.height - 300
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
                                                DropDownButton(
                                                  listItem: listDropDown,
                                                  setValue: (value) {
                                                    setState(() {
                                                      selectedValue = value;
                                                    });
                                                  },
                                                ),
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
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                    ),
                                                    height: 40,
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "Import from Contact",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        Icon(
                                                          Icons.add_call,
                                                          size: 18,
                                                          color: Colors.white,
                                                        ),
                                                      ],
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
                                          Container(
                                            padding: EdgeInsets.only(left: 8),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "List Tamu",
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
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
          final dataGuest = snapshot.data!.guest!.guest!.where((element) {
            if (selectedValue == "Belum Checkin") {
              return element.attendance == false;
            } else if (selectedValue == "Checkin") {
              return element.attendance == true;
            } else if (selectedValue == "Shared") {
              return element.share == true;
            } else if (selectedValue == "Not Shared") {
              return element.share == false;
            } else {
              return true;
            }
          });
          return dataGuest.isEmpty
              ? NoDataFoundWidget()
              : Column(
                  children: dataGuest
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
                                      color: item.share
                                          ? Colors.green
                                          : Colors.red,
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
                                Utility().themeAlert(
                                  context: context,
                                  title: "Akan Dialihkan ke whatsapp",
                                  subtitle:
                                      "Kirim undangan ke tamu anda via whatsapp",
                                  callback: () async {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    await WhatsAppService()
                                        .openWhatsAppChat(
                                      Utility().removeSpaces(item.phone!),
                                      '${Constans.baseUrlDeploy}${widget.slug}',
                                      item.name!,
                                      item.guestId!,
                                    )
                                        .then((value) {
                                      if (value) {
                                        OurProjectController().updateSharing(
                                            widget.slug, item, widget.guests!);
                                      }
                                    });
                                  },
                                );
                              },
                              child: Image.asset(
                                "assets/icons/whatsapp.png",
                                width: 30,
                                height: 30,
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
                                color: item.attendance!
                                    ? Colors.green
                                    : Colors.red,
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
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Roboto"),
                        ),
                        Text(
                          "200",
                          style: TextStyle(
                            color: Constans.thirdColor,
                            fontSize: 14,
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
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Roboto"),
                        ),
                        Text(
                          "20",
                          style: TextStyle(
                            color: Constans.thirdColor,
                            fontSize: 14,
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
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Roboto"),
                        ),
                        Text(
                          "20",
                          style: TextStyle(
                            color: Constans.thirdColor,
                            fontSize: 14,
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
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Roboto"),
                        ),
                        Text(
                          "20",
                          style: TextStyle(
                            color: Constans.thirdColor,
                            fontSize: 14,
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
