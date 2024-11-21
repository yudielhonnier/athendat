import 'package:athendat/core/constants/constants.dart';
import 'package:athendat/core/helpers/extensions.dart';
import 'package:athendat/features/home/presentation/bloc/products_bloc.dart';
import 'package:athendat/features/home/presentation/widgets/checked_products.dart';
import 'package:athendat/features/home/presentation/widgets/pending_products.dart';
import 'package:athendat/features/shared/presentation/widget/app_style.dart';
import 'package:athendat/features/shared/presentation/widget/height_spacer.dart';
import 'package:athendat/features/shared/presentation/widget/loading_status_adaptative.dart';
import 'package:athendat/features/shared/presentation/widget/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MobileHomeBody extends StatefulWidget {
  const MobileHomeBody({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  State<MobileHomeBody> createState() => _MobileHomeBodyState();
}

class _MobileHomeBodyState extends State<MobileHomeBody>
    with TickerProviderStateMixin {
  late final TabController tabController =
      TabController(length: 2, vsync: this);

  @override
  void initState() {
    tabController.addListener(_handleTabSelection);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    tabController.removeListener(_handleTabSelection);
    tabController.dispose();
  }

//call the event of the bloc when the tab is selected
  void _handleTabSelection() {
    if (tabController.indexIsChanging) {
      if (tabController.index == 1) {
        BlocProvider.of<ProductsBloc>(context).add(GetCheckedProductsEvent(
          pageChecked: 1,
          limit: checkedProductLimit,
          products: const [],
        ));
      } else {
        BlocProvider.of<ProductsBloc>(context)
            .add(GetPendingProductsEvent(page: 0, limit: pendingProductLimit));
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = context.height;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products Dashboard'),
        centerTitle: true,
      ),
      body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          shrinkWrap: true,
          children: [
            _buildTabBarTabs(tabController, theme),
            const HeightSpacer(
              height: 10,
            ),
            _buildBodyTabs(tabController, height),
          ]),
    );
  }

  Container _buildTabBarTabs(TabController tabController, ThemeData theme) {
    return Container(
      // height: 30,
      decoration: BoxDecoration(
          color: theme.colorScheme.shadow,
          borderRadius: BorderRadius.all(Radius.circular(AppConst.kRadius))),
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.label,
        indicator: BoxDecoration(
          color: theme.colorScheme.onTertiary,
          borderRadius: BorderRadius.all(
            Radius.circular(AppConst.kRadius),
          ),
        ),
        controller: tabController,
        isScrollable: false,
        labelPadding: EdgeInsets.zero,
        tabs: [
          Tab(
            child: SizedBox(
              width: AppConst.kWidth * 0.5,
              height: 26,
              child: SizedBox(
                child: Center(
                  child: ReusableText(
                    text: 'Incomming',
                    style: appStyle(
                        14, theme.colorScheme.primary, FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Tab(
            child: SizedBox(
              width: AppConst.kWidth * 0.5,
              height: 26,
              child: SizedBox(
                child: Center(
                  child: ReusableText(
                    text: 'Checked',
                    style: appStyle(
                        14, theme.colorScheme.primary, FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBodyTabs(TabController tabController, double height) {
    return SizedBox(
        height: height * 0.8,
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(AppConst.kRadius),
          ),
          child: TabBarView(controller: tabController, children: [
            //INCOMING VIEW
            SizedBox(
              child: BlocBuilder<ProductsBloc, ProductsState>(
                  builder: (context, state) {
                if (state is Loading) {
                  return const LoadingStatusAdaptative();
                } else if (state is Loaded) {
                  return PendingProductsList(
                    context: context,
                    products: state.products,
                  );
                } else if (state is Error) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                      Text("Error ${state.message}",
                          textAlign: TextAlign.center),
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<ProductsBloc>(context).add(
                              GetPendingProductsEvent(
                                  page: 0, limit: pendingProductLimit));
                        },
                        child: const Text("Try again"),
                      )
                    ])),
                  );
                }
                return const SizedBox.shrink();
              }),
            ),
            //Checked View
            SizedBox(child: BlocBuilder<ProductsBloc, ProductsState>(
              builder: (context, state) {
                if (state is Loading) {
                  return const Column(
                    children: [
                      Expanded(child: LoadingStatusAdaptative()),
                    ],
                  );
                } else if (state is Loaded) {
                  return CheckedProductsList(
                    context: context,
                    products: state.products,
                    pageChecked: state.pageChecked,
                  );
                } else if (state is Error) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                      Text("Error ${state.message}",
                          textAlign: TextAlign.center),
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<ProductsBloc>(context).add(
                              GetCheckedProductsEvent(
                                  pageChecked: 1,
                                  limit: checkedProductLimit,
                                  products: const []));
                        },
                        child: const Text("Try again"),
                      )
                    ])),
                  );
                }
                return const SizedBox.shrink();
              },
            ))
          ]),
        ));
  }
}
