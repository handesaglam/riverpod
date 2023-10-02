import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vacco/src/features/auth/views/list_view.dart';

import '../../../core/data_state.dart';
import '../../../core/form_validator.dart';
import '../../../core/providers.dart';
import '../../../core/styles.dart';
import '../../../core/widgets/loading_widget.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends ConsumerState<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _hidePassword = true;

  void _handleUserLogin() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Map<String, dynamic> credentials = {
        'email': _emailController.text,
        'password': _passwordController.text,
      };

      ref.read(authNotifier.notifier).login(credentials);
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifier);

    ref.listen<DataState>(authNotifier, (_, state) {
    
    state.maybeWhen(
        success: (user) =>  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const ListUserView()),
  ),
        error: (err, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(err),
              backgroundColor: Colors.red,
            ),
          );
        },
        orElse: () {},
      );
    });

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
     
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
                 const SizedBox(height: 45),
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                
                borderRadius: BorderRadius.circular(10),
              ),
              child:  Center(
                child: Image.asset("assets/logo.png")
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Email address",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'yourname@email.com',
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: AppInputBorder.enabledBorder,
                focusedBorder: AppInputBorder.focusedBorder,
                errorBorder: AppInputBorder.errorBorder,
                focusedErrorBorder: AppInputBorder.focusedErrorBorder,
                contentPadding: EdgeInsets.all(10),
              ),
              validator: FormValidator.validateEmail,
            ),
            const SizedBox(height: 16),
            const Text(
              "Password",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: _hidePassword,
              decoration: InputDecoration(
                hintText: '*******************',
                labelStyle: const TextStyle(color: Colors.grey),
                enabledBorder: AppInputBorder.enabledBorder,
                focusedBorder: AppInputBorder.focusedBorder,
                errorBorder: AppInputBorder.errorBorder,
                focusedErrorBorder: AppInputBorder.focusedErrorBorder,
                contentPadding: const EdgeInsets.all(10),
                suffixIcon: IconButton(
                  icon: Icon(
                    _hidePassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: _togglePasswordVisibility,
                ),
              ),
              validator: FormValidator.validatePassword,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: authState.maybeWhen(
                  loading: () => null,
                  orElse: () => _handleUserLogin,
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: authState.maybeWhen(
                  loading: () => const LoadingWidget(),
                  orElse: () => const Text('LOGIN'),
                ),
              ),
            ),
           
           
            
            
          ],
        ),
      ),
    );
  }
}
