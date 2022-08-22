import 'package:ao_flutter_oauth2_example/setup.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
import 'package:provider/provider.dart';

class StatelessBindingScope<T extends ChangeNotifier> extends StatelessWidget {
  final Widget Function(BuildContext context, T viewModel, Widget? child)
      builder;

  StatelessBindingScope(
      {Key? key, required this.builder, T? viewModel, this.autoDispose = false})
      : super(key: key) {
    this.viewModel = viewModel ?? KiwiContainer().resolve<T>();
  }
  final bool autoDispose;
  late final T viewModel;

  @override
  Widget build(BuildContext context) {
    if (autoDispose) {
      return ChangeNotifierProvider<T>(
        create: (context) => viewModel,
        child: Consumer<T>(builder: builder),
      );
    }
    // Listens to a ChangeNotifier, exposes it to its descendants
    // rebuilds whenever ChangeNotifier.notifyListeners is called.

    return ChangeNotifierProvider<T>.value(
      value: viewModel,
      child: Consumer<T>(builder: builder),
    );
  }
}

class StatefulBindingScope<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T viewModel, Widget? child)
      builder;
  final Function(T)? onModelReady;
  final Function(T viewModel, AppLifecycleState)? onLifecycleStateChanged;
  final Function(T)? onBuildComplete;
  final Function(T)? onViewDisposed;
  final bool autoDispose;
  final T? viewModel;

  StatefulBindingScope({
    Key? key,
    required this.builder,
    this.viewModel,
    this.onModelReady,
    this.onLifecycleStateChanged,
    this.onBuildComplete,
    this.onViewDisposed,
    this.autoDispose = false,
  }) : super(key: key);

  @override
  _StatefulBindingScopeState<T> createState() =>
      _StatefulBindingScopeState<T>();
}

class _StatefulBindingScopeState<T extends ChangeNotifier>
    extends State<StatefulBindingScope<T>> with WidgetsBindingObserver {
  late T viewModel;

  @override
  void initState() {
    viewModel = widget.viewModel ?? locator.get<T>();
    widget.onModelReady?.call(viewModel);
    super.initState();
    if (widget.onLifecycleStateChanged != null) {
      WidgetsBinding.instance.addObserver(this);
    }
    if (widget.onBuildComplete != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        widget.onBuildComplete?.call(viewModel);
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    widget.onLifecycleStateChanged?.call(viewModel, state);
  }

  @override
  void dispose() {
    if (widget.onLifecycleStateChanged != null) {
      WidgetsBinding.instance.removeObserver(this);
    }
    if (widget.onBuildComplete != null) {
      WidgetsBinding.instance.removeObserver(this);
    }
    widget.onViewDisposed?.call(viewModel);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.autoDispose) {
      return ChangeNotifierProvider<T>(
        create: (context) => viewModel,
        child: Consumer<T>(builder: widget.builder),
      );
    }

    return ChangeNotifierProvider<T>.value(
      value: viewModel,
      child: Consumer<T>(builder: widget.builder),
    );
  }
}
