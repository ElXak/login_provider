import 'package:flutter/material.dart';

import '../models/validation.dart';
import 'loader_state.dart';

class LoginProvider with ChangeNotifier implements LoaderState {
  LoginProvider() {
    setState(ViewState.Idle);
  }

  ValidationModel _email = ValidationModel(value: null, error: null);
  ValidationModel _password = ValidationModel(value: null, error: null);
  ViewState _state;

  // Getters
  ValidationModel get email => _email;
  ValidationModel get password => _password;

  bool get isValid {
    if (_email.value != null && _password.value != null) {
      return true;
    } else {
      return false;
    }
  }

  ViewState get state => _state;

  // Setters
  void changeEmail(String value) {
    if (ValidatorType.email.hasMatch(value)) {
      _email = ValidationModel(value: value, error: null);
    } else if (value.isEmpty) {
      _email = ValidationModel(value: null, error: null);
    } else {
      _email = ValidationModel(value: null, error: 'Enter a valid email');
    }

    notifyListeners();
  }

  void changePassword(String value) {
    if (ValidatorType.password.hasMatch(value)) {
      _password = ValidationModel(value: value, error: null);
    } else if (value.isEmpty) {
      _password = ValidationModel(value: null, error: null);
    } else {
      _password = ValidationModel(
          value: null, error: 'Must have at least 8 characters');
    }

    notifyListeners();
  }

  @override
  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  Future<void> submitLogin() async {
    setState(ViewState.Busy);
    final Mapable response = await apiClient.serverDataProvider.login(
      _email.value,
      _password.value,
    );

    setState(ViewState.Idle);

    if (response is LoginResponse) {
      print('response.token ${response.token}');
      return response;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
