import 'package:blog_application/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository{
  Future<Either<Failure,String>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, String>> logInWithEmailAndPassword({
    required String email,
    required String password,
  });
}





/*   Future<void> signInWithGoogle();
  Future<void> signInWithFacebook();
  Future<void> signInWithApple();
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> signUpWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Future<bool> isSignedIn();
  Future<String> getUserId();
  Future<String> getUserEmail();
  Future<String> getUserDisplayName();
  Future<String> getUserPhotoUrl();
  Future<void> sendPasswordResetEmail(String email);
  Future<void> updatePassword(String password);
  Future<void> updateEmail(String email);
  Future<void> updateDisplayName(String displayName);
  Future<void> updatePhotoUrl(String photoUrl);
  Future<void> deleteAccount();
  Future<void> reauthenticateWithCredential(String password);
  Future<void> reauthenticateWithGoogle();
  Future<void> reauthenticateWithFacebook();
  Future<void> reauthenticateWithApple();
  Future<void> reauthenticateWithEmailAndPassword(String email, String password);
  Future<void> reauthenticateWithBiometrics();
  Future<void> reauthenticateWithPin();
  Future<void> reauthenticateWithPassword();
  Future<void> reauthenticateWithPhone();
  Future<void> reauthenticateWithOtp();
  Future<void> reauthenticateWithSms();
  Future<void> reauthenticateWithCall();
  Future<void> reauthenticateWithFingerprint();
  Future<void> reauthenticateWithFaceId();
  Future<void> reauthenticateWithTouchId();
  Future<void> reauthenticateWithIris();
  Future<void> reauthenticateWithRetina();
  Future<void> reauthenticateWithVoice();
  Future<void> reauthenticateWithPalm();
  Future<void> reauthenticateWithVein();
  Future<void> reauthenticateWithSignature();
  Future<void> reauthenticateWithKeystroke();
  Future<void> reauthenticateWithHeartbeat();
  Future<void> reauthenticateWithBrainwave();
  Future<void> reauthenticateWithDna();
  Future<void> reauthenticateWithEarShape();
  Future<void> reauthenticateWithEarPrint();
  Future<void> reauthenticateWithEarRecognition();
  Future<void> reauthenticateWithEarVein();
  Future<void> reauthenticateWithEarSignature();
  Future<void> reauthenticateWithEarImpedance();
  Future<void> reauthenticateWithEarTemperature();
  Future<void> reauthenticateWithEarPressure();
 */