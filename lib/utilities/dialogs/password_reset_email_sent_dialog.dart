import 'package:flutter/material.dart';

import 'generic_dialog.dart';

Future<void> showPassworResetSentDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: 'Password Reset',
    content:
        'We have send you email for password reset please visit email for more information',
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
