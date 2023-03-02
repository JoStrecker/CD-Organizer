import 'package:cd_organizer/core/application/debouncer.dart';
import 'package:cd_organizer/feature/results/ui/widgets/result_item.dart';
import 'package:cd_organizer/feature/search/application/search_bloc.dart';
import 'package:cd_organizer/generated/assets.dart';
import 'package:cd_organizer/injection_container.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    Debouncer debouncer =
        Debouncer(duration: const Duration(milliseconds: 200));
    return BlocProvider<SearchBloc>(
      create: (context) => sl<SearchBloc>(),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(28)),
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow.withOpacity(0.05),
              offset: const Offset(0, 1),
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search_rounded),
                      border: InputBorder.none,
                      hintText: "Suche",
                      suffixIcon: IconButton(
                          onPressed: () {
                            context
                                .read<SearchBloc>()
                                .add(const SearchDeleteEvent());
                            controller.clear();
                          },
                          icon: const Icon(Icons.clear_rounded)),
                    ),
                    onChanged: (text) {
                      debouncer.run(() {
                        context
                            .read<SearchBloc>()
                            .add(SearchChangedEvent(text));
                      });
                    },
                    onSubmitted: (text) {
                      context.read<SearchBloc>().add(SearchChangedEvent(text));
                    },
                  ),
                ),
              ],
            ),
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchResultState) {
                  return const Divider();
                }
                return const SizedBox();
              },
            ),
            Flexible(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchResultState) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimationLimiter(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.results.length,
                            itemBuilder: (context, index) {
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 375),
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: ResultItem(
                                      release: state.results[index],
                                      index: index,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.apps_rounded),
                          label: const Text('Alle Anzeigen'),
                        ),
                        const SizedBox(height: 8),
                      ],
                    );
                  } else if (state is SearchEmptyState) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Lottie.asset(
                          Assets.lottiesSearchAnim,
                          height: 200,
                        ),
                        Text(
                          'Leider nichts gefunden',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
