import 'package:cd_organizer/core/ui/container_text_element.dart';
import 'package:cd_organizer/feature/albums/domain/album.dart';
import 'package:cd_organizer/feature/details/application/detail_bloc.dart';
import 'package:cd_organizer/feature/loading/ui/loading_screen.dart';
import 'package:cd_organizer/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DetailScreen extends StatelessWidget {
  final Album album;

  const DetailScreen({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailBloc>(
      create: (context) => sl<DetailBloc>()..add(DetailLoadEvent(album)),
      child: BlocBuilder<DetailBloc, DetailState>(
        builder: (context, state) {
          if (state is DetailLoadedState) {
            deleteAlbum(BuildContext bc) {
              context.read<DetailBloc>().add(DetailDeleteEvent(bc));
              Navigator.pop(bc, 'yes');
              bc.goNamed('collection');
            }

            return Padding(
              padding: const EdgeInsets.only(
                top: 16,
                left: 16,
                right: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    album.title,
                    style: Theme.of(context).textTheme.headlineLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        child: SizedBox(
                          width: 160,
                          height: 160,
                          child: album.getCoverArt(),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ContainerTextElement(
                              text: album.getAllArtists(),
                              icon: Icons.people,
                            ),
                            ContainerTextElement(
                              text: album.label,
                              icon: Icons.label,
                            ),
                            ContainerTextElement(
                              text: album.date.year.toString(),
                              icon: Icons.access_time,
                            ),
                            ContainerTextElement(
                              text: album.trackCount.toString(),
                              icon: Icons.format_list_numbered,
                            ),
                            ContainerTextElement(
                              text: album.type,
                              icon: Icons.album,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FilledButton.tonal(
                        onPressed: () => {},
                        child: Text(
                          'lend'.tr(),
                        ),
                      ),
                      const Expanded(
                        child: SizedBox(
                          height: 8,
                        ),
                      ),
                      FilledButton.tonal(
                        onPressed: () => {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text('delete').tr(),
                                    content: const Text('wantToDelete').tr(),
                                    actions: [
                                      FilledButton.tonal(
                                        onPressed: () =>
                                            Navigator.pop(context, 'cancel'),
                                        child: const Text('cancel').tr(),
                                      ),
                                      FilledButton(
                                        onPressed: () => deleteAlbum(context),
                                        child: const Text('yes').tr(),
                                      )
                                    ],
                                  )),
                        },
                        child: Text(
                          'delete'.tr(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) => Row(
                        children: [
                          Text(album.tracks![index].number),
                          const VerticalDivider(),
                          Expanded(
                            child: Text(
                              album.tracks![index].title,
                              overflow: TextOverflow.fade,
                              maxLines: 2,
                            ),
                          ),
                          Text(album.tracks![index].length ?? 'unknown'.tr()),
                        ],
                      ),
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: album.tracks?.length ?? 0,
                    ),
                  ),
                ],
              ),
            );
          } else if (state is DetailLoadingState) {
            return const LoadingScreen();
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
