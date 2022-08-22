import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

class FirebaseAuthencation {
  Future<void> initFirebase() async {
    try {
      await Firebase.initializeApp();
    } catch (error) {
      throw error.toString();
    }
  }

  Future<void> createAccount(String email, String password) async {
    final auth = FirebaseAuth.instance;
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return;
    } catch (error) {
      throw error.toString();
    }
  }

  Future<void> login(String email, String password) async {
    final auth = FirebaseAuth.instance;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return;
    } catch (error) {
      throw error.toString();
    }
  }

  Future<User?> loginWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    await googleSignIn.signOut();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          throw 'account-exists-with-different-credential';
        } else if (e.code == 'invalid-credential') {
          throw 'invalid-credential';
        } else {
          throw e.toString();
        }
      } catch (e) {
        throw e.toString();
      }
    }

    return user;
  }

  Future<User?> loginWithFacebook() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      await FacebookAuth.instance.logOut();
      final facebookloginResult = await FacebookAuth.instance.login();
      final userData = await FacebookAuth.instance.getUserData();

      final facebookAuthCredential = FacebookAuthProvider.credential(
          facebookloginResult.accessToken!.token);

      final UserCredential userCredential =
          await auth.signInWithCredential(facebookAuthCredential);

      user = userCredential.user;
    } catch (error) {
      throw error.toString();
    }

    return user;
  }

  User? checkCurrentUser() {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    return user;
  }

  Future<void> logout() async {
    final auth = FirebaseAuth.instance;
    await auth.signOut();
  }

  Future<bool> checkAppleSignInAvailable() async {
    return await TheAppleSignIn.isAvailable();
  }

  Future<User?> loginWithApple({List<Scope> scopes = const []}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    // 1. perform the sign-in request
    final result = await TheAppleSignIn.performRequests(
        [AppleIdRequest(requestedScopes: scopes)]);
    // 2. check the result
    switch (result.status) {
      case AuthorizationStatus.authorized:
        final appleIdCredential = result.credential!;
        final oAuthProvider = OAuthProvider('apple.com');
        final credential = oAuthProvider.credential(
          idToken: String.fromCharCodes(appleIdCredential.identityToken!),
          accessToken:
              String.fromCharCodes(appleIdCredential.authorizationCode!),
        );
        final userCredential = await auth.signInWithCredential(credential);
        user = userCredential.user!;
        return user;
      // if (scopes.contains(Scope.fullName)) {
      //   final fullName = appleIdCredential.fullName;
      //   if (fullName != null &&
      //       fullName.givenName != null &&
      //       fullName.familyName != null) {
      //     final displayName = '${fullName.givenName} ${fullName.familyName}';
      //     await firebaseUser.updateDisplayName(displayName);
      //   }
      // }
      // return firebaseUser;
      case AuthorizationStatus.error:
        print(result.error.toString());
        throw result.error.toString();
      case AuthorizationStatus.cancelled:
        throw 'Sign in aborted by user';
      default:
        throw 'Unkow Error';
    }
  }
}
