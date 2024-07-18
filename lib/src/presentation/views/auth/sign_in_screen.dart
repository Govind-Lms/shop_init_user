import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_init/src/const/constant.dart';
import 'package:shop_init/src/const/vice_theme.dart';
import 'package:shop_init/src/core/state_management/cubits/google_sign_in/google_sign_in_cubit.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              Text('Log In',
                  style: AccountStyle.nameStyle.copyWith(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: 24,
                  )),
              const Gap(20),
              TextField(
                controller: _emailController,
                textAlign: TextAlign.center,
                style: ViceStyle.descStyle.copyWith(
                  color: Theme.of(context).primaryColorDark,
                ),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: ViceStyle.descStyle.copyWith(
                    color: Theme.of(context).primaryColorDark,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      width: 1,
                      color: Color(0xFF837E93),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      width: 1,
                      color: theme.primaryColorDark,
                    ),
                  ),
                ),
              ),
              const Gap(20),
              TextField(
                controller: _passController,
                textAlign: TextAlign.center,
                style: ViceStyle.descStyle.copyWith(
                  color: Theme.of(context).primaryColorDark,
                ),
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: ViceStyle.descStyle.copyWith(
                    color: Theme.of(context).primaryColorDark,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      width: 1,
                      color: Color(0xFF837E93),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      width: 1,
                      color: theme.primaryColorDark,
                    ),
                  ),
                ),
              ),
              const Gap(20),
              SizedBox(
                width: double.infinity - 40,
                height: kToolbarHeight,
                child: ElevatedButton(
                  onPressed: () {
                    if (_emailController.text.trim().isNotEmpty ||
                        _passController.text.trim().isNotEmpty) {
                      print('${_emailController.text}'
                          '\n'
                          '${_passController.text}');
                    } else {
                      print("Enter Email And Password");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: theme.primaryColorDark,
                  ),
                  child: Text('Sign In',
                      style: ViceStyle.descStyle
                          .copyWith(color: theme.primaryColor)),
                ),
              ),
              const Gap(20),
              Row(
                children: [
                  Text(
                    'Don’t have an account?',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF837E93),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Text('Forget Password?',
                      style: ViceStyle.descStyle.copyWith(
                          color: theme.primaryColorDark,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BlocConsumer<GoogleSignInCubit, GoogleSignInState>(
        listenWhen: (context, state) {
          return state is AuthSuccess;
        },
        listener: (context, state) async {
          final currentUser = firebaseAuth.currentUser;

          if (currentUser != null) {
            navNameReplacement(context, '/');
          }
        },
        builder: (context, state) {
          return Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: kToolbarHeight,
            child: ElevatedButton(
              onPressed: state is AuthLoading
                  ? null
                  : context.read<GoogleSignInCubit>().login,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: theme.primaryColorDark,
              ),
              child: state is AuthLoading
                  ? const CircularProgressIndicator()
                  : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(FontAwesomeIcons.google,color: theme.primaryColor),
                  const Gap(40),
                  Text('Sign In With Google',
                      style: ViceStyle.descStyle
                          .copyWith(color: theme.primaryColor)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
