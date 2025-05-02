import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_resume_creator/core/colors/app_colors.dart';
import 'package:quick_resume_creator/core/constants/dimens.dart';
import 'package:quick_resume_creator/core/image/app_image.dart';
import 'package:quick_resume_creator/routes/app_route.dart';
import 'package:quick_resume_creator/screens/authentication/signup_screen/signup_bloc/signup_bloc.dart';
import 'package:quick_resume_creator/screens/authentication/signup_screen/signup_bloc/signup_even.dart';
import 'package:quick_resume_creator/screens/authentication/signup_screen/signup_bloc/signup_state.dart';
import 'package:quick_resume_creator/service/firebase/authentication.dart';
import 'package:quick_resume_creator/widgets/custom_app_text/app_text.dart';
import 'package:quick_resume_creator/widgets/custom_dailog_box/custom_dailo_box.dart';
import 'package:quick_resume_creator/widgets/textfield_input_decoration/textfield_input_decoration.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with SingleTickerProviderStateMixin {
  var _isFormLoading = false;

  bool _isPasswordObscure = true;
  bool _isConfirmPasswordObscure = true;

  final _signupFormKey = GlobalKey<FormBuilderState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _confirmFocusNode = FocusNode();

  @override
  void initState() {
    _emailFocusNode.addListener(_handleFocusChange);
    _passwordFocusNode.addListener(_handleFocusChange);
    _usernameFocusNode.addListener(_handleFocusChange);
    _confirmFocusNode.addListener(_handleFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    confirmPasswordController.dispose();

    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _usernameFocusNode.dispose();
    _confirmFocusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (_emailFocusNode.hasFocus ||
        _passwordFocusNode.hasFocus ||
        _usernameFocusNode.hasFocus ||
        _confirmFocusNode.hasFocus) {
      RawKeyboard.instance.addListener(_handleKey);
    } else {
      RawKeyboard.instance.removeListener(_handleKey);
    }
  }

  void _handleKey(RawKeyEvent event) {
    if (event.isKeyPressed(LogicalKeyboardKey.enter) ||
        event.isKeyPressed(LogicalKeyboardKey.numpadEnter)) {
      _validateAndSignup();
    }
  }

  void _validateAndSignup() {
    if (_signupFormKey.currentState!.validate()) {
      _signupFormKey.currentState!.save();

      final email = emailController.text;
      final username = usernameController.text;
      final password = passwordController.text;
      // final confirmPassword = confirmPasswordController.text;

      context
          .read<SignupBloc>()
          .add(SignupRequested(username, email, password, context));
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
                _buildSignup(),
                if (MediaQuery.of(context).size.width > kScreenWidthLg)
                  _buildSignupVector(),
              ],
            ),
          ),
          buildSizedBoxH(50),
        ],
      ),
    );
  }

  Widget _buildSignup() {
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
          buildSizedBoxH(10),
          AppText(
            text: "Sign up to ",
            fontsize: 31,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w500,
          ),
          const AppText(text: "Lorem Ipsum is simply", fontsize: 16),
          buildSizedBoxH(26),
          _buildSignupField(),
          buildSizedBoxH(31),
          _buildSignupButton(),
          buildSizedBoxH(56),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppText(
                text: "Already have an Account? ",
                fontsize: 16,
                fontWeight: FontWeight.w300,
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    GoRouter.of(context).go(RouteUri.login);
                  },
                  child: AppText(
                    text: "Login",
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

  Widget _buildSignupField() {
    return FormBuilder(
      key: _signupFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomAppTextField(
            controller: emailController,
            focusNode: _emailFocusNode,
            labelText: 'Email ID',
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                  errorText: "Please enter your email"),
              FormBuilderValidators.email(),
            ]),
            onFieldSubmitted: (value) {
              _validateAndSignup();
            },
          ),
          buildSizedBoxH(38),
          CustomAppTextField(
            controller: usernameController,
            focusNode: _usernameFocusNode,
            labelText: 'User name',
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                  errorText: "Please enter your username"),
            ]),
            onFieldSubmitted: (value) {
              _validateAndSignup();
            },
          ),
          buildSizedBoxH(38),
          CustomAppTextField(
            controller: passwordController,
            obscureText: _isPasswordObscure,
            focusNode: _passwordFocusNode,
            labelText: '  Password  ',
            maxLines: 1,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _isPasswordObscure = !_isPasswordObscure;
                });
              },
              child: Icon(
                _isPasswordObscure ? Icons.visibility_off : Icons.visibility,
                color: AppColors.black_color.withOpacity(0.5),
              ),
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                  errorText: "Please enter your password"),
              FormBuilderValidators.minLength(6),
            ]),
            onFieldSubmitted: (value) {
              _validateAndSignup();
            },
          ),
          buildSizedBoxH(38),
          CustomAppTextField(
            controller: confirmPasswordController,
            obscureText: _isConfirmPasswordObscure,
            focusNode: _confirmFocusNode,
            labelText: 'Confirm password',
            maxLines: 1,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _isConfirmPasswordObscure = !_isConfirmPasswordObscure;
                });
              },
              child: Icon(
                _isConfirmPasswordObscure
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: AppColors.black_color.withOpacity(0.5),
              ),
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                  errorText: "Please enter your confirm password"),
              FormBuilderValidators.minLength(6),
              (value) {
                if (value != passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ]),
            onFieldSubmitted: (value) {
              _validateAndSignup();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSignupButton() {
    return BlocConsumer<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is SignupLoading) {
          setState(() {
            _isFormLoading = true;
          });
        } else if (state is SignupSuccess) {
          setState(() {
            _isFormLoading = false;
          });
        } else if (state is SignupFaild || state is SignupError) {
          setState(() {
            _isFormLoading = false;
          });
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialog(
                message: "Registration Failed.",
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
            onTap: _isFormLoading ? null : _validateAndSignup,
            child: Container(
              height: 57,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: AuthenticationService().isLoading || _isFormLoading
                  ? Center(
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.white_color,
                        ),
                      ),
                    )
                  : Center(
                      child: AppText(
                          text: "Register",
                          color: AppColors.white_color,
                          fontsize: 16,
                          fontWeight: FontWeight.w500),
                    ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSignupVector() {
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
