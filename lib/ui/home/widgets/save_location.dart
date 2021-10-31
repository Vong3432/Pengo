import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:pengo/bloc/locations/locations_repo.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/const/space_const.dart';
import 'package:pengo/helpers/geo/geo_helper.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';
import 'package:pengo/helpers/toast/toast_helper.dart';
import 'package:pengo/ui/widgets/button/custom_button.dart';
import 'package:pengo/ui/widgets/input/custom_textfield.dart';

class SaveLocationModal extends StatefulWidget {
  const SaveLocationModal({
    Key? key,
    required this.lat,
    required this.lng,
    this.defaultName,
  }) : super(key: key);

  final double lat;
  final double lng;
  final String? defaultName;

  @override
  State<SaveLocationModal> createState() => _SaveLocationModalState();
}

class _SaveLocationModalState extends State<SaveLocationModal> {
  late TextEditingController _controller;
  final _validator = MultiValidator([
    RequiredValidator(errorText: 'Name cannot be empty'),
  ]);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController(text: widget.defaultName);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Form(
        key: _formKey,
        child: Container(
          height: mediaQuery(context).size.height * 0.35,
          padding: const EdgeInsets.all(18),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Save this location",
                  style: PengoStyle.header(context),
                ),
                const SizedBox(
                  height: SECTION_GAP_HEIGHT,
                ),
                CustomTextField(
                  label: "Name",
                  validator: _validator,
                  hintText: "eg: Home",
                  controller: _controller,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: CustomButton(
                    isLoading: _isSubmitting,
                    onPressed: _saveLocation,
                    text: const Text("Save"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _saveLocation() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });
      // call save api
      // ... await apiHelper.post('xxx')
      try {
        await LocationRepo()
            .saveLocation(widget.lat, widget.lng, _controller.text);

        // update position
        await GeoHelper().determinePosition();
        showToast(msg: "Save successfully", backgroundColor: successColor);
      } catch (e) {
        showToast(msg: "$e");
      }

      setState(() {
        _isSubmitting = false;
      });
    }
  }
}
