// ignore_for_file: use_build_context_synchronously, implementation_imports

import 'dart:io';
import 'dart:ui' as ui;

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:provider/provider.dart';
import 'package:wechat_assets_picker/src/constants/custom_scroll_physics.dart';
import 'package:wechat_assets_picker/src/constants/extensions.dart';
import 'package:wechat_assets_picker/src/widget/builder/value_listenable_builder_2.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class ImagePicker {
  static Future<List<AssetEntity>?> pickMulti(
    BuildContext context, {
    List<AssetEntity>? selectedAssets,
    int maxAssets = 6,
    RequestType requestType = RequestType.image,
  }) async {
    final PermissionState ps = await AssetPicker.permissionCheck();
    final pickerConfig = AssetPickerConfig(
      selectedAssets: selectedAssets,
      maxAssets: maxAssets,
      requestType: requestType,
      pickerTheme: Theme.of(context).copyWith(
        primaryColor: Colors.white,
      ),
    );
    final DefaultAssetPickerProvider provider = DefaultAssetPickerProvider(
      maxAssets: pickerConfig.maxAssets,
      pageSize: pickerConfig.pageSize,
      pathThumbnailSize: pickerConfig.pathThumbnailSize,
      selectedAssets: pickerConfig.selectedAssets,
      requestType: pickerConfig.requestType,
      sortPathDelegate: pickerConfig.sortPathDelegate,
      filterOptions: pickerConfig.filterOptions,
      // initializeDelayDuration: route.transitionDuration,
    );
    final List<AssetEntity>? entities =
        await AssetPicker.pickAssetsWithDelegate(
      context,
      delegate: AssetPickerBuilderDelegate(
        provider: provider,
        initialPermission: ps,
        gridCount: pickerConfig.gridCount,
        pickerTheme: pickerConfig.pickerTheme,
        gridThumbnailSize: pickerConfig.gridThumbnailSize,
        previewThumbnailSize: pickerConfig.previewThumbnailSize,
        specialPickerType: pickerConfig.specialPickerType,
        specialItemPosition: pickerConfig.specialItemPosition,
        specialItemBuilder: pickerConfig.specialItemBuilder,
        loadingIndicatorBuilder: pickerConfig.loadingIndicatorBuilder,
        selectPredicate: pickerConfig.selectPredicate,
        shouldRevertGrid: pickerConfig.shouldRevertGrid,
        limitedPermissionOverlayPredicate:
            pickerConfig.limitedPermissionOverlayPredicate,
        pathNameBuilder: pickerConfig.pathNameBuilder,
        textDelegate: pickerConfig.textDelegate,
        themeColor: pickerConfig.themeColor,
        locale: Localizations.maybeLocaleOf(context),
      ),
    );
    return entities;
  }

  static Future<File?> pick(BuildContext context) async {
    final List<AssetEntity>? entities = await pickMulti(context, maxAssets: 1);
    if (entities == null || entities.isEmpty) {
      return null;
    } else {
      return await entities[0].file;
    }
  }

  static Future<File?> pickWithCrop(
    BuildContext context, {
    CropAspectRatio? aspectRatio,
    ImageCompressFormat? compressFormat,
  }) async {
    final image = await pick(context);
    if (image == null) {
      return null;
    }
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatio: aspectRatio,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: '裁剪照片',
          toolbarColor: Colors.white,
          hideBottomControls: true,
          toolbarWidgetColor: Colors.black,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
          title: '裁剪照片',
          aspectRatioLockEnabled: true,
        ),
      ],
    );
    return croppedFile == null ? null : File(croppedFile.path);
  }

  /// Static method to push with the navigator.
  /// 跳转至选择预览的静态方法
  static Future<List<AssetEntity>?> pushToViewer(
    BuildContext context, {
    int currentIndex = 0,
    required List<AssetEntity> previewAssets,
    DefaultAssetPickerProvider? selectorProvider,
    ThumbnailSize? previewThumbnailSize,
    List<AssetEntity>? selectedAssets,
    SpecialPickerType? specialPickerType,
    int? maxAssets,
    bool shouldReversePreview = false,
    AssetSelectPredicate<AssetEntity>? selectPredicate,
  }) async {
    await AssetPicker.permissionCheck();
    final Widget viewer = AssetPickerViewer<AssetEntity, AssetPathEntity>(
      builder: AssetPickerViewerBuilderDelegate(
        currentIndex: currentIndex,
        previewAssets: previewAssets,
        provider: selectedAssets != null
            ? AssetPickerViewerProvider<AssetEntity>(
                selectedAssets,
                maxAssets: maxAssets ??
                    selectorProvider?.maxAssets ??
                    defaultMaxAssetsCount,
              )
            : null,
        themeData: Theme.of(context).copyWith(
          primaryColor: Colors.white,
        ),
        previewThumbnailSize: previewThumbnailSize,
        specialPickerType: specialPickerType,
        selectedAssets: selectedAssets,
        selectorProvider: selectorProvider,
        maxAssets: maxAssets,
        shouldReversePreview: shouldReversePreview,
        selectPredicate: selectPredicate,
      ),
    );
    final PageRouteBuilder<List<AssetEntity>> pageRoute =
        PageRouteBuilder<List<AssetEntity>>(
      pageBuilder: (_, __, ___) => viewer,
      transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
    final List<AssetEntity>? result =
        await Navigator.of(context).push<List<AssetEntity>>(pageRoute);
    return result;
  }
}

