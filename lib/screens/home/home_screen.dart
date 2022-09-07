import 'package:flutter/material.dart';
import 'package:serti_whatsapp_clone/router/router.dart';
import 'package:serti_whatsapp_clone/router/routes.dart';
import 'package:serti_whatsapp_clone/themes/theme.dart';
import 'package:serti_whatsapp_clone/widgets/contacts_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
              elevation: 12,
              backgroundColor: AppColours.appBarColor,
              centerTitle: false,
              title: Text("Whatsapp by Serticode",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 21.0)),
              actions: [
                IconButton(
                    icon: const Icon(Icons.search, color: AppColours.textColor),
                    onPressed: () {}),
                IconButton(
                    icon: const Icon(Icons.more_vert,
                        color: AppColours.textColor),
                    onPressed: () {})
              ],
              bottom: const TabBar(
                  indicatorColor: AppColours.tabColor,
                  indicatorWeight: 4,
                  labelColor: AppColours.tabColor,
                  unselectedLabelColor: AppColours.textColor,
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  tabs: [
                    Tab(text: 'CHATS'),
                    Tab(text: 'STATUS'),
                    Tab(text: 'CALLS')
                  ])),
          body: const ContactsList(),
          floatingActionButton: FloatingActionButton(
              onPressed: () => AppNavigator.navigateToPage(
                  thePageRouteName: AppRoutes.selectContactsScreen,
                  context: context),
              backgroundColor: AppColours.tabColor,
              child: const Icon(Icons.comment, color: AppColours.textColor))));
}
