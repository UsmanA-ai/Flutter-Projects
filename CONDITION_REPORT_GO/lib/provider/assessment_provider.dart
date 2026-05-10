import 'package:firebase_auth/firebase_auth.dart';

String? currentId;
String uid = FirebaseAuth.instance.currentUser!.uid;