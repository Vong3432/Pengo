/*
* Helper that handles regex pattern for validator
* plugin: `form_field_validator: ^1.1.0`
*/
class ValidationHelper {
  static Pattern emailPattern() {
    final Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    return pattern;
  }
}
