import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormBuilderState> _loginKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 60, right: 60),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey), // Add a border
              borderRadius: BorderRadius.circular(10.0), // Add rounded corners
            ),
            child: FormBuilder(
              key: _loginKey,
              child: Column(
                mainAxisSize: MainAxisSize.min, // Center content vertically
                children: <Widget>[
                  SizedBox(
                    height: 90,
                    child:  LottieBuilder.asset('assets/teeth.json'),
                  ),
                  const Text(
                    'Welcome Dr. Gaurav Saxena',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Text(
                    'Login to Continue',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  FormBuilderTextField(
                    name: 'email',
                    decoration: const InputDecoration(labelText: 'Email'),
                    // validator: FormBuilderValidators.compose([
                    //   FormBuilderValidators.required(context),
                    //   FormBuilderValidators.email(context),
                    // ]),
                  ),
                  FormBuilderTextField(
                    name: 'password',
                    decoration: const InputDecoration(labelText: 'Password'),
                    // validator: FormBuilderValidators.compose([
                    //   FormBuilderValidators.required(context),
                    //   FormBuilderValidators.minLength(context, 6),
                    // ]),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16.0),
                  MaterialButton(
                    onPressed: () {
                      if (_loginKey.currentState!.saveAndValidate()) {
                        // Perform login logic here
                        // Access form values with _loginKey.currentState.value
                        final formData = _loginKey.currentState!.value;
                        print('Email: ${formData['email']}');
                        print('Password: ${formData['password']}');
                      }
                    },
                    child: const Text('Login'),
                  ),
                  // TextButton(
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => SignupPage()),
                  //     );
                  //   },
                  //   child: Text('Create an account'),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


