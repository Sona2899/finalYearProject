import 'package:cctv_monitor2/screens/login/loginViewModel.dart';
import 'package:cctv_monitor2/services/authServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, model, child) => Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.red, Colors.purple, Colors.blue]),
            image: DecorationImage(
                image: AssetImage("images/png/bg1.png"), fit: BoxFit.cover)),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text(
                'MISDEMEANOUR ACTIVITY IDENTIFICATION USING DEEP LEARNING',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              leading: IconButton(
                  icon: Icon(
                    Icons.list,
                    color: Colors.white,
                  ),
                  onPressed: () {}),
            ),
            body: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  loginDialogState(model, context),
                  registerDialogState(model, context)
                ],
              ),
            )),
      ),
      viewModelBuilder: () => LoginViewModel(),
      onModelReady: (model) => model.initialize(),
    );
  }
}

loginDialogState(LoginViewModel model, BuildContext context) {
  return Container(
    color: Colors.white,
    // ...
    child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: 300,
          height: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Login',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              Text('Email address'),
              _textField(
                  model.textFocusNodeEmail,
                  model.textControllerEmail,
                  model.textFocusNodePassword,
                  false,
                  context,
                  model,
                  model.validateEmail,
                  'Email',
                  false,
                  false),
              Text('Password'),
              _textField(
                  model.textFocusNodePassword,
                  model.textControllerPassword,
                  model.textFocusNodePassword,
                  false,
                  context,
                  model,
                  model.validatePassword,
                  'Password',
                  true,
                  true),
              Center(
                child: FlatButton(
                  color: Colors.blueGrey[800],
                  hoverColor: Colors.blueGrey[900],
                  highlightColor: Colors.black,
                  onPressed: () async {
                    if (model.validateEmail(model.textControllerEmail.text) ==
                            null &&
                        model.validatePassword(
                                model.textControllerPassword.text) ==
                            null) {
                      await signInWithEmailPassword(
                              model.textControllerEmail.text,
                              model.textControllerPassword.text)
                          .then(
                        (result) {
                          model.snakbarService(result, '');
                          print(result);
                          model.navigateToHome();
                        },
                      ).catchError((error) {
                        model.snakbarService('Wrong Password or Email', error);
                        print('Registration Error: $error');
                      });
                    } else {
                      model.snakbarService('Wrong EmailId or Password', '');
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Center(child: googleButton(model, context)),
            ],
          ),
        ),
      ),
    ),
  );
}

googleButton(LoginViewModel model, BuildContext context) {
  bool _isProcessing = false;

  return DecoratedBox(
    decoration: ShapeDecoration(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.blueGrey, width: 3),
      ),
      color: Colors.white,
    ),
    child: OutlineButton(
      highlightColor: Colors.blueGrey[100],
      splashColor: Colors.blueGrey[200],
      onPressed: () async {
        _isProcessing = true;
        await signInWithGoogle().then((result) {
          model.snakbarService(result, '');
          print(result);
          model.navigateToHome();
        }).catchError((error) {
          model.snakbarService('someThing please try again Later', '');
          print('Registration Error: $error');
        });
        _isProcessing = false;
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.blueGrey, width: 3),
      ),
      highlightElevation: 0,
      // borderSide: BorderSide(color: Colors.blueGrey, width: 3),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: _isProcessing
            ? CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                  Colors.blueGrey,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: AssetImage("assets/images/png/google.png"),
                    height: 40.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Continue with Google',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blueGrey,
                      ),
                    ),
                  )
                ],
              ),
      ),
    ),
  );
}

