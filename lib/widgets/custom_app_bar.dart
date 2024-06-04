import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAppBar extends StatelessWidget {
  final bool isBackArrow;
  const CustomAppBar({
    Key? key,
    this.isBackArrow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            isBackArrow
                ? GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(19, 0, 21, 0),
                      child: SvgPicture.asset(
                        'lib/assets/images/back_arrow.svg',
                        width: 10,
                      ),
                    ),
                  )
                : const SizedBox(width: 50),
            Padding(
                padding: const EdgeInsets.only(top: 3, left: 80),
                child: _buildLogo(text: AppConfig.companyName)),
            Expanded(
              child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: IconButton(
                onPressed: () async {
                  final Uri url = Uri.parse('https://brightclean.taplink.ws');
                  if (await canLaunchUrl(url)) {
                    await launchUrl(
                      url,
                    );
                  }
                },
                icon: Image.asset('lib/assets/images/chat.png',
                width: 35,
                height: 35),
              ),
            ), ),
           
          ],
        ),
      ),
    );
  }

  Widget _buildLogo({required String text}) {
    var textList = text.split(' ');
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: '${textList[0]} ',
            style: const TextStyle(
              fontSize: 20,
              color: AppConfig.blueColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(
            text: textList[1],
            style: const TextStyle(
              fontSize: 20,
              color: AppConfig.blackColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
