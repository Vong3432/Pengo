import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:pengo/bloc/auth/auth_bloc.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/config/shadow.dart';
import 'package:pengo/const/logo_const.dart';
import 'package:pengo/const/space_const.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/models/providers/auth_model.dart';
import 'package:pengo/ui/auth/signup_view.dart';
import 'package:pengo/ui/widgets/button/custom_button.dart';
import 'package:pengo/ui/widgets/input/custom_textfield.dart';
import 'package:pengo/ui/widgets/layout/sliver_body.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _phoneValidator = MultiValidator([
    RequiredValidator(errorText: 'Phone cannot be empty'),
    MaxLengthValidator(10, errorText: 'Your phone is incorrect format')
  ]);
  final _passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password cannot be empty'),
    MinLengthValidator(8, errorText: 'Minimum password length is 8')
  ]);

  final TextEditingController _phoneController =
      TextEditingController(text: '0149250544');
  final TextEditingController _passwordController =
      TextEditingController(text: '12345678');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        // physics: const NeverScrollableScrollPhysics(),
        slivers: <Widget>[
          CustomSliverBody(content: <Widget>[
            Container(
              // width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: primaryLightColor,
                // gradient: primaryLinear,
              ),
              child: Column(
                children: <Widget>[
                  _buildHeader(),
                  _buildContent(context),
                ],
              ),
            ),
          ])
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Form(
        key: _formKey,
        child: Container(
          decoration: BoxDecoration(
            color: whiteColor,
            boxShadow: bottomBarShadow(Theme.of(context)),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: SECTION_GAP_HEIGHT,
              ),
              CustomTextField(
                controller: _phoneController,
                label: "Phone",
                hintText: "0123456789",
                validator: _phoneValidator,
              ),
              CustomTextField(
                controller: _passwordController,
                obsecureText: true,
                label: "Password",
                hintText: "Password",
                validator: _passwordValidator,
              ),
              const SizedBox(
                height: SECTION_GAP_HEIGHT * 2,
              ),
              BlocConsumer(
                bloc: BlocProvider.of<AuthBloc>(context),
                listener: (context, state) {
                  debugPrint(state.toString());
                  // TODO: implement listener        }
                  if (state is AuthenticatedState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Logged in"),
                        backgroundColor: primaryColor,
                      ),
                    );
                    context.read<AuthModel>().setUser(state.auth);
                    Navigator.of(context).pop(true);

                    // Future.delayed(const Duration(seconds: 2)).then(
                    //   (_) => {
                    //     // Navigator.of(context).pushReplacement(
                    //     //   CupertinoPageRoute(
                    //     //       builder: (BuildContext context) => const Splash()),
                    //     // ),
                    //     Navigator.of(context).pop(true)
                    //   },
                    // );
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
                builder: (context, state) {
                  if (state is AuthenticatingState) {
                    return const CircularProgressIndicator();
                  }
                  return CustomButton(
                    onPressed: () {
                      debugPrint("Login");
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        debugPrint("logging");
                        BlocProvider.of<AuthBloc>(context).add(LoginEvent(
                            _phoneController.text, _passwordController.text));
                      }
                    },
                    text: Text(
                      "Sign In",
                    ),
                  );
                },
              ),
              const SizedBox(
                height: SECTION_GAP_HEIGHT,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Don't have an account? ",
                    style: PengoStyle.subtitle(context),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => SignUpView()));
                    },
                    child: Text(
                      "Register here",
                      style: PengoStyle.subtitle(context).copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
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
                    child: BackButton(),
                  ),
                  SvgPicture.asset(
                    PENGO_SVG_PATH,
                    fit: BoxFit.scaleDown,
                    width: 120,
                    height: 120,
                  ),
                  Text(
                    "Sign-in",
                    style: PengoStyle.navigationTitle(context),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Continue your online booking journey.",
                    style: PengoStyle.body(context),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: SECTION_GAP_HEIGHT,
                  ),
                ],
              ),
            ),
          ),
        ]),
      ],
    );
  }
}
