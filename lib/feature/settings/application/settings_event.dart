part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {
  const SettingsEvent();
}

class SettingsLoadEvent extends SettingsEvent {
  const SettingsLoadEvent();
}

class SettingsChangeColorEvent extends SettingsEvent {
  final Function(String message, BuildContext ctx) callback;
  final BuildContext ctx;
  final Color newColor;

  const SettingsChangeColorEvent(this.callback, this.ctx, this.newColor);
}

class SettingsChangeNotificationsEvent extends SettingsEvent {
  final Function(String message, BuildContext ctx) callback;
  final BuildContext ctx;
  final bool change;

  const SettingsChangeNotificationsEvent(this.callback, this.ctx, this.change);
}
