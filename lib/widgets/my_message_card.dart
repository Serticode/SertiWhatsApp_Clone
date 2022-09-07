import 'package:flutter/material.dart';
import 'package:serti_whatsapp_clone/themes/theme.dart';
import 'package:serti_whatsapp_clone/utils/app_screen_utils.dart';

class MyMessageCard extends StatelessWidget {
  final String message;
  final String date;

  const MyMessageCard({Key? key, required this.message, required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              color: AppColours.messageColor,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Padding(
                  padding: AppScreenUtils.appChatPadding,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        //! THE MESSAGE
                        Text(message,
                            overflow: TextOverflow.visible,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 16.0)),

                        //! TIME AND TICKS
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              //! DATE / TIME
                              Text(date,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          color: AppColours.textColor
                                              .withOpacity(0.7))),

                              //! SPACER
                              const SizedBox(width: 10),

                              //! TICK
                              Icon(Icons.done_all,
                                  size: 21,
                                  color: AppColours.textColor.withOpacity(0.7))
                            ])
                      ])))));
}
