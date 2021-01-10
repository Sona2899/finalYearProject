import 'dart:async';

import 'package:cctv_monitor2/app/locator.dart';
import 'package:cctv_monitor2/app/router.gr.dart' as custom;
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  String _title = 'Welcome to cyberforce';
  String get title => _title;
  TextEditingController textControllerEmail;
  TextEditingController textControllerPassword;
  TextEditingController textControllerEmailReg;
  TextEditingController textControllerPasswordReg;
  TextEditingController textControllerConPasswordReg;
  TextEditingController textControllerUserName;
  FocusNode textFocusNodeEmail;
  FocusNode textFocusNodePassword;
  FocusNode textFocusNodeEmailreg;
  FocusNode textFocusNodePasswordreg;
  FocusNode textFocusNodeConPasswordreg;
  FocusNode textFocusNodeUsername;
  bool isEditingEmail = false;
  bool isEditingPassword = false;
  bool isRegistering = false;
  bool isEditingEmailReg = false;
  bool isEditingPasswordReg = false;
  bool isRegisteringReg = false;

  initialize() {
    init();
  }

  init() {
    textControllerEmail = TextEditingController();
    textControllerEmail.text = null;
    textFocusNodeEmail = FocusNode();
    textControllerPassword = TextEditingController();
    textControllerPassword.text = null;
    textFocusNodePassword = FocusNode();
    textControllerEmailReg = TextEditingController();
    textControllerEmailReg.text = null;
    textFocusNodeEmailreg = FocusNode();
    textControllerPasswordReg = TextEditingController();
    textControllerPasswordReg.text = null;
    textFocusNodePasswordreg = FocusNode();
    textControllerConPasswordReg = TextEditingController();
    textControllerConPasswordReg.text = null;
    textFocusNodeConPasswordreg = FocusNode();
  }

  refresh() {
    textControllerEmail.clear();
    textFocusNodeEmail = FocusNode();
    textControllerPassword.clear();
    textFocusNodePassword = FocusNode();
    textControllerEmailReg.clear();
    textFocusNodeEmailreg = FocusNode();
    textControllerPasswordReg.clear();
    textFocusNodePasswordreg = FocusNode();
    textControllerConPasswordReg.clear();
    textFocusNodeConPasswordreg = FocusNode();
  }

  String validateEmail(String value) {
    value = value.trim();
    if (textControllerEmail != null) {
      if (value.isEmpty) {
        return 'Email can\'t be empty';
      } else if (!value.contains(RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
        return 'Enter a correct email address';
      }
    }

    return null;
  }

  String validatePassword(String value) {
    value = value.trim();

    if (textControllerPassword.text != null &&
        textControllerEmail.text != null) {
      if (value.isEmpty) {
        return 'Password can\'t be empty';
      }
    }
    return null;
  }

  String regValidatePassword(String value) {
    value = value.trim();
    if (textControllerPasswordReg.text != null &&
        textControllerEmailReg.text != null) {
      if (value.isEmpty) {
        return 'Password can\'t be empty';
      }
    }
    if (textControllerPasswordReg.text != textControllerConPasswordReg.text) {
      //refresh();
      return 'password dismatch';
    }
    return null;
  }

  Future navigateToHome() async {
    await _navigationService.navigateTo(custom.Routes.homeViewRoute);
  }

  void snakbarService(String m1, String m2) {
    _snackbarService.showSnackbar(
      message: m1,
      title: m2,
      duration: Duration(seconds: 2),
      onTap: (_) {
        print('snackbar tapped');
      },
      mainButtonTitle: 'Undo',
      onMainButtonTapped: () => print('Undo the action!'),
    );
  }

  bool isPasswordVisible = true;
  void passwordVisible() {
    isPasswordVisible = false;
    const oneSec = const Duration(seconds: 1);
    new Timer.periodic(oneSec, (Timer t) => isPasswordVisible = true);
  }
}
