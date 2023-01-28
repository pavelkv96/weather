import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather/src/navigation/navigation.dart';

part 'navigation_bloc.freezed.dart';

@freezed
class NavigationEvent {
  const NavigationEvent._();

  const factory NavigationEvent.splash() = _SplashNavigationEvent;

  const factory NavigationEvent.forecast() = _ForecastNavigationEvent;

  const factory NavigationEvent.cities() = _CitiesNavigationEvent;
}

class NavigationState with EquatableMixin {
  final List<PageRouteInfo<Object?>> pages;

  const NavigationState._({required this.pages});

  NavigationState._initial() : this._(pages: <PageRouteInfo<Object?>>[const SplashPage()]);

  @override
  List<Object> get props => [pages];
}

@injectable
class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState._initial()) {
    on<_SplashNavigationEvent>((event, emit) => emit(NavigationState._(pages: List.of([const SplashPage()]))));

    on<_ForecastNavigationEvent>((event, emit) => emit(NavigationState._(pages: List.of([const HomePage()]))));

    on<_CitiesNavigationEvent>(
      (event, emit) => emit(NavigationState._(pages: List.of([const ConfigurationCitiesPage()]))),
    );
  }
}
