import 'package:cohort_messenger/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:cohort_messenger/components/my_text_field.dart';
import 'package:cohort_messenger/components/my_button.dart';
import 'package:provider/provider.dart';
class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final pwController = TextEditingController();
  final cpController = TextEditingController();

  // sign up
  void signUp()async{
    if (pwController.text != cpController.text){
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(
              "Passwords do not match!"
          ),
          ),
      );
      return;
    }
    // get auth service
    final authService = Provider.of<AuthService>(context,listen: false);
try{
await authService.signUpWithEmailandPassword(
  emailController.text,
  pwController.text,
);
} catch (e){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(e.toString()
  )
  )
  );
}
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 170.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50,),
                    // logo ( Icon )
                    const Icon(Icons.switch_account_sharp, size: 80,),
                    const SizedBox(height: 30,),
                    const Text("Create an account to study in InclusiTech",
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(height: 40,),
                    // Email textfield
                    myTextField(
                      hintText: "Email",
                      obscureText: false,
                      controller: emailController,
                    ),
                    const SizedBox(height: 25),
                    // Password textfield
                    myTextField(
                      hintText: "Password",
                      obscureText: true,
                      controller: pwController,
                    ),
                    const SizedBox(height: 25),
                    myTextField(
                      hintText: "Confirm Password",
                      obscureText: true,
                      controller: cpController,
                    ),
                    // Log in button
                    const SizedBox(height: 30,),
                    MyButton(onTap: signUp, text: "Register"),
          
                    const SizedBox(height: 30,),
                    // Do not have an account? Sign Up!
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already a member"),
                        const SizedBox(width: 4,),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            "Login Now!",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}
