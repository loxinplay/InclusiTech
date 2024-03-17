import 'package:cohort_messenger/components/my_button.dart';
import 'package:flutter/material.dart';
import 'package:cohort_messenger/components/my_text_field.dart';
import 'package:provider/provider.dart';
import 'package:cohort_messenger/services/auth/auth_service.dart';
class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key,required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final pwController = TextEditingController();

  void signIn() async{
    // get the auth service
    final authService = Provider.of<AuthService>(context,listen: false);

    try{
      await authService.signInwithEmailandPassword(
          emailController.text,
          pwController.text,
      );
    }catch (e){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
              Text(
                e.toString(),
              ),
          )
      );

    }
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                  const Icon(Icons.cast_for_education_outlined, size: 80,),
                  const SizedBox(height: 30,),
                  const Text("InclusiTech - "
                    ,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  const SizedBox(height:20,),
                  const Text(
                    'platform that makes education easier for'
                        ' people with ADHD - Attention-deficit/hyperactivity disorder',
                    style:TextStyle(fontSize: 30),
                  ),
                  const SizedBox(height: 30,),
                  const Text("About us", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 20,),
                  const Text("Courser's team focuses on the problem of the underdevelopment of the inclusive education system. We have created and are developing a free platform to make it easier for people with special needs to gain knowledge.",

                    style: TextStyle(fontSize: 30, ),),
                  // Email textfield
                  const SizedBox(height: 20,),
                  const Text("Our mission", style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 20,),
                  const Text("We set ourselves the goal of developing a system of inclusive education and making our contribution to the common cause of the UN. Particularly important sustainable development goals for us are health and well-being, as well as education.",
                  style: TextStyle(fontSize: 30 ),
                  ),

                  const SizedBox(height: 20,),
                  const Text("Log in if you have an account", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 20,),
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
                  // Log in button
                  const SizedBox(height: 30,),
                  MyButton(onTap: signIn, text: "Log In"),
        
                   const SizedBox(height: 30,),
                  // Do not have an account? Sign Up!
        
                   const Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text("Not a member?"),
                     ],
                   ),
                   const SizedBox(width: 4,),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "Register Now!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                                         ),
                  ),
                  const SizedBox(height: 40,)
        
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
