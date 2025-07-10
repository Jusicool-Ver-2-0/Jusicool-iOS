import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BaseScaffold extends ConsumerWidget {
  const BaseScaffold({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: buildAppBar(context, ref),
      body:
          useSafeArea
              ? SafeArea(
                top: setTopSafeArea,
                bottom: setBottomSafeArea,
                child: buildBody(context, ref),
              )
              : buildBody(context, ref),
      bottomNavigationBar: buildBottomNavigationBar(context, ref),
    );
  }

  @protected
  Color get backgroundColor => Colors.white;

  @protected
  bool get resizeToAvoidBottomInset => true;

  @protected
  bool get useSafeArea => true;

  @protected
  bool get setBottomSafeArea => true;

  @protected
  bool get setTopSafeArea => true;

  @protected
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) => null;

  @protected
  Widget buildBody(BuildContext context, WidgetRef ref);

  @protected
  Widget? buildBottomNavigationBar(BuildContext context, WidgetRef ref) => null;
}
