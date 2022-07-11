import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_shop_app/api_repository/api_repository.dart';
import 'package:flutter_shop_app/models/nofification_model.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final ApiRepository repository = ApiRepository();

  NotificationBloc() : super(NotificationInitial()) {
    on<LoadNotificationsList>(
      (event, emit) async {
        emit(NotificationLoading());
        var notifications = await repository.fetchNotificationsList();
        emit(
          NotificationLoaded(notifications: notifications),
        );
      },
    );
  }
}
