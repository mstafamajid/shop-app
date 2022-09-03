import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/myexceptionHandler.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/screens/products_overview_screen.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context);
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    var Appbar = AppBar(
      title: Text(
        'My Shop',
        style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 40,
            fontFamily: 'lato',
            fontWeight: FontWeight.w900),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    );

    return Scaffold(
      appBar: Appbar,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
          ),
          SingleChildScrollView(
            child: Container(
              height: (deviceSize.size.height -
                  Appbar.preferredSize.height -
                  deviceSize.padding.top),
              width: deviceSize.size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Lottie.network(
                            'https://lottie.host/ff6b2ade-7a6e-40c9-98c8-9d534fc51dee/FTO59BPhsG.json',
                            errorBuilder: ((context, error, stackTrace) {
                          return Text(error.toString());
                        }))),
                  ),
                  AuthCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key? key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  void _submit() async {
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        await Provider.of<Auth>(context, listen: false)
            .signIn(_authData['email']!, _authData['password']!);
      } else {
        await Provider.of<Auth>(context, listen: false)
            .signUp(_authData['email']!, _authData['password']!);
        _authMode = AuthMode.Login;
        // Sign user up
      }
    } on httpexception catch (error) {
      var message = 'Authentication failed';
      if (error.toString().contains('EMAIL_NOT_FOUND')) {
        message = 'email not found';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        message = 'invalid password';
      } else if (error.toString().contains('EMAIL_EXISTS')) {
        message = 'this email already has used, try another email';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        message = 'this email isn\'t valid';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        message = 'this password to weak please use stronger password';
      } else if (error.toString().contains('TOO')) {
        message =
            'Access to this account has been temporarily disabled due to many failed login attempts.';
      }

      showErrorDialog(message);
      print(error.toString());
    } catch (e) {
      var message = 'Authentication has failed try again later';
      print(e.toString());
      showErrorDialog(message);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  void showErrorDialog(String errorMessage) {
    showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              titlePadding: const EdgeInsets.all(20),
              title: const Text('Error has Occured'),
              content: Text(errorMessage),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: const Text('Ok'))
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context);
    print(MediaQuery.of(context).viewInsets.bottom);
    return Card(
      margin:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: _authMode == AuthMode.Signup ? 320 : 260,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 320 : 260),
        width: (deviceSize.size.width) * 0.75,
        padding: EdgeInsets.all(16.0),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                  },
                  onSaved: (value) {
                    _authData['email'] = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                  },
                  onSaved: (value) {
                    _authData['password'] = value!;
                  },
                ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match!';
                            }
                          }
                        : null,
                  ),
                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  ElevatedButton(
                    child:
                        Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                TextButton(
                  child: Text(
                      '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                  onPressed: _switchAuthMode,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
