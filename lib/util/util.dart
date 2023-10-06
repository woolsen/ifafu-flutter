import 'package:ifafu/util/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class Util {
  static void joinQQGroup({required int groupId}) async {
    final url = Uri.parse('mqqapi://card/show_pslcard?src_type=internal'
        '&version=1&uin=$groupId&card_type=group&source=qrcode');
    if (!await launchUrl(url)) {
      ToastUtil.show('未安装QQ');
    }
  }
}