class AssetPickerBuilderDelegate extends DefaultAssetPickerBuilderDelegate {
  AssetPickerBuilderDelegate({
    required super.provider,
    required super.initialPermission,
    super.gridCount,
    super.pickerTheme,
    super.specialItemPosition,
    super.specialItemBuilder,
    super.loadingIndicatorBuilder,
    super.selectPredicate,
    super.shouldRevertGrid,
    super.limitedPermissionOverlayPredicate,
    super.pathNameBuilder,
    super.themeColor,
    super.textDelegate,
    super.locale,
    super.gridThumbnailSize,
    super.previewThumbnailSize,
    super.specialPickerType,
    super.keepScrollOffset,
  });

  @override
  Widget confirmButton(BuildContext context) {
    return Consumer<DefaultAssetPickerProvider>(
      builder: (_, DefaultAssetPickerProvider p, __) {
        final bool isSelectedNotEmpty = p.isSelectedNotEmpty;
        final bool shouldAllowConfirm =
            isSelectedNotEmpty || p.previousSelectedAssets.isNotEmpty;
        return ElevatedButton(
          onPressed: shouldAllowConfirm
              ? () => Navigator.of(context).maybePop(p.selectedAssets)
              : null,
          child: Text(
            isSelectedNotEmpty && !isSingleAssetMode
                ? '${textDelegate.confirm}'
                    ' (${p.selectedAssets.length}/${p.maxAssets})'
                : textDelegate.confirm,
            overflow: TextOverflow.fade,
            softWrap: false,
            semanticsLabel: isSelectedNotEmpty && !isSingleAssetMode
                ? '${semanticsTextDelegate.confirm}'
                    ' (${p.selectedAssets.length}/${p.maxAssets})'
                : semanticsTextDelegate.confirm,
          ),
        );
      },
    );
  }

