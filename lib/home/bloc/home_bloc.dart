import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stefanapp/api/api_client.dart';
import 'package:stefanapp/models/generated_users/users.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiClient _apiClient;
  HomeBloc(ApiClient apiClient)
      : assert(apiClient != null),
        _apiClient = apiClient,
        super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    final currentState = state;
    if (event is HomeFetched) {
      try {
        if (currentState is HomeInitial) {
          final users = await _apiClient.fetchUsers(5);
          yield HomeSuccess(users: users);
          return;
        }
        if (currentState is HomeSuccess) {
          final users = await _apiClient.fetchUsers(5);
          yield users.isEmpty
              ? currentState.copyWith()
              : HomeSuccess(users: currentState.users + users);
        }
      } catch (_) {
        yield HomeFailure();
      }
    }
  }
}
