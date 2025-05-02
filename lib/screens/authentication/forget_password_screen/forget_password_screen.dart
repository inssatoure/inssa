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
import 'package:quick_resume_creator/screens/authentication/forget_password_screen/forget_password_bloc/forget_password_bloc.dart';
import 'package:quick_resume_creator/screens/authentication/forget_password_screen/forget_password_bloc/forget_password_state.dart';
import 'package:quick_resume_creator/widgets/custom_app_text/app_text.dart';
import 'package:quick_resume_creator/widgets/custom_dailog_box/custom_dailo_box.dart';
import 'package:quick_resume_creator/widgets/textfield_input_decoration/textfield_input_decoration.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _forgetPasswordFormKey = GlobalKey<FormBuilderState>();

  TextEditingController emailController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();

  var _isFormLoading = false;

  @override
  void initState() {
    _emailFocusNode.addListener(_handleFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (_emailFocusNode.hasFocus) {
      RawKeyboard.instance.addListener(_handleKey);
    } else {
      RawKeyboard.instance.removeListener(_handleKey);
    }
  }

  void _handleKey(RawKeyEvent event) {
    if (event.isKeyPressed(LogicalKeyboardKey.enter) ||
        event.isKeyPressed(LogicalKeyboardKey.numpadEnter)) {
      _validateAndForgetPassword();
    }
  }

  void _validateAndForgetPassword() {
    if (_forgetPasswordFormKey.currentState!.validate()) {
      _forgetPasswordFormKey.currentState!.save();
      final email = emailController.text;

      context
          .read<ForgetPasswordBloc>()
          .add(ForgetPasswordRequested(email, context));
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
          buildSizedBoxH(106),
          Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildForgetPassword(),
                if (MediaQuery.of(context).size.width > kScreenWidthLg)
                  _buildForgetPasswordVector(),
              ],
            ),
          ),
          buildSizedBoxH(50),
        ],
      ),
    );
  }

  Widget _buildForgetPassword() {
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
            text: "Forget Password in to",
            fontsize: 31,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w500,
          ),
          const AppText(text: "Lorem Ipsum is simply", fontsize: 16),
          buildSizedBoxH(48),
          _buildForgetPasswordField(),
          buildSizedBoxH(31),
          _buildForgetPasswordButton(),
          buildSizedBoxH(56),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    GoRouter.of(context).go(RouteUri.login);
                  },
                  child: AppText(
                    text: "Back to Login",
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

  Widget _buildForgetPasswordField() {
    return FormBuilder(
      key: _forgetPasswordFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomAppTextField(
            controller: emailController,
            focusNode: _emailFocusNode,
            labelText: 'Email ID',
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                  errorText: "Please enter your registered email"),
              FormBuilderValidators.email(),
              FormBuilderValidators.match(r'^[a-zA-Z0-9._%+-]+@gmail\.com$',
                  errorText: 'Enter a valid Gmail address'),
            ]),
            onFieldSubmitted: (value) {
              _validateAndForgetPassword();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildForgetPasswordButton() {
    return BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordLoading) {
          setState(() {
            _isFormLoading = true;
          });
        } else if (state is ForgetPasswordSuccess) {
          setState(() {
            _isFormLoading = false;
          });
        } else if (state is ForgetPasswordFaild ||
            state is ForgetPasswordError) {
          setState(() {
            _isFormLoading = false;
          });
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialog(
                message: "ForgetPassword Failed.",
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
            onTap: _isFormLoading ? null : _validateAndForgetPassword,
            child: Container(
              height: 57,
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
                          text: "Forget Password",
                          color: AppColors.white_color,
                          fontsize: 16,
                          fontWeight: FontWeight.w500)),
            ),
          ),
        );
      },
    );
  }

  Widget _buildForgetPasswordVector() {
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