registerDialogState(LoginViewModel model, BuildContext context) {
  return Dialog(
    // ...
    child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: 300,
          height: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Register',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              Text('Email'),
              _textField(
                  model.textFocusNodeEmailreg,
                  model.textControllerEmailReg,
                  model.textFocusNodePasswordreg,
                  model.isEditingEmailReg,
                  context,
                  model,
                  model.validateEmail,
                  'Email',
                  false,
                  false),
              Text('Password'),
              _textField(
                  model.textFocusNodePasswordreg,
                  model.textControllerPasswordReg,
                  model.textFocusNodeConPasswordreg,
                  model.isEditingPasswordReg,
                  context,
                  model,
                  model.validatePassword,
                  'Password',
                  true,
                  false),
              Text('Confirm Password'),
              _textField(
                  model.textFocusNodeConPasswordreg,
                  model.textControllerConPasswordReg,
                  model.textFocusNodeConPasswordreg,
                  model.isEditingPasswordReg,
                  context,
                  model,
                  model.validatePassword,
                  'Confirm Password',
                  true,
                  true),
              Center(
                child: FlatButton(
                  color: Colors.blueGrey[800],
                  hoverColor: Colors.blueGrey[900],
                  highlightColor: Colors.black,
                  onPressed: () async {
                    if (model.validateEmail(
                                model.textControllerEmailReg.text) ==
                            null &&
                        model.validatePassword(
                                model.textControllerPasswordReg.text) ==
                            null) {
                      await registerWithEmailPassword(
                              model.textControllerEmailReg.text,
                              model.textControllerPasswordReg.text)
                          .then((result) {
                        model.refresh();
                        print(result);
                        model.snakbarService(result, '');
                      }).catchError((error) {
                        print('Registration Error: $error');
                        model.snakbarService(error, '');
                      });
                    } else {
                      print(model.regValidatePassword(
                          model.textControllerPasswordReg.text));
                      model.snakbarService(
                          model.regValidatePassword(
                              model.textControllerPasswordReg.text),
                          '');
                      model.refresh();
                    }

                    model.isEditingEmail = false;
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Text(
                      'Sign up',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

TextField _textField(
    FocusNode fn,
    TextEditingController tc,
    FocusNode nxt,
    bool isEdited,
    BuildContext context,
    LoginViewModel model,
    Function validate,
    String hint,
    bool obsecure,
    bool isSubmit) {
  return TextField(
    obscureText: obsecure,
    focusNode: fn,
    keyboardType: TextInputType.visiblePassword,
    textInputAction: TextInputAction.next,
    controller: tc,
    autofocus: false,
    onChanged: (value) {
      isEdited = true;
      model.notifyListeners();
    },
    onSubmitted: (value) async {
      fn.unfocus();
      FocusScope.of(context).requestFocus(nxt);
      isEdited = true;
      model.notifyListeners();
      if (isSubmit) {
        if (hint == 'Password') {
          if (model.validateEmail(model.textControllerEmail.text) == null &&
              model.validatePassword(model.textControllerPassword.text) ==
                  null) {
            await signInWithEmailPassword(model.textControllerEmail.text,
                    model.textControllerPassword.text)
                .then(
              (result) {
                model.snakbarService(result, '');
                print(result);
                model.navigateToHome();
              },
            ).catchError((error) {
              model.snakbarService('Wrong Password or Email', '');
              print('Registration Error: $error');
            });
          } else {
            model.snakbarService('Wrong EmailId or Password', '');
          }
        }
        if (hint == 'Confirm Password') {
          if (model.validateEmail(model.textControllerEmail.text) == null &&
              model.validatePassword(model.textControllerPassword.text) ==
                  null) {
            await signInWithEmailPassword(model.textControllerEmail.text,
                    model.textControllerPassword.text)
                .then(
              (result) {
                model.snakbarService(result, '');
                print(result);
                model.navigateToHome();
              },
            ).catchError((error) {
              model.snakbarService('Wrong Password or Email', '');
              print('Registration Error: $error');
            });
          } else {
            model.snakbarService('Wrong EmailId or Password', '');
          }
        }
      }
    },
    style: TextStyle(color: Colors.black),
    decoration: InputDecoration(
      border: new OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.blueGrey[800],
          width: 3,
        ),
      ),
      filled: true,
      hintStyle: new TextStyle(
        color: Colors.blueGrey[300],
      ),
      hintText: hint,
      fillColor: Colors.white,
      errorText: isEdited ? 'pugazh' : null,
      errorStyle: TextStyle(
        fontSize: 12,
        color: Colors.redAccent,
      ),
    ),
  );
}
