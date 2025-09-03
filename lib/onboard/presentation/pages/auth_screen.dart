import 'package:animal_app/config/onboard_string.dart';
import 'package:animal_app/onboard/data/models/ob_all_request_model.dart';
import 'package:animal_app/onboard/presentation/cubit/auth_cubit.dart';
import 'package:animal_app/onboard/presentation/cubit/auth_state.dart';
import 'package:animal_app/onboard/presentation/widgets/db_rain_drop_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:share_module/core/constants/app_assets.dart';
import 'package:share_module/core/constants/app_colors.dart';
import 'package:share_module/core/constants/app_routes.dart';
import 'package:share_module/core/theme/text_styles.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthScreen> {
  TextEditingController emailController = TextEditingController();
  FocusNode emailFocus = FocusNode();
  bool isEmailValidated = false;
  String emailValidateTxt = "";
  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocus = FocusNode();
  bool isPasswordValidated = false;
  String passwordValidateTxt = "";
  bool visiblePassword = true;
  bool btnColor = false;

  final regCubit = Modular.get<AuthCubit>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.background,
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: BlocConsumer(
              bloc: regCubit,
              listener: (context, state) {
                if (state is ObRegLoadedState) {
                  // showSnackBar(errorMessage: "Registered Successfully");
                  Modular.to.push(
                    MaterialPageRoute(
                      builder: (_) => const DbRainDropAnimation(
                        pageScreen: "${AppRoutes.dashboardModule}/",
                      ),
                    ),
                  );
                  // Modular.to.pushNamed("/dashboardModule/");
                } else if (state is ObRegErrorState) {
                  showSnackBar(errorMessage: state.errorMsg);
                }
              },
              builder: (context, state) {
                return signup();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget signup() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: /*constraints.maxHeight < MediaQuery.of(context).size.height
              ? const BouncingScrollPhysics()
              : */
              const NeverScrollableScrollPhysics(),
          child: Container(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            // height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 16.0,
              bottom: 16.0,
            ),
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: Border.all(color: AppColors.surface),
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.background.withValues(alpha: 0.3),
                  offset: const Offset(0, 5), // Shadow offset (dx, dy)
                  blurRadius: 10, // Blur radius
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  decoration: const BoxDecoration(color: AppColors.transparent),
                  height: MediaQuery.of(context).size.height * 0.33,
                  // width: MediaQuery.of(context).size.width * 0.33,
                  child: Image.asset(
                    AppAssets.appLoginBanner,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  OnboardString.loginHeadingTxt,
                  style: AppTextStyles.titleBold(),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.016),
                Text(
                  OnboardString.loginDesTxt,
                  style: AppTextStyles.bodyNormal(),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.016),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          OnboardString.authEmailTxt,
                          style: AppTextStyles.bodyNormal(),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.016,
                        ),
                        Container(
                          // height: MediaQuery.of(context).size.height * 0.33,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: emailFocus.hasFocus
                                  ? AppColors.primary
                                  : !isEmailValidated
                                  ? AppColors.surface
                                  : AppColors.error,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                            color: AppColors.background,
                          ),
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextField(
                                  focusNode: emailFocus,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: OnboardString.authEmailTxtFld,
                                    hintStyle: AppTextStyles.bodyRegularNormal(
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  controller: emailController,
                                  onChanged: (a) {
                                    fieldValidator(field: "email", value: a);
                                  },
                                ),
                              ),
                              const Icon(
                                Icons.mail_sharp,
                                color: AppColors.primary,
                                size: 20.0,
                              ),
                            ],
                          ),
                        ),
                        isEmailValidated
                            ? fieldErrorWidget(errorText: emailValidateTxt)
                            : SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.032,
                              ),
                        Text(
                          OnboardString.authPasswordTxt,
                          style: AppTextStyles.bodyNormal(),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.016,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: passwordFocus.hasFocus
                                  ? AppColors.primary
                                  : !isPasswordValidated
                                  ? AppColors.surface
                                  : AppColors.error,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                            color: AppColors.background,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  obscureText: visiblePassword,
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: OnboardString.authPasswordTxtFld,
                                    hintStyle: AppTextStyles.bodyRegularNormal(
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  controller: passwordController,
                                  onChanged: (a) {
                                    fieldValidator(field: "password", value: a);
                                  },
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    visiblePassword = !visiblePassword;
                                  });
                                },
                                child: Icon(
                                  visiblePassword
                                      ? Icons.lock_rounded
                                      : Icons.lock_open_rounded,
                                  color: AppColors.primary,
                                  size: 20.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        isPasswordValidated
                            ? fieldErrorWidget(errorText: passwordValidateTxt)
                            : SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.032,
                              ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.016,
                        ),
                        InkWell(
                          onTap: () {
                            getBtnValidation();
                          },
                          child: Container(
                            // height: MediaQuery.of(context).size.height * 0.058,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8),
                              ),
                              color: btnColor
                                  ? AppColors.primary
                                  : AppColors.primaryShade,
                            ),
                            padding: const EdgeInsets.all(12.0),
                            child: Center(
                              child: Text(
                                OnboardString.authSignUpBtn,
                                style: AppTextStyles.bodyMedium(
                                  color: btnColor
                                      ? AppColors.textOnPrimary
                                      : AppColors.textSecondary,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.024,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              OnboardString.authHaveAccountTxt,
                              style: AppTextStyles.captionNormal(),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.016,
                            ),
                            Text(
                              OnboardString.authLoginTxt,
                              style: AppTextStyles.captionBold(
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  fieldErrorWidget({required String errorText}) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.008),
        errorText.isNotEmpty
            ? Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  errorText,
                  style: const TextStyle(color: Colors.red, fontSize: 10),
                ),
              )
            : SizedBox(height: MediaQuery.of(context).size.height * 0.008),
        SizedBox(height: MediaQuery.of(context).size.height * 0.012),
      ],
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar({
    required String errorMessage,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage), backgroundColor: AppColors.primary),
    );
  }

  fieldValidator({required String field, String? value}) {
    setState(() {
      if (value != null) {
        if (field == "email") {
          String emailPattern =
              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
          var mobilePattern = r'^[1-9][0-9]*$|^$';
          RegExp mobileRegExp = RegExp(mobilePattern);
          RegExp emailRegExp = RegExp(emailPattern);

          if (value.isEmpty || value.length < 6) {
            emailValidateTxt = 'Please enter your email or mobile number';
            isEmailValidated = true;
          } else {
            if (value.length == 10 && mobileRegExp.hasMatch(value)) {
              isEmailValidated = false;
              emailValidateTxt = "";
            } else if (emailRegExp.hasMatch(value)) {
              emailValidateTxt = '';
              isEmailValidated = false;
            } else {
              emailValidateTxt =
                  "Please enter your valid email or mobile number ";
              isEmailValidated = true;
            }
          }
        } else if (field == "password") {
          // Password length greater than 6
          if (value.isEmpty || value.length < 6) {
            passwordValidateTxt = 'Password must be longer than 6 characters.';
            isPasswordValidated = true;
          } else if (!value.contains(RegExp(r'[A-Z]'))) {
            isPasswordValidated = true;
            passwordValidateTxt =
                'Password must be at least one Uppercase letter.';
          } else if (!value.contains(RegExp(r'[a-z]'))) {
            isPasswordValidated = true;
            passwordValidateTxt =
                'Password must be at least one Lowercase letter.';
          } else if (!value.contains(RegExp(r'[0-9]'))) {
            isPasswordValidated = true;
            passwordValidateTxt = 'Password must be at least one Digit';
          } else if (value.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
            isPasswordValidated = true;
            passwordValidateTxt = 'Special characters are not allowed.';
          } else {
            isPasswordValidated = false;
            passwordValidateTxt = '';
          }
        }
      }

      btnColor =
          (emailController.text.isNotEmpty &&
              !isEmailValidated &&
              emailValidateTxt.isEmpty) &&
          (passwordController.text.isNotEmpty &&
              !isPasswordValidated &&
              passwordValidateTxt.isEmpty);
    });
  }

  void getBtnValidation() {
    if (!btnColor) {
      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        showSnackBar(errorMessage: "Please fill the details");
        if (emailController.text.isEmpty) {}
      }
    } else {
      ObRegRequestModel request = ObRegRequestModel(
        email: emailController.text,
        password: passwordController.text,
      );

      regCubit.register(request: request);
    }
  }
}
