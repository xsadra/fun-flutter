import 'package:flutter/material.dart';
import 'package:picogram/views/components/rich_text/rich_text_widget.dart';
import 'package:picogram/views/contsnts/strings.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/rich_text/base_text.dart';

class LoginViewSignupLink extends StatelessWidget {
  const LoginViewSignupLink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichTextWidget(
      styleForAll: Theme.of(context).textTheme.subtitle1?.copyWith(
            height: 1.5,
          ),
      children: [
        BaseText.plain(text: Strings.doNotHaveAnAccount),
        BaseText.plain(text: Strings.signUpOn),
        BaseText.link(
          text: Strings.facebook,
          onTapped: () {
            launchUrl(
              Uri.parse(Strings.facebookSignupUrl),
            );
          },
        ),
        BaseText.plain(text: Strings.orCreateAnAccountOn),
        BaseText.link(
          text: Strings.google,
          onTapped: () {
            launchUrl(
              Uri.parse(Strings.googleSignupUrl),
            );
          },
        ),
      ],
    );
  }
}
