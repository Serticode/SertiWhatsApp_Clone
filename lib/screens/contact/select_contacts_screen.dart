import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serti_whatsapp_clone/controllers/select_contacts_controller.dart';
import 'package:serti_whatsapp_clone/screens/error/error_screen.dart';
import 'package:serti_whatsapp_clone/screens/loading/loading_screen.dart';

class SelectContactsScreen extends ConsumerWidget {
  const SelectContactsScreen({super.key});

  void selectContact(
      {required WidgetRef ref,
      required Contact selectedContact,
      required BuildContext theContext}) {
    ref.read(selectContactsControllerProvider).selectedContact(
        selectedContact: selectedContact, theContext: theContext);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
      appBar: AppBar(
          title: const Text("Select contact"),
          centerTitle: true,
          actions: [
            //! SEARCH CONTACTS
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),

            //! MORE
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ]),
      body: ref.watch(getContactsProvider).when(
          //! SCREEN IS LOADING
          loading: () => const LoadingScreen(),

          //! DATA IS GOTTEN
          data: (contactList) => ListView.builder(
              itemCount: contactList.length,
              itemBuilder: (BuildContext context, int index) {
                //! FETCH EACH CONTACT
                final theContact = contactList[index];

                //! RETURN CONTACT DETAILS TO SCREEN
                return InkWell(
                  onTap: () => selectContact(
                      ref: ref,
                      selectedContact: theContact,
                      theContext: context),
                  child: ListTile(
                      //! CONTACT PHOTO
                      leading: theContact.photo == null
                          ? null
                          : CircleAvatar(
                              radius: 30.0,
                              backgroundImage: MemoryImage(theContact.photo!)),

                      //! CONTACT NAME
                      title: Text(theContact.displayName,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 16.0))),
                );
              }),

          //! ERROR SCREEN
          error: (error, stackTrace) =>
              ErrorScreen(theError: error.toString())));
}
