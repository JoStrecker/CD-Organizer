import 'package:cd_organizer/core/ui/container_text_element.dart';
import 'package:cd_organizer/feature/albums/domain/album.dart';
import 'package:cd_organizer/feature/details/application/detail_bloc.dart';
import 'package:cd_organizer/feature/error/ui/error_screen.dart';
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
                    state.album.title,
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
                          child: state.album.getCoverArt(
                              tint: Theme.of(context).colorScheme.onSurface),
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
                              text: state.album.getAllArtists(),
                              icon: Icons.people,
                            ),
                            ContainerTextElement(
                              text: state.album.label ?? 'unknown'.tr(),
                              icon: Icons.label,
                            ),
                            ContainerTextElement(
                              text: state.album.year ?? 'unknown'.tr(),
                              icon: Icons.access_time,
                            ),
                            ContainerTextElement(
                              text: state.album.country ?? 'unknown'.tr(),
                              icon: Icons.language,
                            ),
                            ContainerTextElement(
                              text: state.album.type,
                              icon: Icons.album,
                            ),
                            ContainerTextElement(
                              text: state.price?.toStringAsFixed(2) ??
                                  'unknown'.tr(),
                              icon: Icons.euro,
                            ),
                            ContainerTextElement(
                              text: state.album.trackCount ?? 'unknown'.tr(),
                              icon: Icons.format_list_numbered,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  state.album.lendee != null
                      ? lendingRow(state.album)
                      : Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () => showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                                  title: const Text('delete').tr(),
                                  content: const Text('wantToDelete').tr(),
                                  actions: [
                                    FilledButton.tonal(
                                      onPressed: () =>
                                          Navigator.pop(ctx, 'cancel'),
                                      child: const Text('cancel').tr(),
                                    ),
                                    FilledButton(
                                      onPressed: () {
                                        Navigator.pop(ctx, 'yes');
                                        context
                                            .read<DetailBloc>()
                                            .add(const DetailDeleteEvent());
                                        context.pop(true);
                                      },
                                      child: const Text('yes').tr(),
                                    ),
                                  ],
                                )),
                        child: Text(
                          'delete'.tr(),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      FilledButton.tonal(
                        onPressed: () => state.album.lendee == null
                            ? lendDialog(context)
                            : gotBackDialog(context),
                        child: Text(
                          state.album.lendee == null
                              ? 'lend'.tr()
                              : 'giveBack'.tr(),
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
                          Text(state.album.tracks![index].number),
                          const VerticalDivider(),
                          Expanded(
                            child: Text(
                              state.album.tracks![index].title,
                              overflow: TextOverflow.fade,
                              maxLines: 2,
                            ),
                          ),
                          Text(state.album.tracks![index].length ??
                              'unknown'.tr()),
                        ],
                      ),
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: state.album.tracks?.length ?? 0,
                    ),
                  ),
                ],
              ),
            );
          } else if (state is DetailLoadingState) {
            return const LoadingScreen();
          } else if (state is DetailErrorState) {
            return ErrorScreen(
              message: state.message,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

Widget lendingRow(Album album) {
  return Column(
    children: [
      Row(
        children: [
          const Text('lendedTo').tr(),
          Text(album.lendee!),
        ],
      ),
      Row(
        children: [
          const Text('since').tr(),
          Text(
            '${album.lended!.toLocal().day}.${album.lended!.toLocal().month}.${album.lended!.toLocal().year}',
          ),
        ],
      ),
      const SizedBox(
        height: 8,
      ),
    ],
  );
}

Future lendDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (ctx) {
      TextEditingController controller = TextEditingController();
      return SimpleDialog(
        contentPadding: const EdgeInsets.only(
          left: 24,
          top: 12,
          right: 24,
          bottom: 24,
        ),
        title: const Text('lend').tr(),
        children: [
          TextField(
            onSubmitted: (query) {
              if (query.isNotEmpty) {
                context.read<DetailBloc>().add(DetailLendEvent(query));
              }
            },
            controller: controller,
            textCapitalization: TextCapitalization.sentences,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'name'.tr(),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FilledButton.tonal(
                onPressed: () => Navigator.pop(ctx, 'cancel'),
                child: const Text('cancel').tr(),
              ),
              const SizedBox(
                width: 8,
              ),
              FilledButton(
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    context
                        .read<DetailBloc>()
                        .add(DetailLendEvent(controller.text));
                  }
                  Navigator.pop(ctx, 'lend');
                },
                child: const Text('lend').tr(),
              ),
            ],
          ),
        ],
      );
    },
  );
}

Future gotBackDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: const Text('giveBack').tr(),
        content: const Text('gotBackDialog').tr(),
        actions: [
          FilledButton.tonal(
            onPressed: () => Navigator.pop(ctx, 'cancel'),
            child: const Text('cancel').tr(),
          ),
          FilledButton(
            onPressed: () {
              context.read<DetailBloc>().add(const DetailGotBackEvent());
              Navigator.pop(ctx, 'yes');
            },
            child: const Text('yes').tr(),
          ),
        ],
      );
    },
  );
}
