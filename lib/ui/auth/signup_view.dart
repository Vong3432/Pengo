import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pengo/bloc/auth/auth_bloc.dart';
import 'package:pengo/bloc/auth/auth_repo.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/const/graphic_const.dart';
import 'package:pengo/const/icon_const.dart';
import 'package:pengo/const/space_const.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';
import 'package:pengo/helpers/validation/validation_helper.dart';
import 'package:pengo/models/providers/auth_model.dart';
import 'package:pengo/ui/goocard/widgets/pincode.dart';
import 'package:pengo/ui/widgets/button/custom_button.dart';
import 'package:pengo/ui/widgets/input/custom_textfield.dart';
import 'package:pengo/ui/widgets/layout/sliver_body.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  final _phoneValidator = MultiValidator([
    RequiredValidator(errorText: 'Phone cannot be empty'),
    MinLengthValidator(10, errorText: 'Your phone is incorrect format'),
    // MaxLengthValidator(10, errorText: 'Your phone is incorrect format')
  ]);
  final _passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password cannot be empty'),
    MinLengthValidator(8, errorText: 'Minimum password length is 8')
  ]);

  final _emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email cannot be empty'),
    PatternValidator(ValidationHelper.emailPattern(),
        errorText: 'Email format is invalid')
  ]);

  final _usernameValidator = MultiValidator([
    RequiredValidator(errorText: 'Username cannot be empty'),
  ]);

  final _ageValidator = MultiValidator([
    RequiredValidator(errorText: 'Age cannot be empty'),
  ]);

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  XFile? _profile;

  bool hasError = true;
  String? phoneNotUniqueErr = "";
  String? emailNotUniqueErr = "";
  int _step = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _phoneController.addListener(_listenPhoneValid);
    _emailController.addListener(_listenEmailValid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSliverBody(content: <Widget>[
            _buildHeader(context),
            _buildContent(context),
          ])
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (_step == 1) _buildFirst(context),
            if (_step == 2) _buildSecond(context),
            if (_step == 3) _buildThird(context),
          ],
        ),
      ),
    );
  }

  Widget _buildThird(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: mediaQuery(context).size.width * 0.8,
          child: Text(
            "Setup PIN",
            style: PengoStyle.navigationTitle(context).copyWith(
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: SECTION_GAP_HEIGHT,
        ),
        Text(
          "Use this pin to verify your booking pass and coupon in the future.",
          style: PengoStyle.body(context).copyWith(
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: SECTION_GAP_HEIGHT,
        ),
        GooCardPinCode(
          controller: _pinController,
          onTextChanged: (String text) {
            setState(() {
              hasError = false;
            });
          },
        ),
        const SizedBox(
          height: SECTION_GAP_HEIGHT * 2,
        ),
        BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is AuthenticatedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Register and login successfully!"),
                  backgroundColor: primaryColor,
                ),
              );
              context.read<AuthModel>().setUser(state.auth);
              Navigator.of(context).pop(true);
            }
            if (state is NotAuthenticatedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.err.toString()),
                  backgroundColor: dangerColor,
                ),
              );
            }
          },
          builder: (BuildContext context, AuthState state) {
            if (state is AuthenticatingState) {
              return const CircularProgressIndicator();
            }
            return CustomButton(
              text: Text("Next"),
              onPressed: () {
                if (hasError == true || _pinController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text("Fill in your pin."),
                      backgroundColor: dangerColor,
                    ),
                  );
                } else {
                  // ---------------------------------
                  // TODO: start calling register
                  // ---------------------------------
                  _register(context);
                }
              },
            );
          },
        ),
      ],
    );
  }

  void _register(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(
      RegisterEvent(
          age: int.parse(_ageController.text),
          phone: _phoneController.text,
          password: _passwordController.text,
          username: _usernameController.text,
          email: _emailController.text,
          pin: _pinController.text,
          avatar: _profile!),
    );
  }

  Widget _buildSecond(BuildContext context) {
    return Form(
      key: formKeys[1],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: mediaQuery(context).size.width * 0.8,
            child: Text(
              "Complete your personal info",
              style: PengoStyle.navigationTitle(context).copyWith(
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: SECTION_GAP_HEIGHT,
          ),
          Text(
            "Let people able to recognize you",
            style: PengoStyle.body(context).copyWith(
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: SECTION_GAP_HEIGHT,
          ),
          GestureDetector(
            onTap: _pickImageFromGallery,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: greyBgColor,
              ),
              child: Center(
                child: _profile != null
                    ? Image.file(
                        File(_profile!.path),
                        fit: BoxFit.cover,
                      )
                    : SvgPicture.asset(PROFILE_ICON_PATH),
              ),
            ),
          ),
          CustomTextField(
            label: "Email",
            hintText: "",
            validator: _emailValidator,
            controller: _emailController,
            error: emailNotUniqueErr,
            onChanged: (_) {
              setState(() {
                emailNotUniqueErr = "";
              });
            },
            // contentPadding: const EdgeInsets.all(8),
          ),
          CustomTextField(
            label: "Username",
            hintText: "",
            validator: _usernameValidator,
            controller: _usernameController,
            // contentPadding: const EdgeInsets.all(8),
          ),
          CustomTextField(
            label: "Age",
            hintText: "",
            validator: _ageValidator,
            controller: _ageController,
            inputType: TextInputType.number,
          ),
          const SizedBox(
            height: SECTION_GAP_HEIGHT,
          ),
          CustomButton(
            text: Text("Next"),
            onPressed: () {
              if (formKeys[1].currentState!.validate() == false ||
                  emailNotUniqueErr?.isNotEmpty == true ||
                  _profile == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        "Please make sure email, username ${_profile == null ? 'and avatar' : ''} is set properly"),
                    backgroundColor: dangerColor,
                  ),
                );
              } else {
                setState(() {
                  _step = 3;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFirst(BuildContext context) {
    return Form(
      key: formKeys[0],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Align(
            child: SvgPicture.asset(
              SIGNUP_GRAPHIC_PATH,
              // width: 250,
              fit: BoxFit.scaleDown,
            ),
          ),
          const SizedBox(
            height: SECTION_GAP_HEIGHT,
          ),
          Text(
            "Sign up",
            style: PengoStyle.navigationTitle(context),
          ),
          Text(
            "Start your online booking journey from now on.",
            style: PengoStyle.body(context).copyWith(
              height: 1.2,
            ),
          ),
          const SizedBox(
            height: SECTION_GAP_HEIGHT,
          ),
          CustomTextField(
            label: "Phone",
            hintText: "",
            validator: _phoneValidator,
            controller: _phoneController,
            error: phoneNotUniqueErr,
            onChanged: (String? text) {
              setState(() {
                phoneNotUniqueErr = "";
              });
            },
            // contentPadding: const EdgeInsets.all(8),
          ),
          CustomTextField(
            label: "Password",
            hintText: "",
            obsecureText: true,
            validator: _passwordValidator,
            controller: _passwordController,
            // contentPadding: const EdgeInsets.all(8),
          ),
          const SizedBox(
            height: SECTION_GAP_HEIGHT,
          ),
          CustomButton(
            text: Text("Next"),
            onPressed: () {
              if (formKeys[0].currentState!.validate() == false ||
                  phoneNotUniqueErr?.isNotEmpty == true) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        "Please make sure you filled in phone & password correctly"),
                    backgroundColor: dangerColor,
                  ),
                );
              } else {
                setState(() {
                  _step = 2;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Stack(children: [
          Container(
            padding: const EdgeInsets.all(18),
            width: double.infinity,
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: BackButton(
                      onPressed: () {
                        if (_step == 1) Navigator.of(context).pop();
                        setState(() {
                          _step = _step - 1;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ],
    );
  }

  Future<void> _pickImageFromGallery() async {
    final XFile? poster = await _picker.pickImage(source: ImageSource.gallery);
    if (poster != null) {
      setState(() {
        _profile = poster;
      });
    } else {
      return;
    }
  }

  Future<void> _listenPhoneValid() async {
    if (_phoneController.text.isEmpty) return;
    final bool isValid = await AuthRepo().checkPhone(_phoneController.text);
    if (isValid == false) {
      setState(() {
        phoneNotUniqueErr = "Phone already used. Please try another";
      });
    }
  }

  Future<void> _listenEmailValid() async {
    if (_emailController.text.isEmpty) return;
    final bool isValid = await AuthRepo().checkEmail(_emailController.text);
    debugPrint("isValid $isValid");
    if (isValid == false) {
      setState(() {
        emailNotUniqueErr = "Email already used. Please try another";
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phoneController.removeListener(_listenPhoneValid);
    _emailController.removeListener(_listenEmailValid);
    _passwordController.dispose();
    _phoneController.dispose();
  }
}
