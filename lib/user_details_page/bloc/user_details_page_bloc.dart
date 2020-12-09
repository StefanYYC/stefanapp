import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stefanapp/api/api_client.dart';
import 'package:stefanapp/models/generated_users/users.dart';

part 'user_details_page_event.dart';
part 'user_details_page_state.dart';

class UserDetailsPageBloc
    extends Bloc<UserDetailsPageEvent, UserDetailsPageState> {
  @override
  void onError(Object error, StackTrace stackTrace) {
    print(error);
    super.onError(error, stackTrace);
  }

  UserDetailsPageBloc(ApiClient apiClient)
      : assert(apiClient != null),
        _apiClient = apiClient,
        super(UserDetailsPageInitial());

  final ApiClient _apiClient;

  @override
  Stream<UserDetailsPageState> mapEventToState(
    UserDetailsPageEvent event,
  ) async* {
    final currentState = state;
    if (event is UserDetailsPageFetched) {
      try {
        if (currentState is UserDetailsPageInitial) {
          print("event id: ${event.id}");
          final userDetails = await _apiClient.fetchUsersDetail(event.id);
          print(userDetails);
          yield UserDetailsPageSuccess(user: userDetails);
        }
        if (currentState is UserDetailsPageSuccess) {
          final userDetails = await _apiClient.fetchUsersDetail(event.id);
          yield userDetails.isEmpty
              ? null
              : UserDetailsPageSuccess(user: currentState.user);
        }
      } catch (_, stack) {
        throw Exception();
      }
    }
  }
}
