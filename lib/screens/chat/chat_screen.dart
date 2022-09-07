import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serti_whatsapp_clone/controllers/auth_controller.dart';
import 'package:serti_whatsapp_clone/models/user_model.dart';
import 'package:serti_whatsapp_clone/themes/theme.dart';
import 'package:serti_whatsapp_clone/widgets/chat_list.dart';

class ChatScreen extends ConsumerWidget {
  final UserModel theUserDetails;
  const ChatScreen({Key? key, required this.theUserDetails}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColours.appBarColor,
          title: StreamBuilder<UserModel>(
              stream: ref
                  .read(authControllerProvider)
                  .userDataStream(userPhoneNumber: theUserDetails.phoneNum),
              builder: (context, snapshot) {
                //! CONNECTION IS WAITING AND WE CAN'T ACCESS USER ONLINE STATUS.
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //! USER NAME
                        Text(theUserDetails.userName),

                        //! ALERT TO WAITING
                        Text("Awaiting online status...",
                            style: Theme.of(context).textTheme.bodyText2)
                      ]);
                }

                //! CONNECTION IS DONE AND WE NOW HAVE USER STATUS UPDATES
                //! USE THE SNAPSHOT DATA GOTTEN FROM THE STREAM
                //! SO USER DETAILS CAN BE UPDATED IN REAL TIME
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //! USER NAME
                      Text(theUserDetails.userName),

                      //! ONLINE STATUS
                      snapshot.data!.isUserOnline
                          ? Text("Online",
                              style: Theme.of(context).textTheme.bodyText2)
                          : Text("Offline",
                              style: Theme.of(context).textTheme.bodyText2)
                    ]);
              }),
          centerTitle: false,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.video_call)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ]),
      body: Column(
        children: [
          const Expanded(
            child: ChatList(),
          ),
          TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColours.mobileChatBoxColor,
              prefixIcon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(
                  Icons.emoji_emotions,
                  color: Colors.grey,
                ),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Icon(
                      Icons.camera_alt,
                      color: Colors.grey,
                    ),
                    Icon(
                      Icons.attach_file,
                      color: Colors.grey,
                    ),
                    Icon(
                      Icons.money,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              hintText: 'Type a message!',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              contentPadding: const EdgeInsets.all(10),
            ),
          ),
        ],
      ),
    );
  }
}
