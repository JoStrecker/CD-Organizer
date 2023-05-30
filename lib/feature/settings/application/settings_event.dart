part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {
  const SettingsEvent();
}

class SettingsLoadEvent extends SettingsEvent {
  const SettingsLoadEvent();
}

class SettingsChangeColorEvent extends SettingsEvent {
  final void Function(String message) callback;
  final Color newColor;

  const SettingsChangeColorEvent(
    this.callback,
    this.newColor,
  );
}

class SettingsChangeNotificationsEvent extends SettingsEvent {
  final void Function(String message) callback;
  final bool change;

  const SettingsChangeNotificationsEvent(
    this.callback,
    this.change,
  );
}
