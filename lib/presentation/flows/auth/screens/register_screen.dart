import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

import '../../../../app/di.dart';
import '../../../../core/blocs/app_bloc/app_bloc.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/validators/base_validator.dart';
import '../../../../core/validators/email_validator.dart';
import '../../../../core/validators/password_validators.dart';
import '../../../../core/validators/required_validator.dart';
import '../../../widgets/custom_header/custom_header.dart';
import '../../../widgets/expanded_button.dart';
import '../../../widgets/labeled_text_field.dart';
import '../bloc/auth_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final authBloc = locator<AuthBloc>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if(didPop) {
          authBloc.resetRegisterState();
        }
      },
      child: Scaffold(
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
                          'Create Account',
                          style: TextTheme.of(
                            context,
                          ).headlineSmall?.copyWith(color: Theme.of(context).colorScheme.onSurface),
                        ),
                        Text(
                          'Fill your information below.',
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
                                    previous.registerState.valid != current.registerState.valid,
                            builder: (context, state) {
                              return Column(
                                spacing: 20,

                                children: [
                                  LabeledTextField(
                                    label: 'Full Name',
                                    hint: "John Doe",
                                    keyboardType: TextInputType.name,
                                    onChanged: (text) {
                                      authBloc.setRegisterData(fullName: text.trim());
                                    },
                                    validator: (value) {
                                      return BaseValidator.validateValue(value, [
                                        locator<RequiredValidator>(),
                                        locator<MinimumValidator>(),
                                      ], state.registerState.valid != null);
                                    },
                                  ),

                                  LabeledTextField(
                                    label: 'Email',
                                    hint: "example@gmail.com",
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged: (text) {
                                      authBloc.setRegisterData(email: text.trim());
                                    },
                                    validator: (value) {
                                      return BaseValidator.validateValue(value, [
                                        locator<RequiredValidator>(),
                                        locator<EmailValidator>(),
                                      ], state.registerState.valid != null);
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
                                          authBloc.setRegisterData(password: text.trim());
                                        },
                                        validator: (value) {
                                          return BaseValidator.validateValue(value, [
                                            locator<RequiredValidator>(),
                                            locator<PasswordValidator>(),
                                          ], state.registerState.valid != null);
                                        },
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
                                      previous.registerState.status != current.registerState.status,

                              listener: (context, state) {
                                if (state.registerState.status == PageStatus.error) {
                                  toastification.show(
                                    context: context,
                                    style: ToastificationStyle.flatColored,
                                    alignment: Alignment.bottomCenter,
                                    type: ToastificationType.error,
                                    title: Text(state.registerState.error),
                                    autoCloseDuration: const Duration(seconds: 2),
                                  );

                                  authBloc.resetRegisterErrorState();
                                } else if (state.registerState.status == PageStatus.success) {
                                  toastification.show(
                                    context: context,
                                    style: ToastificationStyle.flatColored,
                                    alignment: Alignment.bottomCenter,
                                    type: ToastificationType.success,
                                    title: Text('Welcome'),
                                    autoCloseDuration: const Duration(seconds: 2),
                                  );
                                  authBloc.resetRegisterState();
                                }
                              },

                              buildWhen:
                                  (previous, current) =>
                                      previous.registerState.status != current.registerState.status,
                              builder: (context, state) {
                                return ExpandedButton(
                                  isLoading: state.registerState.status == PageStatus.loading,
                                  title: 'Sign Up',
                                  onPressed: () {
                                    authBloc.register();
                                  },
                                );
                              },
                            ),

                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Already have an account ",
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
                                            context.go(RoutesPath.loginPage);
                                            // Add your desired action here
                                          },
                                    style: TextTheme.of(context).bodySmall?.copyWith(
                                      color: Theme.of(context).colorScheme.primary,
                                      decorationColor: Theme.of(context).colorScheme.primary,
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
      ),
    );
  }
}
