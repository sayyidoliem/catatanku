import 'package:auth/presentation/widgets/auth_form_field_widget.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth/presentation/controller/auth_state.dart';
import 'package:auth/presentation/controller/register_email_password_user_cubit.dart';
import 'package:go_router/go_router.dart';

class RegisterFormAuthWidget extends StatelessWidget {
  final FocusNode nameFocusNode;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;

  const RegisterFormAuthWidget({
    super.key,
    required this.nameFocusNode,
    required this.emailFocusNode,
    required this.passwordFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

    return BlocConsumer<RegisterEmailPasswordUserCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticatedState) {
          // Handle successful registration, navigate to another screen if necessary.
        } else if (state is AuthErrorState) {
          context.showSnackBar(state.message, false);
        }
      },
      builder: (context, state) {
        if (state is AuthLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                AuthFormFieldWidget(
                  controller: nameController,
                  focusNode: nameFocusNode,
                  keyboardType: TextInputType.name,
                  inputAction: TextInputAction.next,
                  isCapitalized: true,
                  validator: (value) => Validator.validateName(name: value),
                  label: 'Name',
                  hint: 'Enter your name',
                ),
                SizedBox(height: 16.0),
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
                  validator: (value) => Validator.validatePassword(password: value),
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
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        nameFocusNode.unfocus();
                        emailFocusNode.unfocus();
                        passwordFocusNode.unfocus();

                        if (registerFormKey.currentState != null && registerFormKey.currentState!.validate()) {
                          // Trigger Cubit to handle registration
                          context.read<RegisterEmailPasswordUserCubit>().registerEmailPasswordUser(
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            context: context,
                          );
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                        child: Text(
                          'REGISTER',
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
                    context.go(SIGN_IN_PAGE_ROUTE);
                  },
                  child: Text(
                    'Already have an account? Sign in',
                    style: TextStyle(
                      letterSpacing: 0.5,
                    ),
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
