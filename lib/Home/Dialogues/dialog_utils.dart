import 'package:flutter/material.dart';
import 'package:to_do_application/my_theme.dart';

class DialogUtils {
  static void Loading(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              children: [
                const CircularProgressIndicator(),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  'Loading...',
                  style: Theme.of(context)!
                      .textTheme
                      .titleLarge!
                      .copyWith(color: MyTheme.darkBlackColor),
                ),
              ],
            ),
          );
        });
  }

  static void showMessage(BuildContext context, {required String message}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              message,
              style: Theme.of(context)!
                  .textTheme
                  .titleLarge!
                  .copyWith(color: MyTheme.darkBlackColor),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    hideDialog(context);
                  },
                  child: Text(
                    'OK',
                    style: Theme.of(context)!
                        .textTheme
                        .titleLarge!
                        .copyWith(color: MyTheme.darkBlackColor),
                  ))
            ],
          );
        });
  }

  static void hideDialog(BuildContext context) {
    Navigator.pop(context);
  }
}
