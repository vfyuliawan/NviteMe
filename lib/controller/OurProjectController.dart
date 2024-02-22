// ignore_for_file: avoid_print, unused_local_variable, unnecessary_cast

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:nvite_me/model/CountDownModel.dart';
import 'package:nvite_me/model/CoverModel.dart';
import 'package:nvite_me/model/GiftsModel.dart';
import 'package:nvite_me/model/GuestModel.dart';
import 'package:nvite_me/model/HeroModel.dart';
import 'package:nvite_me/model/HomeModel.dart';
import 'package:nvite_me/model/InfoAcaraModel.dart';
import 'package:nvite_me/model/MaleFemaleModel.dart';
import 'package:nvite_me/model/OurStoryModel.dart';
import 'package:nvite_me/model/UserIdModel.dart';
import 'package:nvite_me/utils/utils.dart';
import 'package:path/path.dart';

class OurProjectController {
  Stream<List<UserIdModel>> getAlldata(String uid) {
    try {
      return FirebaseFirestore.instance
          .collection("UserId")
          .where("uid", isEqualTo: uid)
          .snapshots()
          .map((querySnapshot) {
        return querySnapshot.docs.map((documentSnapshot) {
          Map<String, dynamic> data =
              documentSnapshot.data() as Map<String, dynamic>;
          print(UserIdModel.fromJson(data).guest);
          return UserIdModel.fromJson(data);
        }).toList();
      });
    } catch (e) {
      print(e.toString());
      return Stream.value([]);
    }
  }

