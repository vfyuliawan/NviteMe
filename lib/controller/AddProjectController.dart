import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nvite_me/controller/AuthController.dart';
import 'package:nvite_me/model/UserIdModel.dart';
import 'package:nvite_me/model/UserLoginModel.dart';
import 'package:path/path.dart';

class AddProjectController {
  Future<String> uploadImageToStorage(File imageFile, String slug) async {
    try {
      final fileName = basename(imageFile.path);
      final path = 'files/$slug/$fileName}';
      final file = File(imageFile.path);
      final ref = await FirebaseStorage.instance.ref().child(path);
      final uploadTask = ref.putFile(file);
      final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print('Error uploading image: $e');
      throw e;
    }
  }

  Future<bool> uploadDataToFirestore(UserIdModel userData) async {
    try {
      await AuthController().getUserInfo().then((UserLoginModel userModel) {
        userData.uid = userModel.uid;
      });

      userData.cover!.imgCover = await uploadImageToStorage(
          userData.cover!.imgFileCover!, userData.slug!);
      userData.home!.homeImg = await uploadImageToStorage(
          userData.home!.homeImgFile!, userData.slug!);
      userData.hero!.heroImg = await uploadImageToStorage(
          userData.hero!.heroImgFile!, userData.slug!);
      userData.maleFemale!.female!.photo = await uploadImageToStorage(
          userData.maleFemale!.female!.photoFile!, userData.slug!);
      userData.maleFemale!.male!.photo = await uploadImageToStorage(
          userData.maleFemale!.male!.photoFile!, userData.slug!);
      userData.infoAcara!.infoAcara!.map((item) async {
        item.photo =
            await uploadImageToStorage(item.photoFile!, userData.slug!);
      }).toList();
      userData.ourStory!.first!.photo = await uploadImageToStorage(
          userData.ourStory!.first!.photoFile!, userData.slug!);
      userData.ourStory!.second!.photo = await uploadImageToStorage(
          userData.ourStory!.second!.photoFile!, userData.slug!);
      userData.ourStory!.third!.photo = await uploadImageToStorage(
          userData.ourStory!.third!.photoFile!, userData.slug!);
      userData.galery!.image =
          await Future.wait(userData.galery!.imageFile!.map((imageFile) {
        return uploadImageToStorage(imageFile, userData.slug!);
      }));
      userData.footer!.image = await uploadImageToStorage(
          userData.cover!.imgFileCover!, userData.slug!);
      userData.footer!.name = userData.cover!.titleCover;
      userData.footer!.qutes =
          "Merupakan suatu kehormatan dan kebahagiaan bagi kami, apabila Bapak/Ibu/Saudara/i berkenan hadir dan memberikan doa restu. Atas kehadiran dan doa restunya, kami mengucapkan terima kasih";
      await FirebaseFirestore.instance
          .collection('UserId')
          .add(userData.toJson());
      print(userData.infoAcara!.toJson().toString());

      return true;
    } catch (e) {
      print('Error uploading data: $e');
      return false;
    }
  }
}