  @override
  Future<void> viewAsset(
    BuildContext context,
    int index,
    AssetEntity currentAsset,
  ) async {
    final DefaultAssetPickerProvider provider =
        context.read<DefaultAssetPickerProvider>();
    bool selectedAllAndNotSelected() =>
        !provider.selectedAssets.contains(currentAsset) &&
        provider.selectedMaximumAssets;
    bool selectedPhotosAndIsVideo() =>
        isWeChatMoment &&
        currentAsset.type == AssetType.video &&
        provider.selectedAssets.isNotEmpty;
    // When we reached the maximum select count and the asset
    // is not selected, do nothing.
    // When the special type is WeChat Moment, pictures and videos cannot
    // be selected at the same time. Video select should be banned if any
    // pictures are selected.
    if (selectedAllAndNotSelected() || selectedPhotosAndIsVideo()) {
      return;
    }
    final List<AssetEntity> current;
    final List<AssetEntity>? selected;
    final int effectiveIndex;
    if (isWeChatMoment) {
      if (currentAsset.type == AssetType.video) {
        current = <AssetEntity>[currentAsset];
        selected = null;
        effectiveIndex = 0;
      } else {
        current = provider.currentAssets
            .where((AssetEntity e) => e.type == AssetType.image)
            .toList();
        selected = provider.selectedAssets;
        effectiveIndex = current.indexOf(currentAsset);
      }
    } else {
      current = provider.currentAssets;
      selected = provider.selectedAssets;
      effectiveIndex = index;
    }
    final List<AssetEntity>? result = await ImagePicker.pushToViewer(
      context,
      currentIndex: effectiveIndex,
      previewAssets: current,
      previewThumbnailSize: previewThumbnailSize,
      selectPredicate: selectPredicate,
      selectedAssets: selected,
      selectorProvider: provider,
      specialPickerType: specialPickerType,
      maxAssets: provider.maxAssets,
      shouldReversePreview: isAppleOS(context),
    );
    if (result != null) {
      Navigator.of(context).maybePop(result);
    }
  }

