import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final RegistrationFormBloc registrationFormBloc = BlocProvider.of<RegistrationFormBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Registration form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            ElevatedButton(
              onPressed: () {
                registrationFormBloc.add(
                  SubmitFormEvent(
                    name: nameController.text,
                    email: emailController.text,
                  ),
                );
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => UserInfo(),
                  ),
                );
              },
              child: Text('Submit form'),
            ),
          ],
        ),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RegistrationFormBloc registrationFormBloc = BlocProvider.of<RegistrationFormBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('User info'),
      ),
      body: BlocBuilder<RegistrationFormBloc, RegistrationFormState>(
        builder: (context, state) {
          if (state is UserInfoState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${state.name}'),
                  Text('Email: ${state.email}'),
                ],
              ),
            );
          }
          return Container(); // Возврат пустого контейнера в случае других состояний
        },
      ),
    );
  }
}

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<RegistrationFormBloc>(
          create: (context) => RegistrationFormBloc(),
        ),
      ],
      child: MaterialApp(
        home: RegistrationForm(),
      ),
    ),
  );
}