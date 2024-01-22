import 'dart:math' as math;

import 'package:flutter/material.dart';

// So the leading button is square.
const double _kLeadingWidth = kToolbarHeight;

class IFAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final String? subtitle;

  final Widget? leading;

  /// Defines the width of [leading] widget.
  /// By default, the value of `leadingWidth` is 56.0.
  final double? leadingWidth;

  final List<Widget>? actions;

  final double elevation;

  const IFAppBar({
    Key? key,
    Color backgroundColor = Colors.white,
    this.title,
    this.subtitle,
    this.leading,
    this.leadingWidth,
    this.actions,
    this.elevation = 2,
  }) : super(key: key);

  @override
  State<IFAppBar> createState() => _IFAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

class _IFAppBarState extends State<IFAppBar> {
  late _WooAppBarStaticComponentsKeys keys;

  @override
  void initState() {
    super.initState();
    keys = _WooAppBarStaticComponentsKeys();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ScaffoldState? scaffold = Scaffold.maybeOf(context);
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);

    final bool hasDrawer = scaffold?.hasDrawer ?? false;
    final bool hasEndDrawer = scaffold?.hasEndDrawer ?? false;
    final bool canPop = parentRoute?.canPop ?? false;
    final bool useCloseButton =
        parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog;

    IconThemeData overallIconTheme = theme.primaryIconTheme;

    Widget? leading = widget.leading;
    if (leading == null) {
      if (hasDrawer) {
        leading = IconButton(
          icon: const Icon(Icons.menu),
          iconSize: overallIconTheme.size ?? 24,
          onPressed: _handleDrawerButton,
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      } else {
        if (!hasEndDrawer && canPop) {
          leading = useCloseButton ? const CloseButton() : const BackButton();
        }
      }
    }
    if (leading != null) {
      leading = ConstrainedBox(
        constraints: BoxConstraints.tightFor(
            width: widget.leadingWidth ?? _kLeadingWidth),
        child: leading,
      );
    }

    Widget? title;
    if (widget.title != null && widget.subtitle != null) {
      title = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.title!,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            widget.subtitle!,
            style: const TextStyle(fontSize: 14),
          )
        ],
      );
    } else if (widget.title != null) {
      title = Text(
        widget.title!,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      );
    }

    Widget? trailing;
    if (widget.actions != null) {
      trailing = Row(
        mainAxisSize: MainAxisSize.min,
        children: widget.actions!,
      );
    }

    return Material(
      color: Colors.white,
      elevation: widget.elevation,
      child: Hero(
        tag: 'app_bar',
        transitionOnUserGestures: true,
        createRectTween: _linearTranslateWithLargestRectSizeTween,
        flightShuttleBuilder: _navBarHeroFlightShuttleBuilder,
        child: SafeArea(
          bottom: false,
          child: Material(
            type: MaterialType.transparency,
            child: NavigationToolbar(
              leading: leading,
              middle: title,
              trailing: trailing,
              centerMiddle: true,
            ),
          ),
        ),
      ),
    );
  }

  void _handleDrawerButton() {
    Scaffold.of(context).openDrawer();
  }
}

Widget _navBarHeroFlightShuttleBuilder(
  BuildContext flightContext,
  Animation<double> animation,
  HeroFlightDirection flightDirection,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
) {
  print('${toHeroContext.widget}');
  print('${fromHeroContext.widget}');

  return toHeroContext.widget;
}

RectTween _linearTranslateWithLargestRectSizeTween(Rect? begin, Rect? end) {
  final Size largestSize = Size(
    math.max(begin!.size.width, end!.size.width),
    math.max(begin.size.height, end.size.height),
  );
  return RectTween(
    begin: begin.topLeft & largestSize,
    end: end.topLeft & largestSize,
  );
}

class _WooAppBarStaticComponentsKeys {
  _WooAppBarStaticComponentsKeys() : titleKey = GlobalKey(debugLabel: 'Middle');

  final GlobalKey titleKey;
}
