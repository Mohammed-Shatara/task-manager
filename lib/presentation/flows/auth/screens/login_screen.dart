import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/app/di.dart';
import 'package:task_manager/core/blocs/app_bloc/app_bloc.dart';
import 'package:task_manager/core/validators/password_validators.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/navigation/routes.dart';
import '../../../../core/validators/base_validator.dart';
import '../../../../core/validators/email_validator.dart';
import '../../../../core/validators/required_validator.dart';
import '../../../widgets/custom_header/custom_header.dart';
import '../../../widgets/expanded_button.dart';
import '../../../widgets/labeled_text_field.dart';
import '../../../widgets/under_line_text_button.dart';
import '../bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final authBloc = locator<AuthBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          spacing: 32,
          children: [
            const CustomHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(right: 24, left: 24, bottom: 42),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    spacing: 12,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sign In',
                        style: TextTheme.of(context).headlineSmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        'Hi! Welcome back, you’ve been missed',
                        style: TextTheme.of(context).bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: BlocBuilder<AuthBloc, AuthState>(
                          bloc: authBloc,
                          buildWhen:
                              (previous, current) =>
                                  previous.loginState.valid !=
                                  current.loginState.valid,
                          builder: (context, state) {
                            return Column(
                              spacing: 20,

                              children: [
                                LabeledTextField(
                                  label: 'Email',
                                  hint: "example@gmail.com",
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (text) {
                                    authBloc.setLoginData(email: text.trim());
                                  },
                                  validator: (value) {
                                    return BaseValidator.validateValue(value, [
                                      locator<RequiredValidator>(),
                                      locator<EmailValidator>(),
                                    ], state.loginState.valid != null);
                                  },
                                ),

                                Column(
                                  spacing: 12,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    LabeledTextField(
                                      label: 'Password',
                                      hint: "Password",
                                      password: true,
                                      onChanged: (text) {
                                        authBloc.setLoginData(
                                          password: text.trim(),
                                        );
                                      },
                                      validator: (value) {
                                        return BaseValidator.validateValue(
                                          value,
                                          [
                                            locator<RequiredValidator>(),
                                            locator<PasswordValidator>(),
                                          ],
                                          state.loginState.valid != null,
                                        );
                                      },
                                    ),
                                    UnderLineTextButton(
                                      title: 'Forget Password',
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                                SizedBox(height: 24),
                              ],
                            );
                          },
                        ),
                      ),
                      Column(
                        spacing: 12,
                        children: [
                          BlocConsumer<AuthBloc, AuthState>(
                            bloc: authBloc,
                            listenWhen:
                                (previous, current) =>
                                    previous.loginState.status !=
                                    current.loginState.status,

                            listener: (context, state) {
                              if (state.loginState.status == PageStatus.error) {
                                toastification.show(
                                  context: context,
                                  style: ToastificationStyle.flatColored,
                                  alignment: Alignment.bottomCenter,
                                  type: ToastificationType.error,
                                  title: Text(state.loginState.error),
                                  autoCloseDuration: const Duration(seconds: 2),
                                );

                                authBloc.resetLoginErrorState();
                              } else if (state.loginState.status ==
                                  PageStatus.success) {
                                toastification.show(
                                  context: context,
                                  style: ToastificationStyle.flatColored,
                                  alignment: Alignment.bottomCenter,
                                  type: ToastificationType.success,
                                  title: Text('Welcome'),
                                  autoCloseDuration: const Duration(seconds: 2),
                                );
                                authBloc.resetLoginState();
                              }
                            },
                            buildWhen:
                                (previous, current) =>
                                    previous.loginState.status !=
                                    current.loginState.status,

                            builder: (context, state) {
                              return ExpandedButton(
                                isLoading:
                                    state.loginState.status ==
                                    PageStatus.loading,
                                title: 'Sign In',
                                onPressed: () {
                                  authBloc.login();
                                },
                              );
                            },
                          ),

                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "don't have an account ",
                                  style: TextStyle(
                                    color: const Color(0xFF282932),
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Sign Up',
                                  recognizer:
                                      TapGestureRecognizer()
                                        ..onTap = () {
                                          context.go(RoutesPath.registerPage);
                                          // Add your desired action here
                                        },
                                  style: TextTheme.of(
                                    context,
                                  ).bodySmall?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    decorationColor:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
