import 'package:flutter_bloc/flutter_bloc.dart';

// События
abstract class RegistrationFormEvent {}

class SubmitFormEvent extends RegistrationFormEvent {
  final String name;
  final String email;

  SubmitFormEvent({required this.name, required this.email});
}

// Состояния
abstract class RegistrationFormState {}

class InitialState extends RegistrationFormState {}

class UserInfoState extends RegistrationFormState {
  final String name;
  final String email;

  UserInfoState({required this.name, required this.email});
}

class RegistrationFormBloc extends Bloc<RegistrationFormEvent, RegistrationFormState> {
  RegistrationFormBloc() : super(InitialState()) {
    on<SubmitFormEvent>(_onSubmitFormEvent);
  }

  void _onSubmitFormEvent(SubmitFormEvent event, Emitter<RegistrationFormState> emit) {
    emit(UserInfoState(name: event.name, email: event.email));
  }
}