  @override
  Widget previewButton(BuildContext context) {
    Future<void> onTap() async {
      final DefaultAssetPickerProvider p =
          context.read<DefaultAssetPickerProvider>();
      final List<AssetEntity> selectedAssets = p.selectedAssets;
      final List<AssetEntity> selected;
      if (isWeChatMoment) {
        selected = selectedAssets
            .where((AssetEntity e) => e.type == AssetType.image)
            .toList();
      } else {
        selected = selectedAssets;
      }
      final List<AssetEntity>? result = await ImagePicker.pushToViewer(
        context,
        previewAssets: selected,
        previewThumbnailSize: previewThumbnailSize,
        selectPredicate: selectPredicate,
        selectedAssets: selected,
        selectorProvider: provider,
        maxAssets: p.maxAssets,
      );
      if (result != null) {
        Navigator.of(context).maybePop(result);
      }
    }

    return Consumer<DefaultAssetPickerProvider>(
      builder: (_, DefaultAssetPickerProvider p, Widget? child) {
        return ValueListenableBuilder<bool>(
          valueListenable: isSwitchingPath,
          builder: (_, bool isSwitchingPath, __) => Semantics(
            enabled: p.isSelectedNotEmpty,
            focusable: !isSwitchingPath,
            hidden: isSwitchingPath,
            onTapHint: semanticsTextDelegate.sActionPreviewHint,
            child: child,
          ),
        );
      },
      child: Consumer<DefaultAssetPickerProvider>(
        builder: (_, DefaultAssetPickerProvider p, __) => GestureDetector(
          onTap: p.isSelectedNotEmpty ? onTap : null,
          child: Selector<DefaultAssetPickerProvider, String>(
            selector: (_, DefaultAssetPickerProvider p) =>
                p.selectedDescriptions,
            builder: (BuildContext c, __, ___) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                '${textDelegate.preview}'
                '${p.isSelectedNotEmpty ? ' (${p.selectedAssets.length})' : ''}',
                style: const TextStyle(fontSize: 16),
                // maxScaleFactor: 1.2,
                semanticsLabel: '${semanticsTextDelegate.preview}'
                    '${p.isSelectedNotEmpty ? ' (${p.selectedAssets.length})' : ''}',
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget selectIndicator(BuildContext context, int index, AssetEntity asset) {
    final double indicatorSize =
        MediaQuery.sizeOf(context).width / gridCount / 3;
    final int index = provider.selectedAssets.indexOf(asset);
    final Duration duration = switchingPathDuration * 0.75;
    return Selector<DefaultAssetPickerProvider, String>(
      selector: (_, DefaultAssetPickerProvider p) => p.selectedDescriptions,
      builder: (BuildContext context, String descriptions, __) {
        final bool selected = descriptions.contains(asset.toString());
        final Widget innerSelector = AnimatedContainer(
          duration: duration,
          width: indicatorSize / (isAppleOS(context) ? 1.25 : 1.5),
          height: indicatorSize / (isAppleOS(context) ? 1.25 : 1.5),
          padding: isSingleAssetMode
              ? EdgeInsets.all(indicatorSize / 10)
              : EdgeInsets.all(indicatorSize / 25),
          decoration: BoxDecoration(
            border: !selected
                ? Border.all(
                    color: context.theme.unselectedWidgetColor,
                    width: indicatorSize / 25,
                  )
                : null,
            color: selected ? theme.primaryColor : null,
            shape: BoxShape.circle,
          ),
          child: FittedBox(
            child: AnimatedSwitcher(
              duration: duration,
              reverseDuration: duration,
              child: selected
                  ? isSingleAssetMode
                      ? const Icon(Icons.check_rounded)
                      : Text(
                          (index + 1).toString(),
                          // style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                  : const SizedBox.shrink(),
            ),
          ),
        );
        final Widget selectorWidget = GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => selectAsset(context, asset, index, selected),
          child: Container(
            margin: EdgeInsets.all(indicatorSize / 4),
            width: isPreviewEnabled ? indicatorSize : null,
            height: isPreviewEnabled ? indicatorSize : null,
            alignment: AlignmentDirectional.topEnd,
            child: (!isPreviewEnabled && isSingleAssetMode && !selected)
                ? const SizedBox.shrink()
                : innerSelector,
          ),
        );
        if (isPreviewEnabled) {
          return PositionedDirectional(
            top: 0,
            end: 0,
            child: selectorWidget,
          );
        }
        return selectorWidget;
      },
    );
  }

  @override
  Widget selectedBackdrop(BuildContext context, int index, AssetEntity asset) {
    final double indicatorSize =
        MediaQuery.sizeOf(context).width / gridCount / 3;
    return Positioned.fill(
      child: GestureDetector(
        onTap: isPreviewEnabled ? () => viewAsset(context, index, asset) : null,
        child: Consumer<DefaultAssetPickerProvider>(
          builder: (_, DefaultAssetPickerProvider p, __) {
            final int index = p.selectedAssets.indexOf(asset);
            final bool selected = index != -1;
            return AnimatedContainer(
              duration: switchingPathDuration,
              padding: EdgeInsets.all(indicatorSize * .35),
              color: selected ? Colors.black.withOpacity(.45) : null,
            );
          },
        ),
      ),
    );
  }

  @override
  Widget pathEntitySelector(BuildContext context) {
    Widget text(
      BuildContext context,
      String text,
      String semanticsText,
    ) {
      return Flexible(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.normal,
          ),
          maxLines: 1,
          overflow: TextOverflow.fade,
          semanticsLabel: semanticsText,
        ),
      );
    }

    return UnconstrainedBox(
      child: GestureDetector(
        onTap: () {
          if (isPermissionLimited && provider.isAssetsEmpty) {
            PhotoManager.presentLimited();
            return;
          }
          if (provider.currentPath == null) {
            return;
          }
          isSwitchingPath.value = !isSwitchingPath.value;
        },
        child: Container(
          height: appBarItemHeight,
          constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width * 0.5,
          ),
          padding: const EdgeInsetsDirectional.only(start: 12, end: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            color: Colors.black12,
          ),
          child: Selector<DefaultAssetPickerProvider,
              PathWrapper<AssetPathEntity>?>(
            selector: (_, DefaultAssetPickerProvider p) => p.currentPath,
            builder: (_, PathWrapper<AssetPathEntity>? p, Widget? w) {
              final AssetPathEntity? path = p?.path;
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (path == null && isPermissionLimited)
                    text(
                      context,
                      textDelegate.changeAccessibleLimitedAssets,
                      semanticsTextDelegate.changeAccessibleLimitedAssets,
                    ),
                  if (path != null)
                    text(
                      context,
                      isPermissionLimited && path.isAll
                          ? textDelegate.accessiblePathName
                          : pathNameBuilder?.call(path) ?? path.name,
                      isPermissionLimited && path.isAll
                          ? semanticsTextDelegate.accessiblePathName
                          : pathNameBuilder?.call(path) ?? path.name,
                    ),
                  w!,
                ],
              );
            },
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 5),
              child: ValueListenableBuilder<bool>(
                valueListenable: isSwitchingPath,
                builder: (_, isSwitchingPath, child) {
                  return AnimatedRotation(
                    turns: isSwitchingPath ? 0.5 : 0,
                    duration: switchingPathDuration,
                    child: child,
                  );
                },
                child: const Icon(
                  Icons.keyboard_arrow_down,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Action bar widget aligned to bottom.
  /// 底部操作栏部件
  @override
  Widget bottomActionBar(BuildContext context) {
    Widget child = Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      color: theme.primaryColor.withOpacity(isAppleOS(context) ? 0.90 : 1),
      child: Row(
        children: <Widget>[
          previewButton(context),
          const Spacer(),
          confirmButton(context),
        ],
      ),
    );
    if (isPermissionLimited) {
      child = Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[accessLimitedBottomTip(context), child],
      );
    }
    child = ClipRect(
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(
          sigmaX: appleOSBlurRadius,
          sigmaY: appleOSBlurRadius,
        ),
        child: child,
      ),
    );
    return child;
  }
}

class AssetPickerViewerBuilderDelegate
    extends DefaultAssetPickerViewerBuilderDelegate {
  AssetPickerViewerBuilderDelegate({
    required super.currentIndex,
    required super.previewAssets,
    required super.themeData,
    super.selectorProvider,
    super.provider,
    super.selectedAssets,
    super.previewThumbnailSize,
    super.specialPickerType,
    super.maxAssets,
    super.shouldReversePreview,
    super.selectPredicate,
  });

  @override
  Widget bottomDetailBuilder(BuildContext context) {
    final Color backgroundColor = themeData.primaryColor.withOpacity(.9);
    return ValueListenableBuilder2<bool, int>(
      firstNotifier: isDisplayingDetail,
      secondNotifier: selectedNotifier,
      builder: (_, bool v, __, Widget? child) => AnimatedPositionedDirectional(
        duration: kThemeAnimationDuration,
        curve: Curves.easeInOut,
        bottom: v ? 0 : -(context.bottomPadding + bottomDetailHeight),
        start: 0,
        end: 0,
        child: child!,
      ),
      child: CNP<AssetPickerViewerProvider<AssetEntity>?>.value(
        value: provider,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: backgroundColor,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4.0,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              if (provider != null)
                ValueListenableBuilder<int>(
                  valueListenable: selectedNotifier,
                  builder: (_, int count, __) => SizedBox(
                    width: count > 0 ? double.maxFinite : 0,
                    height: bottomPreviewHeight,
                    child: ListView.builder(
                      controller: previewingListController,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      itemCount: count,
                      itemBuilder: bottomDetailItemBuilder,
                    ),
                  ),
                ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    if (provider != null || isWeChatMoment)
                      confirmButton(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget bottomDetailItemBuilder(BuildContext context, int index) {
    const double padding = 8.0;

    void onTap(AssetEntity asset) {
      final int page;
      if (previewAssets != selectedAssets) {
        page = previewAssets.indexOf(asset);
      } else {
        page = index;
      }
      if (pageController.page == page.toDouble()) {
        return;
      }
      pageController.jumpToPage(page);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: padding,
        vertical: padding * 2,
      ),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: StreamBuilder<int>(
          initialData: currentIndex,
          stream: pageStreamController.stream,
          builder: (_, AsyncSnapshot<int> snapshot) {
            final AssetEntity asset = selectedAssets!.elementAt(index);
            final bool isViewing = previewAssets[snapshot.data!] == asset;
            final Widget item = switch (asset.type) {
              AssetType.image => _imagePreviewItem(asset),
              AssetType.video => _videoPreviewItem(asset),
              AssetType.audio => _audioPreviewItem(asset),
              AssetType.other => const SizedBox.shrink(),
            };
            return Semantics(
              label: '${semanticsTextDelegate.semanticTypeLabel(asset.type)}'
                  '${index + 1}',
              selected: isViewing,
              onTap: () => onTap(asset),
              onTapHint: semanticsTextDelegate.sActionPreviewHint,
              excludeSemantics: true,
              child: GestureDetector(
                onTap: () => onTap(asset),
                child: Selector<AssetPickerViewerProvider<AssetEntity>?,
                    List<AssetEntity>?>(
                  selector: (_, p) => p?.currentlySelectedAssets,
                  child: item,
                  builder: (_, currentlySelectedAssets, child) {
                    final bool isSelected =
                        currentlySelectedAssets?.contains(asset) ?? false;
                    return AnimatedContainer(
                      duration: kThemeAnimationDuration,
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      foregroundDecoration: BoxDecoration(
                        border: isViewing
                            ? Border.all(
                                color: themeData.colorScheme.secondary,
                                width: 3,
                              )
                            : null,
                        borderRadius: BorderRadius.circular(8),
                        color: isSelected
                            ? null
                            : themeData.colorScheme.surface.withOpacity(0.54),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: child,
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: themeData,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: themeData.appBarTheme.systemOverlayStyle ??
            (themeData.effectiveBrightness.isDark
                ? SystemUiOverlayStyle.light
                : SystemUiOverlayStyle.dark),
        child: Material(
          color: themeData.colorScheme.onSecondary,
          child: Stack(
            children: <Widget>[
              Positioned.fill(child: _pageViewBuilder(context)),
              if (isWeChatMoment && hasVideo) ...<Widget>[
                momentVideoBackButton(context),
                PositionedDirectional(
                  end: 16,
                  bottom: context.bottomPadding + 16,
                  child: confirmButton(context),
                ),
              ] else ...<Widget>[
                appBar(context),
                if (selectedAssets != null ||
                    (isWeChatMoment && hasVideo && isAppleOS(context)))
                  bottomDetailBuilder(context),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// AppBar widget.
  /// 顶栏部件
  @override
  Widget appBar(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDisplayingDetail,
      builder: (_, bool value, Widget? child) => AnimatedPositionedDirectional(
        duration: kThemeAnimationDuration,
        curve: Curves.easeInOut,
        top: value ? 0.0 : -(context.topPadding + kToolbarHeight),
        start: 0.0,
        end: 0.0,
        height: context.topPadding + kToolbarHeight,
        child: child!,
      ),
      child: Container(
        padding: EdgeInsetsDirectional.only(top: context.topPadding),
        color: themeData.appBarTheme.backgroundColor,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Semantics(
                  sortKey: ordinalSortKey(0),
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    tooltip: MaterialLocalizations.of(
                      context,
                    ).backButtonTooltip,
                    onPressed: Navigator.of(context).maybePop,
                  ),
                ),
              ),
            ),
            if (!isAppleOS(context) && specialPickerType == null)
              Expanded(
                child: Center(
                  child: Semantics(
                    sortKey: ordinalSortKey(0.1),
                    child: StreamBuilder<int>(
                      initialData: currentIndex,
                      stream: pageStreamController.stream,
                      builder: (_, AsyncSnapshot<int> snapshot) => Text(
                        '${snapshot.data! + 1}/${previewAssets.length}',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            if (provider != null)
              Expanded(
                child: Container(
                  alignment: AlignmentDirectional.centerEnd,
                  padding: const EdgeInsetsDirectional.only(end: 14),
                  child: Semantics(
                    sortKey: ordinalSortKey(0.2),
                    child: selectButton(context),
                  ),
                ),
              )
            else
              const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _pageViewBuilder(BuildContext context) {
    return Semantics(
      sortKey: ordinalSortKey(1),
      child: ExtendedImageGesturePageView.builder(
        physics: previewAssets.length == 1
            ? const CustomClampingScrollPhysics()
            : const CustomBouncingScrollPhysics(),
        controller: pageController,
        itemCount: previewAssets.length,
        itemBuilder: assetPageBuilder,
        reverse: shouldReversePreview,
        onPageChanged: (int index) {
          currentIndex = index;
          pageStreamController.add(index);
        },
      ),
    );
  }

  /// Preview item widgets for audios.
  /// 音频的底部预览部件
  Widget _audioPreviewItem(AssetEntity asset) {
    return ColoredBox(
      color: viewerState.context.theme.dividerColor,
      child: const Center(child: Icon(Icons.audiotrack)),
    );
  }

  /// Preview item widgets for images.
  /// 图片的底部预览部件
  Widget _imagePreviewItem(AssetEntity asset) {
    return RepaintBoundary(
      child: ExtendedImage(
        image: AssetEntityImageProvider(asset, isOriginal: false),
        fit: BoxFit.cover,
      ),
    );
  }

  /// Preview item widgets for video.
  /// 视频的底部预览部件
  Widget _videoPreviewItem(AssetEntity asset) {
    return Stack(
      children: <Widget>[
        _imagePreviewItem(asset),
        Center(
          child: Icon(
            Icons.video_library,
            color: themeData.iconTheme.color?.withOpacity(0.54),
          ),
        ),
      ],
    );
  }

  @override
  Widget confirmButton(BuildContext context) {
    return CNP<AssetPickerViewerProvider<AssetEntity>?>.value(
      value: provider,
      child: Consumer<AssetPickerViewerProvider<AssetEntity>?>(
        builder: (_, AssetPickerViewerProvider<AssetEntity>? provider, __) {
          assert(
            isWeChatMoment || provider != null,
            'Viewer provider must not be null '
            'when the special type is not WeChat moment.',
          );
          Future<void> onPressed() async {
            if (isWeChatMoment && hasVideo) {
              Navigator.of(context).pop(<AssetEntity>[currentAsset]);
              return;
            }
            if (provider!.isSelectedNotEmpty) {
              Navigator.of(context).pop(provider.currentlySelectedAssets);
              return;
            }
            if (await onChangingSelected(context, currentAsset, false)) {
              Navigator.of(context).pop(
                selectedAssets ?? <AssetEntity>[currentAsset],
              );
            }
          }

          String buildText() {
            if (isWeChatMoment && hasVideo) {
              return textDelegate.confirm;
            }
            if (provider!.isSelectedNotEmpty) {
              return '${textDelegate.confirm}'
                  ' (${provider.currentlySelectedAssets.length}'
                  '/'
                  '${selectorProvider!.maxAssets})';
            }
            return textDelegate.confirm;
          }

          final bool isButtonEnabled = provider == null ||
              provider.currentlySelectedAssets.isNotEmpty ||
              previewAssets.isEmpty ||
              selectedNotifier.value == 0;
          return ElevatedButton(
            onPressed: isButtonEnabled ? onPressed : null,
            // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            child: Text(
              buildText(),
              overflow: TextOverflow.fade,
              softWrap: false,
              semanticsLabel: () {
                if (isWeChatMoment && hasVideo) {
                  return semanticsTextDelegate.confirm;
                }
                if (provider!.isSelectedNotEmpty) {
                  return '${semanticsTextDelegate.confirm}'
                      ' (${provider.currentlySelectedAssets.length}'
                      '/'
                      '${selectorProvider!.maxAssets})';
                }
                return semanticsTextDelegate.confirm;
              }(),
            ),
          );
        },
      ),
    );
  }
}
