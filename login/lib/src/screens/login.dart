import 'package:flutter/material.dart';
import '../blocs/bloc.dart';
import '../blocs/bloc_provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildEmailField(bloc),
              buildPasswordField(bloc),
              SizedBox(height: 20),
              buildSubmit(bloc),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEmailField(Bloc bloc) => StreamBuilder<String>(
        stream: bloc.email,
        builder: (context, snapshot) => TextField(
          keyboardType: TextInputType.emailAddress,
          onChanged: bloc.changeEmail,
          decoration: InputDecoration(
            hintText: 'example@domain.com',
            labelText: 'EmailId',
            errorText: snapshot.error,
          ),
        ),
      );

  Widget buildPasswordField(Bloc bloc) => StreamBuilder<String>(
        stream: bloc.password,
        builder: (context, snapshot) => TextField(
          keyboardType: TextInputType.emailAddress,
          onChanged: bloc.changePassword,
          decoration: InputDecoration(
            hintText: 'Enter password here',
            labelText: 'Password',
            errorText: snapshot.error,
          ),
        ),
      );

  Widget buildSubmit(Bloc bloc) => StreamBuilder<bool>(
        stream: bloc.submit,
        builder: (context, snapshot) => RaisedButton(
          child: Text('Login'),
          color: Colors.orange,
          onPressed: snapshot.hasData ? bloc.login : null,
        ),
      );
}
