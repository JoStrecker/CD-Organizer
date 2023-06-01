import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsInitialState()) {
    on<SettingsLoadEvent>((event, emit) async {
      emit(const SettingsLoadingState());

      bool usesMaterialYou = await DynamicColorPlugin.getCorePalette() != null;

      SharedPreferences prefs = await SharedPreferences.getInstance();

      Color prefColor = (prefs.getInt('prefColor') != null)
          ? Color(prefs.getInt('prefColor')!)
          : const Color(0xff009688);
      bool sendNotifications = prefs.getBool('sendNotifications') ?? false;

      emit(SettingsLoadedState(
        color: prefColor,
        usesMaterialYou: usesMaterialYou,
        sendNotifications: sendNotifications,
      ));
    });

    on<SettingsChangeColorEvent>((event, emit) async {
      SettingsState state = this.state;
      emit(const SettingsLoadingState());

      if (state is SettingsLoadedState) {
        if (state.color == event.newColor) {
          emit(state);
        } else {
          try {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setInt('prefColor', event.newColor.value);

            emit(SettingsLoadedState(
              color: event.newColor,
              usesMaterialYou: state.usesMaterialYou,
              sendNotifications: state.sendNotifications,
            ));

            if(kIsWeb){
              //restart app to load new color as theme
              Restart.restartApp();
            }else if (Platform.isIOS) {
              //iOS does not allow app restarting
              event.callback('restart_app'.tr());
            } else {
              //restart app to load new color as theme
              Restart.restartApp();
            }
          } catch (e) {
            emit(state);

            event.callback('error'.tr());
          }
        }
      } else {
        emit(state);
      }
    });

    on<SettingsChangeNotificationsEvent>((event, emit) async {
      SettingsState state = this.state;
      emit(const SettingsLoadingState());

      if (state is SettingsLoadedState) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('sendNotifications', event.change);

          emit(SettingsLoadedState(
            color: state.color,
            usesMaterialYou: state.usesMaterialYou,
            sendNotifications: event.change,
          ));

          event.callback('saved'.tr());
        } catch (e) {
          emit(state);

          event.callback('error'.tr());
        }
      } else {
        emit(state);
      }
    });
  }
}
