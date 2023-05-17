import 'package:music_collection/core/ui/container_text_element.dart';
import 'package:music_collection/feature/albums/domain/album.dart';
import 'package:music_collection/feature/dashboard/application/dashboard_bloc.dart';
import 'package:music_collection/feature/wishlist/application/wishlist_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AlbumListItem extends StatelessWidget {
  final Album album;
  final bool wishlist;

  const AlbumListItem({
    super.key,
    required this.album,
    required this.wishlist,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        onTap: () async {
          wishlist
              ? context.read<WishlistBloc>().add(WishlistRefreshEvent(
                    await context.pushNamed<bool>('wishDetails', pathParameters: {'id': album.id}),
                  ))
              : context.read<DashboardBloc>().add(DashboardRefreshEvent(
                    await context.pushNamed<bool>('details', pathParameters: {'id': album.id}),
                  ));
        },
        onLongPress: () => showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text('delete').tr(),
                  content: const Text('wantToDelete').tr(),
                  actions: [
                    FilledButton.tonal(
                      onPressed: () => Navigator.pop(ctx, 'cancel'),
                      child: const Text('cancel').tr(),
                    ),
                    FilledButton(
                      onPressed: () {
                        Navigator.pop(ctx, 'yes');
                        wishlist
                            ? context
                                .read<WishlistBloc>()
                                .add(WishlistDeleteAlbumEvent(album))
                            : context
                                .read<DashboardBloc>()
                                .add(DashboardDeleteAlbumEvent(album));
                      },
                      child: const Text('yes').tr(),
                    )
                  ],
                )),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 4,
                top: 4,
                bottom: 4,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: SizedBox(
                  width: 96,
                  height: 96,
                  child: album.getCoverArt(
                      tint: Theme.of(context).colorScheme.onTertiaryContainer),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ContainerTextElement(
                      text: album.title,
                      icon: Icons.title,
                      textColor:
                          Theme.of(context).colorScheme.onTertiaryContainer,
                    ),
                    ContainerTextElement(
                      text: album.getAllArtists(),
                      icon: Icons.people,
                      textColor:
                          Theme.of(context).colorScheme.onTertiaryContainer,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ContainerTextElement(
                            text: album.year ?? 'unknown'.tr(),
                            icon: Icons.access_time,
                            textColor: Theme.of(context)
                                .colorScheme
                                .onTertiaryContainer,
                          ),
                        ),
                        Expanded(
                          child: ContainerTextElement(
                            text: album.type,
                            icon: Icons.album,
                            textColor: Theme.of(context)
                                .colorScheme
                                .onTertiaryContainer,
                          ),
                        ),
                      ],
                    ),
                    album.isLent()
                        ? ContainerTextElement(
                            text:
                                '${album.lendee} (${album.lended!.toLocal().day}.${album.lended!.toLocal().month}.${album.lended!.toLocal().year})',
                            icon: Icons.handshake,
                            textColor: Theme.of(context)
                                .colorScheme
                                .onTertiaryContainer,
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
