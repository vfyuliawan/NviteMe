import 'package:nvite_me/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppService {
  Future<bool> openWhatsAppChat(
      String phoneNumber, String webUrl, String name, String guestId) async {
    String shareUrl = '$webUrl&to=${name.replaceAll(" ", "%20")}&id=$guestId';
    String encodedWeddingUrl = Uri.encodeComponent(shareUrl);
    String message =
        "Melalui pesan ini kami ingin menyampaikan sebuah kabar bahagia. Turut mengundang ke acara pernikahan kami: $encodedWeddingUrl";
    String url = "https://wa.me/$phoneNumber/?text=$message";
    if (await canLaunch(url)) {
      await launch(url);
      return true;
    } else {
      Utility.logger.e('gagal launch $url');
      return false;
    }
  }
}
