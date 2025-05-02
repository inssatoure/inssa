// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_resume_creator/core/colors/app_colors.dart';
import 'package:quick_resume_creator/core/constants/dimens.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:quick_resume_creator/core/image/app_image.dart';
import 'package:quick_resume_creator/routes/app_route.dart';
import 'package:quick_resume_creator/screens/authentication/login_screen/login_bloc/login_bloc.dart';
import 'package:quick_resume_creator/screens/authentication/login_screen/login_bloc/login_state.dart';
import 'package:quick_resume_creator/widgets/custom_app_text/app_text.dart';
import 'package:quick_resume_creator/widgets/custom_dailog_box/custom_dailo_box.dart';
import 'package:quick_resume_creator/widgets/textfield_input_decoration/textfield_input_decoration.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _isFormLoading = false;
  bool _isObscure = true;

  final _loginFormKey = GlobalKey<FormBuilderState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    _emailFocusNode.addListener(_handleFocusChange);
    _passwordFocusNode.addListener(_handleFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _emailFocusNode.removeListener(_handleFocusChange);
    _passwordFocusNode.removeListener(_handleFocusChange);
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    RawKeyboard.instance.removeListener(_handleKey);
    super.dispose();
  }

  void _handleFocusChange() {
    if (_emailFocusNode.hasFocus || _passwordFocusNode.hasFocus) {
      RawKeyboard.instance.addListener(_handleKey);
    } else {
      RawKeyboard.instance.removeListener(_handleKey);
    }
  }

  void _handleKey(RawKeyEvent event) {
    if (event is RawKeyDownEvent &&
        (event.isKeyPressed(LogicalKeyboardKey.enter) ||
            event.isKeyPressed(LogicalKeyboardKey.numpadEnter))) {
      _validateAndLogin();
    }
  }

  void _validateAndLogin() {
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();

      final email = emailController.text;
      final password = passwordController.text;

      context.read<LoginBloc>().add(LoginRequested(email, password, context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.authBgcolor,
      body: ListView(
        children: [
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 42, vertical: 31),
                child: Image.asset(
                  "${AppImages.pngImage}img_logo.png",
                  height: 38,
                ),
              ),
            ],
          ),
          buildSizedBoxH(53),
          Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLogin(),
                if (MediaQuery.of(context).size.width > kScreenWidthLg)
                  _buildLoginVector(),
              ],
            ),
          ),
          buildSizedBoxH(50),
        ],
      ),
    );
  }

  Widget _buildLogin() {
    return Container(
      width: MediaQuery.of(context).size.width <= kScreenWidthSm
          ? MediaQuery.of(context).size.width / 1.14
          : MediaQuery.of(context).size.width <= kScreenWidthLg
              ? 505
              : MediaQuery.of(context).size.width <= kScreenWidthXxl
                  ? MediaQuery.of(context).size.width / 2.77
                  : 505,
      padding: const EdgeInsets.all(kDefaultPadding * 2),
      decoration: BoxDecoration(
        color: AppColors.white_color,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: AppColors.black_color.withOpacity(0.5), width: 0.5),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            color: AppColors.black_color.withOpacity(0.05),
            blurRadius: 64,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(
            text: "Welcome!",
            fontsize: 25,
            color: AppColors.black_color,
            fontWeight: FontWeight.w300,
          ),
          buildSizedBoxH(29),
          AppText(
            text: "Sign in to",
            fontsize: 31,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w500,
          ),
          const AppText(text: "Lorem Ipsum is simply", fontsize: 16),
          buildSizedBoxH(48),
          _buildLoginField(),
          buildSizedBoxH(23),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    GoRouter.of(context).go(RouteUri.forgetPassword);
                  },
                  child: const AppText(
                    text: "Forgot Password?",
                    fontsize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            ),
          ),
          buildSizedBoxH(38),
          _buildLoginButton(),
          buildSizedBoxH(56),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppText(
                text: "Don’t have an Account? ",
                fontsize: 16,
                fontWeight: FontWeight.w300,
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => GoRouter.of(context).go(RouteUri.signup),
                  child: AppText(
                    text: "Register",
                    fontsize: 16,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoginField() {
    return FormBuilder(
      key: _loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomAppTextField(
            controller: emailController,
            focusNode: _emailFocusNode,
            maxLines: 1,
            labelText: 'Email ID',
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                  errorText: "Please enter your email"),
              FormBuilderValidators.email(),
            ]),
            onFieldSubmitted: (value) {
              _validateAndLogin();
            },
          ),
          buildSizedBoxH(38),
          CustomAppTextField(
            controller: passwordController,
            focusNode: _passwordFocusNode,
            labelText: 'Password',
            maxLines: 1,
            obscureText: _isObscure,
            suffixIcon: GestureDetector(
              onTap: () => setState(() {
                _isObscure = !_isObscure;
              }),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Icon(
                    _isObscure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.black_color.withOpacity(0.5)),
              ),
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                  errorText: "Please enter your password"),
              FormBuilderValidators.minLength(6,
                  errorText:
                      "Password must have a length greater than or equal to 6"),
            ]),
            onFieldSubmitted: (p0) {
              _validateAndLogin();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton() {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          setState(() {
            _isFormLoading = true;
          });
        } else if (state is LoginSuccess) {
          setState(() {
            _isFormLoading = false;
          });
        } else if (state is LoginFaild || state is LoginError) {
          setState(() {
            _isFormLoading = false;
          });
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialog(
                message: "Login Failed.",
                positiveButtonText: 'Ok',
                onpositivePressed: () {
                  Navigator.pop(context);
                },
              );
            },
          );
        }
      },
      builder: (context, state) {
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: _isFormLoading ? null : _validateAndLogin,
            child: Container(
              height: 57,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: _isFormLoading
                  ? Center(
                      child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: AppColors.white_color,
                            strokeWidth: 2.5,
                          )),
                    )
                  : Center(
                      child: AppText(
                          text: "Login",
                          color: AppColors.white_color,
                          fontsize: 16,
                          fontWeight: FontWeight.w500)),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoginVector() {
    return Image.asset("${AppImages.pngImage}img_auth_vector.png",
        width: MediaQuery.of(context).size.width <= kScreenWidthSm
            ? MediaQuery.of(context).size.width / 1.1
            : MediaQuery.of(context).size.width <= kScreenWidthLg
                ? MediaQuery.of(context).size.width / 1.40
                : MediaQuery.of(context).size.width <= kScreenWidthXxl
                    ? MediaQuery.of(context).size.width / 1.98
                    : 704);
  }
}
