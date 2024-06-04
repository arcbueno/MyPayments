import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mypayments/pages/home/home_page.dart';
import 'package:mypayments/pages/login/bloc/login_bloc.dart';
import 'package:mypayments/pages/login/bloc/login_state.dart';
import 'package:mypayments/utils/text_data.dart';
import 'package:mypayments/widgets/custom_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final LoginBloc bloc;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    bloc = LoginBloc();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(TextData.myPayments),
          ),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Stack(
              children: [
                Column(
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CustomFormField(
                            label: TextData.email,
                            controller: emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return TextData.passwordRequired;
                              }
                              return null;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: CustomFormField(
                              label: TextData.password,
                              controller: passwordController,
                              isPassword: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return TextData.passwordRequired;
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (state.error != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Text(
                          state.error!,
                          style: const TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: ElevatedButton(
                        onPressed: () {
                          var success = formKey.currentState!.validate();
                          if (success) {
                            bloc
                                .login(emailController.text,
                                    passwordController.text)
                                .then(
                              (success) {
                                if (success) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const HomePage(),
                                    ),
                                  );
                                }
                              },
                            );
                          }
                        },
                        child: const Text(TextData.login),
                      ),
                    )
                  ],
                ),
                if (state.isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
        );
      },
      bloc: bloc,
    );
  }
}
