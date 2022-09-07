import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serti_whatsapp_clone/repository/select_contacts_repository.dart';

final getContactsProvider = FutureProvider((ref) {
  final selectContactsRepository = ref.watch(selectContactsRepositoryProvider);
  return selectContactsRepository.getUserContacts();
});

final selectContactsControllerProvider = Provider((ref) {
  final selectContactsRepository = ref.watch(selectContactsRepositoryProvider);
  return SelectContactsController(
      ref: ref, selectContactsRepository: selectContactsRepository);
});

class SelectContactsController {
  final ProviderRef ref;
  final SelectContactsRepository selectContactsRepository;

  SelectContactsController(
      {required this.ref, required this.selectContactsRepository});

  Future<void> selectedContact(
      {required Contact selectedContact,
      required BuildContext theContext}) async {
    await selectContactsRepository.selectContact(
        selectedContact: selectedContact, theContext: theContext);
  }
}
