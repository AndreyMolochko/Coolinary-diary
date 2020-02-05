import 'package:sqflite_worker/model/contact_type.dart';

class ContactResources {
  ContactType contactType;
  String url;
  String imagePath;

  ContactResources(this.contactType, this.url, this.imagePath);
}