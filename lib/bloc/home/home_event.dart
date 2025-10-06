/// Events for the HomeBloc
abstract class HomeEvent {
  const HomeEvent();
}

/// Event to load home page data
class LoadHomeDataEvent extends HomeEvent {
  const LoadHomeDataEvent();
}
