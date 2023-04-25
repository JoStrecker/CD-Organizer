import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'API_KEY', obfuscate: true)
  static final apiKey = _Env.apiKey;
  @EnviedField(varName: 'API_SECRET',obfuscate: true)
  static final apiSecret = _Env.apiSecret;
}