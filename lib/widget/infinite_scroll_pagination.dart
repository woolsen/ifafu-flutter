import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CustomPagedChildBuilder<ItemType>
    extends PagedChildBuilderDelegate<ItemType> {
  final VoidCallback? onTryAgain;

  CustomPagedChildBuilder({
    required ItemWidgetBuilder<ItemType> itemBuilder,
    super.animateTransitions = true,
    this.onTryAgain,
    WidgetBuilder? firstPageProgressIndicatorBuilder,
    WidgetBuilder? newPageProgressIndicatorBuilder,
    WidgetBuilder? noMoreItemsIndicatorBuilder,
    WidgetBuilder? newPageErrorIndicatorBuilder,
    WidgetBuilder? firstPageErrorIndicatorBuilder,
    WidgetBuilder? noItemsFoundIndicatorBuilder,
  }) : super(
          itemBuilder: itemBuilder,
          firstPageProgressIndicatorBuilder:
              firstPageProgressIndicatorBuilder ??
                  (context) => const FirstPageProgressIndicator(),
          newPageProgressIndicatorBuilder: newPageProgressIndicatorBuilder ??
              (context) => const FooterTile(child: CircularProgressIndicator()),
          noMoreItemsIndicatorBuilder: noMoreItemsIndicatorBuilder ??
              (context) => const NoMoreItemsIndicator(),
          newPageErrorIndicatorBuilder: newPageErrorIndicatorBuilder ??
              (context) => NewPageErrorIndicator(onTap: onTryAgain),
          firstPageErrorIndicatorBuilder: firstPageErrorIndicatorBuilder ??
              (context) => FirstPageErrorIndicator(onTryAgain: onTryAgain),
          noItemsFoundIndicatorBuilder: noItemsFoundIndicatorBuilder ??
              (context) => NoItemsFoundIndicator(onTryAgain: onTryAgain),
        );
}

class NoItemsFoundIndicator extends StatelessWidget {
  final VoidCallback? onTryAgain;

  const NoItemsFoundIndicator({super.key, this.onTryAgain});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 32,
          horizontal: 16,
        ),
        child: Column(
          children: [
            Image.asset(
              'assets/image/empty.png',
              height: 120,
            ),
            const SizedBox(height: 8),
            Text(
              '暂无内容~',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).disabledColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FirstPageProgressIndicator extends StatelessWidget {
  const FirstPageProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(32),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class FirstPageErrorIndicator extends StatelessWidget {
  final VoidCallback? onTryAgain;

  const FirstPageErrorIndicator({
    this.onTryAgain,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirstPageExceptionIndicator(
      title: '出了点问题',
      message: '应用程序遇到了未知错误\n请稍后再试~',
      onTryAgain: onTryAgain,
    );
  }
}

class FirstPageExceptionIndicator extends StatelessWidget {
  const FirstPageExceptionIndicator({
    required this.title,
    this.message,
    this.onTryAgain,
    Key? key,
  }) : super(key: key);

  final String title;
  final String? message;
  final VoidCallback? onTryAgain;

  @override
  Widget build(BuildContext context) {
    final message = this.message;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 32,
          horizontal: 16,
        ),
        child: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            if (message != null)
              const SizedBox(
                height: 16,
              ),
            if (message != null)
              Text(
                message,
                textAlign: TextAlign.center,
              ),
            if (onTryAgain != null)
              const SizedBox(
                height: 48,
              ),
            if (onTryAgain != null)
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onTryAgain,
                  icon: const Icon(Icons.refresh),
                  label: const Text('重试'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class NoMoreItemsIndicator extends StatelessWidget {
  const NoMoreItemsIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: Text(
          '到底啦~',
          style: TextStyle(
            color: Theme.of(context).disabledColor,
          ),
        ),
      );
}

class NewPageErrorIndicator extends StatelessWidget {
  const NewPageErrorIndicator({
    Key? key,
    this.onTap,
  }) : super(key: key);
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: const FooterTile(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '出了点问题，点击重试',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 4,
            ),
            Icon(
              Icons.refresh,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

class FooterTile extends StatelessWidget {
  const FooterTile({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
        bottom: 16,
      ),
      child: Center(child: child),
    );
  }
}
