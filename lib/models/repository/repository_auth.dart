import 'dart:async';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rent_car/models/repository/repository_fireStore.dart';
import '../../../../application/app/cache.dart';
import '../../../../application/error/resetPasswordFailure.dart';
import '../../../../application/error/signInFailure.dart';
import '../../../../application/error/signInWithGoogleFailure.dart';
import '../../../../application/error/signUpFailure.dart';
import '../../../../main.dart';
import '../entities/user_entity.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepositoryImplementation{
  AuthenticationRepositoryImplementation({
    CacheClient? cache,
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : cache = cache ?? CacheClient(),
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
  _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final CacheClient cache;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  bool isSignUp = false;
  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  /// Stream of [UserEntity] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [UserEntity.empty] if the user is not authenticated.
  Stream<User?> get user{
    return _firebaseAuth.authStateChanges().asyncMap((firebaseUser)  async {
      final UserEntity? user;
      if(firebaseUser==null){
        return firebaseUser;
      }
      // if(isSignUp == false) {
      //   user = await firebaseUser.toUser;
      //   cache.write<UserEntity>(key: userCacheKey, value: user);
      // }

      return firebaseUser;
    });
  }

  /// Returns the current cached user.
  /// Defaults to [UserEntity.empty] if there is no cached user.
  UserEntity get currentUser {
    return cache.read<UserEntity>(key: userCacheKey) ?? UserEntity.empty;
  }

  void cacheChange(UserEntity user){
    cache.write(key: userCacheKey, value: user);
  }

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> signUp({required String email, required String password,required Uint8List imagePath
  ,required String name}) async {
    try {
      isSignUp = true;
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ).then((value) async{
        if(value.user != null){
         final imagePathCloud = await getIt<FireStoreRepositoryImplementation>().addNewUserData(
        _firebaseAuth.currentUser!.uid,
        name, email, imagePath);
         UserEntity userEntity = UserEntity(id: _firebaseAuth.currentUser!.uid, email: email, name: name, photo: imagePathCloud);
         cache.write(key: userCacheKey, value: userEntity);
        }
      });
      isSignUp = false;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }


  Future<void> sendEmailVerificationCode()async{
    await _firebaseAuth.currentUser!.sendEmailVerification();
  }



  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  Future<void> logInWithGoogle() async {
    try {
      late final firebase_auth.AuthCredential credential;
        final googleUser = await _googleSignIn.signIn();
        if(googleUser == null){
          throw const LogInWithGoogleFailure("Please select account");
        }
        final googleAuth = await googleUser.authentication;
        credential = firebase_auth.GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
      await _firebaseAuth.signInWithCredential(credential);
      await getIt<FireStoreRepositoryImplementation>().addNewUserDataGoogleSignIn(
        _firebaseAuth.currentUser!.uid,
        _firebaseAuth.currentUser!.displayName!,
        _firebaseAuth.currentUser!.email!,
        _firebaseAuth.currentUser!.photoURL!,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithGoogleFailure.fromCode(e.code);
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {

      List<String> methods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(FirebaseAuth.instance.currentUser!.email!);
      if(!methods.contains("google.com")) {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
      }else{
        throw(FirebaseAuthException(code: 'user-not-found'));
      }

    } on FirebaseAuthException catch (e) {
      throw ResetPasswordFailure.fromCode(e.code);
    } catch (text) {
      throw ResetPasswordFailure(text.toString());
    }
  }

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await Future.wait([
        if(_googleSignIn.currentUser == null){
          _firebaseAuth.signOut(),
        }else{
         _googleSignIn.signOut(),
         _firebaseAuth.signOut()
        }
      ] as Iterable<Future>);
    } catch (_) {
      throw LogOutFailure();
    }
  }
}

extension on firebase_auth.User {
  Future<UserEntity> get toUser async{
    final user = await getIt<FireStoreRepositoryImplementation>().getUser(uid);
    return user;
  }
}

class LogOutFailure implements Exception {}