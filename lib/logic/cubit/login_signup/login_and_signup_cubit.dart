import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/user/user_model.dart';

part 'login_and_signup_state.dart';

class LoginAndSignupCubit extends Cubit<LoginAndSignupState> {
  LoginAndSignupCubit() : super(LoginAndSignupInitial());

  static LoginAndSignupCubit get(context) => BlocProvider.of(context);
  final FirebaseAuth auth = FirebaseAuth.instance;
  UserModel userModel = UserModel();

  // ------------ Email ------------

  Future<String> signupButton({
    required String name,
    required String phoneNumber,
    required String email,
    required String password,
  }) async {
    try {
      // String databaseResult;
      // Create User in Firebase Email
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? _user = auth.currentUser;

      // String uid = auth.currentUser!.uid;
      // print(uid);
      try {
        // Add user properties to firestore

        userModel.uid = _user!.uid;
        userModel.name = name;
        userModel.email = email;
        userModel.phone = phoneNumber;

        FirebaseFirestore _database = FirebaseFirestore.instance;

        _database.collection("users").add(userModel.toMap()).then(
            (DocumentReference doc) =>
                print('DocumentSnapshot added with ID: ${doc.id}'));
      } catch (e) {
        return e.toString();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      return e.toString();
    }
    return 'done';
  }
  // /res

  Future<String> loginButton(
      {required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      User? _user = auth.currentUser;
      CollectionReference user = FirebaseFirestore.instance.collection("users");
      var data = user.snapshots();
      data.where((event) => false);
      print(data);

      // userModel.uid = _user!.uid;
      // userModel.name = _user.displayName;
      // userModel.email = _user.email;
      // userModel.phone = _user.phoneNumber;
      // print(userModel);
      return "successfully logged in";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    }
    return '';
  }

  Future<void> logoutButton() async {
    try {
      await auth.signOut();
      print("Logged out");
    } catch (e) {
      print(e.toString());
    }
  }
}
