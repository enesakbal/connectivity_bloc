import 'package:connectivity_bloc/src/cubit/fetch_cats_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatApp extends StatefulWidget {
  const CatApp({super.key});

  @override
  State<CatApp> createState() => _CatAppState();
}

class _CatAppState extends State<CatApp> {
  late final ScrollController scrollController;

  void _scrollListener() async {
    final isBottom = scrollController.position.maxScrollExtent == scrollController.offset &&
        scrollController.position.pixels == scrollController.position.maxScrollExtent;

    if (isBottom) {
      await context.read<FetchCatsCubit>().fetchCats();
    }
  }

  @override
  void initState() {
    scrollController = ScrollController()..addListener(_scrollListener);
    context.read<FetchCatsCubit>().fetchCats();

    super.initState();
  }

  @override
  void dispose() {
    scrollController
      ..removeListener(_scrollListener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FetchCatsCubit, FetchCatsState>(
      listener: (context, state) {
        if (state is FetchCatsNoInternet) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No internet connection')),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Cat App')),
        body: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          controller: scrollController,
          children: [
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: context.watch<FetchCatsCubit>().catList.length,
              itemBuilder: (context, index) {
                final item = context.watch<FetchCatsCubit>().catList[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                      image: DecorationImage(
                        image: NetworkImage(item.url ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 100,
              child: Center(child: CircularProgressIndicator.adaptive()),
            ),
          ],
        ),
      ),
    );
  }
}
