import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsInitialState()) {
    on<SettingsLoadEvent>((event, emit) async {
      emit(const SettingsLoadingState());

      SharedPreferences prefs = await SharedPreferences.getInstance();
      Color prefColor = (prefs.getInt('prefColor') != null)
          ? Color(prefs.getInt('prefColor')!)
          : Colors.tealAccent;

      emit(SettingsLoadedState(prefColor));
    });

    on<SettingsSaveChangesEvent>((event, emit) async {
      SettingsState state = this.state;
      emit(const SettingsLoadingState());

      if(state is SettingsLoadedState) {
        if(state.color == event.newColor){
          emit(state);
        }else {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setInt('prefColor', event.newColor.value);
          emit(SettingsLoadedState(event.newColor));

          //restart app to load new color as theme
          Restart.restartApp();
        }
      }else{
        emit(state);
      }
    });
  }
}
