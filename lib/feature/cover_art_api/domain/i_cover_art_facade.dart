import 'dart:ui';

abstract class ICoverArtFacade{
  Future<Image> loadFrontImage({required String mbid});
}