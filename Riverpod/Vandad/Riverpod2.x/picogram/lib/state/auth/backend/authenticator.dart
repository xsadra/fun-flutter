import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../posts/typedef/user_id.dart';
import '../constants/constants.dart';
import '../models/auth_result.dart';

class Authenticator {
  const Authenticator();

  UserId? get userId => FirebaseAuth.instance.currentUser?.uid;

  bool get isSignedIn => FirebaseAuth.instance.currentUser != null;

  String get displayName =>
      FirebaseAuth.instance.currentUser?.displayName ?? '';

  String? get email => FirebaseAuth.instance.currentUser?.email;

  Future<AuthResult> loginWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final AuthCredential credential =
            FacebookAuthProvider.credential(accessToken.token);
        await FirebaseAuth.instance.signInWithCredential(credential);
        return AuthResult.success;
      } else {
        return AuthResult.aborted;
      }
    } on FirebaseAuthException catch (e) {
      final email = e.email;
      final credential = e.credential;
      if (e.code == Constants.accountExistsWithDifferentCredential &&
          email != null &&
          credential != null) {
        final providers =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
        if (providers.contains(Constants.googleCom)) {
          await signInWithGoogle();
          await FirebaseAuth.instance.currentUser
              ?.linkWithCredential(credential);
        }
        return AuthResult.success;
      } else {
        return AuthResult.failure;
      }
    }
  }

  Future<AuthResult> signInWithGoogle() async {
    final GoogleSignIn googleSignIn =
        GoogleSignIn(scopes: [Constants.emailScope]);
    final signInAccount = await googleSignIn.signIn();
    if (signInAccount == null) {
      return AuthResult.aborted;
    }
    final googleAuth = await signInAccount.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      return AuthResult.success;
    } on Exception catch (_) {
      return AuthResult.failure;
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
  }
}
