import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/login_provider.dart';
import '../providers/loader_state.dart';

class LoginScreenWithProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginProvider>(
      create: (context) => LoginProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView(
            children: [
              // Email field
              Consumer<LoginProvider>(
                builder: (context, provider, child) {
                  return TextField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      errorText: provider.email.error,
                    ),
                    onChanged: (String value) {
                      print('provider.email.error ${provider.email.error}');
                      provider.changeEmail(value);
                    },
                  );
                },
              ),
              // Password field
              Consumer<LoginProvider>(
                builder: (context, provider, child) {
                  return TextField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      errorText: provider.password.error,
                    ),
                    onChanged: (String value) {
                      provider.changePassword(value);
                    },
                  );
                },
              ),
              // Update indicator
              Consumer<LoginProvider>(
                builder: (context, provider, child) {
                  return Container(
                    height: 150,
                    child: Center(
                      child: provider.state == ViewState.Idle
                          ? Container()
                          : CircularProgressIndicator(),
                    ),
                  );
                },
              ),
              // Submit button will be enabled on correct format of email and password
              Consumer<LoginProvider>(
                builder: (context, provider, child) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: (!provider.isValid) ? null : () {
                      provider.submitLogin().then((LoginResponse response) {
                        print('response: ${response.token}');
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
                      })
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
