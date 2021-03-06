import 'package:fennec_desktop/components/alert_dialog.dart';
import 'package:fennec_desktop/main.dart';
import 'package:fennec_desktop/models/error_message.dart';
import 'package:fennec_desktop/services/login_dao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final LoginDao _dao = LoginDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFB00B8),
              Color(0xFFFB2588),
              Color(0xFFFB3079),
              Color(0xFFFB4B56),
              Color(0xFFFB5945),
              Color(0xFFFB6831),
              Color(0xFFFB6E29),
              Color(0xFFFB8C03),
              // Color(0xFFFB8D01),
              // Color(0xFFFB8E00),
            ],
          ),
        ),
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 250,
                width: 250,
                child: Image.asset(
                  'assets/images/white-logo.png',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: 420,
                width: 500,
                child: Card(
                  // color: Color(0xFFFFA07A),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: RawKeyboardListener(
                    focusNode: FocusNode(),
                    onKey: (event) {
                      if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
                        if (event.isKeyPressed(LogicalKeyboardKey.shiftLeft)) {
                          return print('break line');
                        } else {
                          print('Enter Pressed');
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            _dao
                                .login(_telefoneController.text,
                                    _senhaController.text)
                                .then((value) {
                              _setToken(
                                value.token,
                                value.nome,
                                value.tell,
                                value.id,
                              );
                            }).catchError((onError) {
                              getErrorFunction(onError);
                            });
                          }
                        }
                      }
                    },
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomFormField(
                            icone: Icons.phone_android_outlined,
                            label: 'Telefone',
                            textController: _telefoneController,
                          ),
                          CustomPasswordInput(
                            label: 'Senha',
                            textController: _senhaController,
                            // submited: () => {},
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 50.0, bottom: 30.0),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFFB00B8),
                                    Color(0xFFFB2588),
                                    Color(0xFFFB3079),
                                    Color(0xFFFB4B56),
                                    Color(0xFFFB5945),
                                    Color(0xFFFB6831),
                                    Color(0xFFFB6E29),
                                    Color(0xFFFB8C03),
                                    Color(0xFFFB8D01),
                                    Color(0xFFFB8E00),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();

                                    _dao
                                        .login(_telefoneController.text,
                                            _senhaController.text)
                                        .then((value) {
                                      _setToken(
                                        value.token,
                                        value.nome,
                                        value.tell,
                                        value.id,
                                      );
                                    }).catchError((onError) {
                                      getErrorFunction(onError);
                                    });
                                  }
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20.0,
                                    horizontal: 50.0,
                                  ),
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  elevation: 5,
                  margin: const EdgeInsets.all(50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getErrorFunction(onError) {
    if (onError.runtimeType == ErrorMessage) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFFF3F2F3),
          content: Text(
            onError.message,
            style: const TextStyle(color: Colors.black),
          ),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {
              // Code to execute.
            },
          ),
          width: 280.0,
          behavior: SnackBarBehavior.floating,
        ),
      );

      // se caso for outro tipo de erro, exemplo: SocketException, servidor fora do ar
    } else {
      Future.delayed(
        const Duration(seconds: 0),
        () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => CustomAlertDialog(
            description:
                "${onError.message.toString()}.\n\nEntre em contato com o suporte.",
          ),
        ),
      );
    }
  }

  _setToken(token, name, phone, id) {
    prefs.setString('token', token);
    prefs.setString('name', name);
    prefs.setString('phone', phone);
    prefs.setString('id', id);
    Navigator.of(context).pushNamed('/mainPage');
  }
}

class CustomFormField extends StatelessWidget {
  final String? label;
  final IconData? icone;
  final TextEditingController? textController;
  final String? initialValue;
  final bool? isEnable;

  const CustomFormField({
    Key? key,
    this.label,
    this.icone,
    this.textController,
    this.initialValue,
    this.isEnable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 35.0, top: 30.0),
        child: TextFormField(
          enabled: isEnable ?? true,
          autofocus: true,
          initialValue: initialValue,
          controller: textController,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(
              color: Color(0xFFB0B0B0),
              fontFamily: 'Montserrat',
            ),
            prefixIcon: icone != null ? Icon(icone) : null,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Campo obrigat??rio.';
            }
            return null;
          },
        ),
      ),
    );
  }
}

class CustomPasswordInput extends StatefulWidget {
  final TextEditingController? textController;
  final String? label;
  // final Function submited;

  const CustomPasswordInput({
    Key? key,
    this.textController,
    this.label,
  }) : super(key: key);

  @override
  _CustomPasswordInputState createState() => _CustomPasswordInputState();
}

class _CustomPasswordInputState extends State<CustomPasswordInput> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
        child: TextFormField(
          controller: widget.textController,
          style: const TextStyle(
            fontSize: 20.0,
          ),
          obscureText: _isObscure,
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: const TextStyle(
              color: Color(0xFFB0B0B0),
            ),
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Campo obrigat??rio.';
            }
            return null;
          },
          // onFieldSubmitted: widget.submited(),
        ),
      ),
    );
  }
}
