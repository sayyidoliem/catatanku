import 'package:auth/presentation/widgets/auth_form_field_widget.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth/presentation/controller/auth_state.dart';
import 'package:auth/presentation/controller/sign_in_email_password_user_cubit.dart';
import 'package:go_router/go_router.dart';

class SignInFormAuthWidget extends StatelessWidget {
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;

  const SignInFormAuthWidget({
    super.key,
    required this.emailFocusNode,
    required this.passwordFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final signInFormKey = GlobalKey<FormState>();

    return BlocConsumer<SignInEmailPasswordUserCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticatedState) {
          // Handle successful authentication
          // Navigate to another screen or show success message.
        } else if (state is AuthErrorState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        // Check if the state is loading
        if (state is AuthLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else {
          // If not loading, show the sign-in form
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                AuthFormFieldWidget(
                  controller: emailController,
                  focusNode: emailFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  inputAction: TextInputAction.next,
                  validator: (value) => Validator.validateEmail(email: value),
                  label: 'Email',
                  hint: 'Enter your email',
                ),
                SizedBox(height: 16.0),
                AuthFormFieldWidget(
                  controller: passwordController,
                  focusNode: passwordFocusNode,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.done,
                  validator:
                      (value) => Validator.validatePassword(password: value),
                  isObscure: true,
                  label: 'Password',
                  hint: 'Enter your password',
                ),
                SizedBox(height: 24.0),
                Padding(
                  padding: EdgeInsets.only(left: 0.0, right: 0.0),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.orange),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        emailFocusNode.unfocus();
                        passwordFocusNode.unfocus();

                        if (signInFormKey.currentState!.validate()) {
                          // Trigger Cubit to handle sign-in
                          context
                              .read<SignInEmailPasswordUserCubit>()
                              .signInEmailPasswordUser(
                                email: emailController.text,
                                password: passwordController.text,
                                context: context,
                              );
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                InkWell(
                  onTap: () {
                    context.go(REGISTER_PAGE_ROUTE);
                  },
                  child: Text(
                    'Don\'t have an account? Sign up',
                    style: TextStyle(letterSpacing: 0.5),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
