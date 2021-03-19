class ValidationModel {
  final String value;
  final String error;

  ValidationModel({this.value, this.error});
}

class ValidatorType {
  static final RegExp email = RegExp(
      r"^(([^<>()[\]\\.,;:\s@\”]+(\.[^<>()[\]\\.,;:\s@\”]+)*)|(\”.+\”))@((\[[0–9]{1,3}\.[0–9]{1,3}\.[0–9]{1,3}\.[0–9]{1,3}\])|(([a-zA-Z\-0–9]+\.)+[a-zA-Z]{2,}))$");
  static final RegExp password = RegExp(r"^(?=.*)(.){8,15}$");
}
