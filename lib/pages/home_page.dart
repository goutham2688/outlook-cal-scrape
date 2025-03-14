import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'date_navigation.dart';
import 'settings_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cal_list_cubit.dart';
import 'cal_item.dart';
import 'error_page.dart';
import 'waiting_item.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverAppBar(
            title: const Text('Scraped Calendar'),
            centerTitle: true,
            forceMaterialTransparency: true,
            actions: [
              IconButton(
                onPressed: () => {
                  Navigator.of(context).push(
                    MaterialPageRoute<SettingsPage>(
                        builder: (_) => BlocProvider.value(
                              value: BlocProvider.of<CalListCubit>(context),
                              child: const SettingsPage(),
                            )),
                  )
                },
                icon: const Icon(Icons.settings),
              )
            ],
          ),
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              await BlocProvider.of<CalListCubit>(context).loadDataFromApi();
            },
          ),
          BlocBuilder<CalListCubit, CalListState>(
            builder: (context, state) {
              if (state is CalListDataLoaded) {
                final viewData = state.data;
                final date = state.date;
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      // top nav row
                      if (index == 0) {
                        return DateNavigation(
                          date: date,
                          previousButtonEnabled: state.prevEnabled,
                          nextButtonEnabled: state.nextEnabled,
                        );
                      } else {
                        final adjustedIndex = index - 1;
                        if (viewData.isEmpty && (adjustedIndex == 0)) {
                          return const Center(
                              child: Text('\nNo Events found!'));
                        }
                        if (adjustedIndex > viewData.length - 1) return null;
                        final now = DateTime.now();
                        return CalItem(
                          calTitle: viewData[adjustedIndex].title,
                          startTime: viewData[adjustedIndex].startTime,
                          endTime: viewData[adjustedIndex].endTime,
                          duration: viewData[adjustedIndex]
                              .endTime
                              .difference(viewData[adjustedIndex].startTime),
                          nowTime: now,
                        );
                      }
                    },
                  ),
                );
              } else if (state is CalListLoading) {
                BlocProvider.of<CalListCubit>(context).getInitialData();
                return const WaitingItem();
              } else {
                return const ErrorPage();
              }
            },
          ),
        ],
      ),
    );
  }
}
