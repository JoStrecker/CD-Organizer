import 'package:easy_localization/easy_localization.dart';
import 'package:hive/hive.dart';

part 'track.g.dart';

@HiveType(typeId: 1)
class Track {
  @HiveField(0)
  final String title;
  
  @HiveField(1)
  final int? length;
  
  @HiveField(2)
  final int number;

  const Track({
    required this.title,
    this.length,
    required this.number,
  });

  String getLengthFormatted(){
    if(length != null){
      int minutes = length!~/60000;
      String seconds2 = (length!%60000).toString();
      String secondsString = seconds2.padLeft(5, '0');
      return '$minutes:${secondsString.substring(0, 2)}min';
    }else{
      return 'unknown'.tr();
    }
  }
}
