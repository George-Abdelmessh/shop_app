import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/shop_app/shop_layout.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import 'cubit/cubit.dart';

class ShopLoginScreen extends StatelessWidget {

  final formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var cubit = LoginCubit.get(context);
    
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if(state is LoginSuccessState){
          if(state.loginModel.status!){
            CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token).then((value){
                  navigateAndFinish(context, ShopLayout());
            });
          }
          else{
            showToast(
                text: state.loginModel.message.toString(),
                state: TaostState.ERROR,
            );
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 60.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if(value!.isEmpty){
                              return 'Please enter your email address';
                            }
                            return null;
                          },
                          labelText: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          obscureText: cubit.isPasswordShow,
                          labelText: 'Password',
                          prefix: Icons.lock_outline,
                          suffix: cubit.suffix,
                          validate: (value) {
                            if(value!.isEmpty){
                              return 'password is too short';
                            }
                          },
                          suffixPressed: (){
                            cubit.changePasswordVisibility();
                          },
                          onSubmit: (value){
                            if(formKey.currentState!.validate()){
                              cubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ///////////////////////////
                        state is! LoginLoadingState ? defaultButton(
                          method: () {
                            if(formKey.currentState!.validate()){
                              cubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text
                              );
                            }
                          },
                          text: 'login',
                        ) : Center(child: CircularProgressIndicator(),),
                        ///////////////////////////
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't Have An Account?"),
                            defaultTextButton(
                                method: () {
                                  navigateTo(context, RegisterScreen());
                                },
                                text: 'register now!'
                            ),
                          ],
                        ),
                      ]
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
