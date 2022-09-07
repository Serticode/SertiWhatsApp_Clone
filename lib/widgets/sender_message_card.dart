import 'package:flutter/material.dart';
import 'package:serti_whatsapp_clone/themes/theme.dart';
import 'package:serti_whatsapp_clone/utils/app_screen_utils.dart';

class SenderMessageCard extends StatelessWidget {
  const SenderMessageCard({
    Key? key,
    required this.message,
    required this.date,
  }) : super(key: key);
  final String message;
  final String date;

  @override
  Widget build(BuildContext context) => Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              color: AppColours.senderMessageColor,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Padding(
                  padding: AppScreenUtils.appChatPadding,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //! THE MESSAGE
                        Text(message,
                            overflow: TextOverflow.visible,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 16.0)),

                        //! SPACER
                        const SizedBox(height: 10),

                        //! DATE
                        Text(date,
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColours.textColor.withOpacity(0.7)))
                      ])))));
}
