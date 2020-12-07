import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stefanapp/api/api_client.dart';
import 'package:stefanapp/models/generated_users/users.dart';

part 'user_details_page_event.dart';
part 'user_details_page_state.dart';

class UserDetailsPageBloc
    extends Bloc<UserDetailsPageEvent, UserDetailsPageState> {
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
          final userDetails = await _apiClient.fetchUsersDetail(event.id);
          yield UserDetailsPageSuccess(user: userDetails);
        }
        if (currentState is UserDetailsPageSuccess) {
          final userDetails = await _apiClient.fetchUsersDetail(event.id);
          yield userDetails.isEmpty
              ? null
              : UserDetailsPageSuccess(user: currentState.user);
        }
      } catch (_) {
        throw Exception();
      }
    }
  }
}
