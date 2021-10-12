import 'package:flutter/material.dart';
import 'package:shop_app/shared/components/components.dart';

class SettingsScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          defaultFormField(
              controller: nameController,
              type: TextInputType.name,
              validate: (value){
                if(value.toString().isEmpty){
                  return 'Name must be not empty';
                }
              },
              labelText: 'Name',
            prefix: Icons.person
          ),

          defaultFormField(
              controller: emailController,
              type: TextInputType.emailAddress,
              validate: (value){
                if(value.toString().isEmpty){
                  return 'Email must be not empty';
                }
              },
              labelText: 'Email',
              prefix: Icons.email_outlined
          ),

          defaultFormField(
              controller: passwordController,
              type: TextInputType.visiblePassword,
              validate: (value){
                if(value.toString().isEmpty){
                  return 'Password must be not empty';
                }
              },
              labelText: 'Password',
              prefix: Icons.lock_open_outlined,
            suffix: Icons.remove_red_eye_outlined
          ),
        ],
      ),
    );
  }
}