  Stream<UserIdModel> getData(String slug) {
    try {
      return FirebaseFirestore.instance
          .collection("UserId")
          .where("Slug", isEqualTo: slug)
          .limit(1)
          .snapshots()
          .map((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          Map<String, dynamic> data =
              querySnapshot.docs.first.data() as Map<String, dynamic>;
          return UserIdModel.fromJson(data);
        }
        return UserIdModel();
      });
    } catch (e) {
      print(e.toString());
      return const Stream.empty();
    }
  }

  Future<bool> editTheme({
    String? themeName,
    required String slug,
    required String song,
    required String embeded,
    required bool guestBarcode,
  }) async {
    try {
      QuerySnapshot userQuery = await FirebaseFirestore.instance
          .collection("UserId")
          .where("Slug", isEqualTo: slug)
          .get();

      if (userQuery.docs.isNotEmpty) {
        DocumentReference documentReference = userQuery.docs.first.reference;
        await documentReference.update({
          'ThemeName': themeName!,
          'Slug': slug,
          "ThemeSong": song,
          "GuestBarcode": guestBarcode,
          "Embeded": embeded
        });
        return true;
      } else {
        print(slug);
        return false;
      }
    } on FirebaseException catch (e, stackTrace) {
      print(e.toString());
      print('Error: $e');
      print('Stack Trace: $stackTrace');
      return false;
    }
  }

  Future<bool> editCover({CoverModel? params, required String slug}) async {
    try {
      String imageUrl;
      if (params!.imgFileCover != null) {
        final fileName = basename(params.imgFileCover!.path);
        final path = 'files/$fileName}';
        final file = File(params.imgFileCover!.path);
        final ref = await FirebaseStorage.instance.ref().child(path);
        final uploadTask = ref.putFile(file);
        final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
        imageUrl = await taskSnapshot.ref.getDownloadURL();
      } else {
        imageUrl = params.imgCover!;
      }

      QuerySnapshot userQuery = await FirebaseFirestore.instance
          .collection("UserId")
          .where("Slug", isEqualTo: slug)
          .get();

      if (userQuery.docs.isNotEmpty) {
        DocumentReference documentReference = userQuery.docs.first.reference;
        await documentReference.update({
          'Cover': {
            "ImgCover": await imageUrl,
            "Visible": params.visible,
            "TitleCover": params.titleCover,
            "Date": params.date
          }
        });
        return true;
      } else {
        print(slug);
        return false;
      }
    } on FirebaseException catch (e, stackTrace) {
      print(e.toString());
      print('Error: $e');
      print('Stack Trace: $stackTrace');
      return false;
    }
  }

  Future<bool> editHome({HomeModel? params, required String slug}) async {
    try {
      String imageUrl;
      if (params!.homeImgFile != null) {
        final fileName = basename(params.homeImgFile!.path);
        final path = 'files/$fileName}';
        final file = File(params.homeImgFile!.path);
        final ref = await FirebaseStorage.instance.ref().child(path);
        final uploadTask = ref.putFile(file);
        final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
        imageUrl = await taskSnapshot.ref.getDownloadURL();
      } else {
        imageUrl = params.homeImg!;
      }

      QuerySnapshot userQuery = await FirebaseFirestore.instance
          .collection("UserId")
          .where("Slug", isEqualTo: slug)
          .get();

      if (userQuery.docs.isNotEmpty) {
        DocumentReference documentReference = userQuery.docs.first.reference;
        await documentReference.update({
          'Home': {
            "HomeImg": imageUrl,
            "HomeQuotes": params.homeQuotes,
            "HomeTittle": params.homeTittle,
            "Visible": params.visible,
          }
        });
        return true;
      } else {
        print('No or multiple users found with Slug "Debby-Surya".');
        return false;
      }
    } on FirebaseException catch (e, stackTrace) {
      print(e.toString());
      print('Error: $e');
      print('Stack Trace: $stackTrace');
      return false;
    }
  }

  Future<bool> editHero({HeroModel? params, required String slug}) async {
    try {
      String imageUrl;
      if (params!.heroImgFile != null) {
        final fileName = basename(params.heroImgFile!.path);
        final path = 'files/$fileName}';
        final file = File(params.heroImgFile!.path);
        final ref = await FirebaseStorage.instance.ref().child(path);
        final uploadTask = ref.putFile(file);
        final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
        imageUrl = await taskSnapshot.ref.getDownloadURL();
      } else {
        imageUrl = params.heroImg!;
      }
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("UserId")
          .where("Slug", isEqualTo: slug)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference documentReference =
            querySnapshot.docs.first.reference;
        await documentReference.update(
          {
            'Hero': {
              "HeroDate": params.heroDate,
              "HeroImg": imageUrl,
              "HeroTittle": params.heroTittle,
              "Visible": params.visible,
            },
          },
        );
        return true;
      } else {
        print("Slug tidak ditemukan");
        return false;
      }
    } catch (e, stackTrace) {
      print(e.toString());
      print('Error: $e');
      print('Stack Trace: $stackTrace');
      return false;
    }
  }

  Future<bool> editInfoAcara({
    List<InfoAcaraElement>? params,
    required String slug,
    required int index,
  }) async {
    try {
      for (var item in params!) {
        String imageUrl;
        if (item.photoFile != null) {
          final fileName = basename(item.photoFile!.path);
          final path = 'files/$fileName}';
          String oldPath = Uri.decodeFull(Uri.parse(item.oldPhoto!).path);
          final file = File(item.photoFile!.path);
          final ref = FirebaseStorage.instance.ref().child(path);
          final oldPathConvert = Utility().extractPathFromUrl(oldPath);
          final oldRef = FirebaseStorage.instance.ref().child(oldPathConvert);
          await oldRef.delete();
          final uploadTask = ref.putFile(file);
          final TaskSnapshot taskSnapshot =
              await uploadTask.whenComplete(() {});
          imageUrl = await taskSnapshot.ref.getDownloadURL();
        } else {
          imageUrl = item.photo!;
        }
        item.photo = imageUrl;
      }

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("UserId")
          .where("Slug", isEqualTo: slug)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference documentReference =
            querySnapshot.docs.first.reference;
        await documentReference.update(
            {'InfoAcara': params.map((item) => item.toJson()).toList()});
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  Future<String> editPhoto(
      File? photoFile, MaleFemaleModel params, String gender) async {
    try {
      String photoUrl;
      if (photoFile != null) {
        final fileName = basename(photoFile.path);
        final neWpath = 'files/$fileName}';
        String oldPath = Uri.decodeFull(Uri.parse(gender == "Female"
                ? params.female!.oldPhoto!
                : params.male!.oldPhoto!)
            .path);

        final oldPathConvert = Utility().extractPathFromUrl(oldPath);
        final file = File(photoFile.path);
        final oldRef = FirebaseStorage.instance.ref().child(oldPathConvert);
        final ref = FirebaseStorage.instance.ref().child(neWpath);
        await oldRef.delete();
        final uploadTask = ref.putFile(file);
        final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
        return photoUrl = await taskSnapshot.ref.getDownloadURL();
      } else {
        return photoUrl =
            gender == "Female" ? params.female!.photo! : params.male!.photo!;
      }
    } catch (e) {
      print(e);
      return "";
    }
  }

  Future<bool> editMaleFemale(
      {MaleFemaleModel? params, required String slug}) async {
    try {
      final photoMaleUrl =
          await editPhoto(params!.male!.photoFile, params, "Male");
      final photoFemaleUrl =
          await editPhoto(params.female!.photoFile, params, "Female");

      params.male!.photo = photoMaleUrl;
      params.female!.photo = photoFemaleUrl;

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("UserId")
          .where("Slug", isEqualTo: slug)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference documentReference =
            querySnapshot.docs.first.reference;
        await documentReference.update(
          {
            'MaleFemale': {
              'Male': params.male!.toJson(),
              'Female': params.female!.toJson(),
              'Visible': params.visible
            }
          },
        );
        return true;
      } else {
        print("Slug tidak ditemukan");
        return false;
      }
    } catch (e, stackTrace) {
      print(e.toString());
      print('Error: $e');
      print('Stack Trace: $stackTrace');
      return false;
    }
  }

  Future<String> editPhotoStory(
      File? photoFile, OurStoryModel params, String story) async {
    try {
      String photoUrl;
      if (photoFile != null) {
        final fileName = basename(photoFile.path);
        final neWpath = 'files/$fileName}';
        String oldPath = Uri.decodeFull(Uri.parse(story == "First"
                ? params.first!.photoOld!
                : story == "Second"
                    ? params.second!.photoOld!
                    : params.third!.photoOld!)
            .path);

        final oldPathConvert = Utility().extractPathFromUrl(oldPath);
        final file = File(photoFile.path);
        final oldRef = FirebaseStorage.instance.ref().child(oldPathConvert);
        final ref = FirebaseStorage.instance.ref().child(neWpath);
        await oldRef.delete();
        final uploadTask = ref.putFile(file);
        final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
        return photoUrl = await taskSnapshot.ref.getDownloadURL();
      } else {
        return photoUrl = story == "First"
            ? params.first!.photoOld!
            : story == "Second"
                ? params.second!.photoOld!
                : params.third!.photoOld!;
      }
    } catch (e) {
      print(e);
      return "";
    }
  }

  Future<bool> editOurStory(
      {OurStoryModel? params, required String slug}) async {
    try {
      final photoFirst =
          await editPhotoStory(params!.first!.photoFile, params, "First");
      final photoSecond =
          await editPhotoStory(params.second!.photoFile, params, "Second");
      final photoThird =
          await editPhotoStory(params.second!.photoFile, params, "Third");

      params.first!.photo = photoFirst;
      params.second!.photo = photoSecond;
      params.third!.photo = photoThird;

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("UserId")
          .where("Slug", isEqualTo: slug)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference documentReference =
            querySnapshot.docs.first.reference;
        await documentReference.update(
          {
            'OurStory': {
              'First': params.first!.toJson(),
              'Second': params.second!.toJson(),
              'Third': params.third!.toJson(),
              'Visible': params.visible
            }
          },
        );
        return true;
      } else {
        print("Slug tidak ditemukan");
        return false;
      }
    } catch (e, stackTrace) {
      print(e.toString());
      print('Error: $e');
      print('Stack Trace: $stackTrace');
      return false;
    }
  }

  Future<bool> uploadImageGalery(File imageFile, String slug) async {
    try {
      final fileName = basename(imageFile.path);
      final path = 'files/$fileName}';
      final storageReference = FirebaseStorage.instance.ref().child(path);
      UploadTask uploadTask = storageReference.putFile(imageFile);
      await uploadTask.whenComplete(() => print('Image uploaded'));
      String imageUrl = await storageReference.getDownloadURL();
      if (imageUrl != "") {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection("UserId")
            .where("Slug", isEqualTo: slug)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          DocumentReference documentReference =
              querySnapshot.docs.first.reference;
          await documentReference.update({
            'Galery.image': FieldValue.arrayUnion([imageUrl]),
          });
          return true;
        } else {
          return false;
        }
      } else {
        print("Image url is $imageUrl");
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteGaleryImage(String imageUrl, String slug) async {
    try {
      String oldPath = Uri.decodeFull(Uri.parse(imageUrl).path);
      final oldPathConvert = Utility().extractPathFromUrl(oldPath);
      final oldRef = FirebaseStorage.instance.ref().child(oldPathConvert);
      await oldRef.delete();
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("UserId")
          .where("Slug", isEqualTo: slug)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference documentReference =
            querySnapshot.docs.first.reference;
        await documentReference.update({
          'Galery.image': FieldValue.arrayRemove([imageUrl]),
        });
        return true;
      } else {
        print("Document not found");
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> editGifts({
    GiftstModel? params,
    required String slug,
  }) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("UserId")
          .where("Slug", isEqualTo: slug)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference documentReference =
            querySnapshot.docs.first.reference;
        await documentReference.update(
          {'Gifts': params!.toJson()},
        );
        return true;
      } else {
        print("Slug tidak ditemukan");
        return false;
      }
    } catch (e, stackTrace) {
      print(e.toString());
      print('Error: $e');
      print('Stack Trace: $stackTrace');
      return false;
    }
  }

  Future<bool> editCountDown(
      {CountDownModel? params, required String slug}) async {
    try {
      QuerySnapshot userQuery = await FirebaseFirestore.instance
          .collection("UserId")
          .where("Slug", isEqualTo: slug)
          .get();

      if (userQuery.docs.isNotEmpty) {
        DocumentReference documentReference = userQuery.docs.first.reference;
        await documentReference.update({'CountDown': params!.toJson()});
        return true;
      } else {
        print(slug);
        return false;
      }
    } on FirebaseException catch (e, stackTrace) {
      print(e.toString());
      print('Error: $e');
      print('Stack Trace: $stackTrace');
      return false;
    }
  }

  Future<bool> addGuest({
    List<Contact>? params,
    GuestModel? guest,
    required String slug,
  }) async {
    try {
      QuerySnapshot userQuery = await FirebaseFirestore.instance
          .collection("UserId")
          .where("Slug", isEqualTo: slug)
          .get();

      if (userQuery.docs.isNotEmpty) {
        final String? guestId = guest?.guest?.isNotEmpty == true
            ? guest!.guest!.last.guestId
            : null;

        if (guestId != null) {
          final contactToGuest = params!.asMap().entries.map((entry) {
            final index = entry.key;
            final e = entry.value;
            return GuestModelKeyValue(
              attendance: false,
              share: false,
              guestId: (int.parse(guestId) + index + 1).toString(),
              name: e.fullName,
              phone: e.phoneNumbers?.first ?? "",
            );
          }).toList();

          DocumentReference documentReference = userQuery.docs.first.reference;
          await documentReference.update({
            'Guest': FieldValue.arrayUnion(
                contactToGuest.map((guest) => guest.toJson()).toList()),
          });
          return true;
        } else {
          print('GuestId is null');
          return false;
        }
      } else {
        print(slug);
        return false;
      }
    } on FirebaseException catch (e, stackTrace) {
      Utility.logger.e(e.toString());
      Utility.logger.e('Error: $e');
      Utility.logger.e('Stack Trace: $stackTrace');
      return false;
    }
  }

  Future<bool> updateSharing(
      String slug, GuestModelKeyValue params, GuestModel currentDate) async {
    try {
      QuerySnapshot userQuery = await FirebaseFirestore.instance
          .collection("UserId")
          .where("Slug", isEqualTo: slug)
          .get();

      if (userQuery.docs.isNotEmpty) {
        List<dynamic> existingGuestArray = userQuery.docs.first['Guest'];
        existingGuestArray
            .removeWhere((guest) => guest['GuestId'] == params.guestId);
        existingGuestArray.add({
          'GuestId': params.guestId,
          'Share': true,
          'Attend': params.attendance,
          'Name': params.name,
          'Phone': params.phone,
        });

        DocumentReference documentReference = userQuery.docs.first.reference;
        await documentReference.update({
          'Guest': existingGuestArray,
        });

        return true;
      } else {
        return false;
      }
    } catch (e) {
      Utility.logger.e(e);
      return false;
    }
  }

  void updateAttend(
      String slug, GuestModelKeyValue params, GuestModel currentDate) async {
    try {
      QuerySnapshot userQuery = await FirebaseFirestore.instance
          .collection("UserId")
          .where("Slug", isEqualTo: slug)
          .get();

      if (userQuery.docs.isNotEmpty) {
        List<dynamic> existingGuestArray = userQuery.docs.first['Guest'];
        existingGuestArray
            .removeWhere((guest) => guest['GuestId'] == params.guestId);
        existingGuestArray.add({
          'GuestId': params.guestId,
          'Share': true,
          'Attend': params.attendance,
          'Name': params.name,
          'Phone': params.phone,
        });

        DocumentReference documentReference = userQuery.docs.first.reference;
        await documentReference.update({
          'Guest': existingGuestArray,
        });
      }
    } catch (e) {
      Utility.logger.e(e);
    }
  }
}
