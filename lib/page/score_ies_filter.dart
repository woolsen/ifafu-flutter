import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ifafu/http/model.dart';
import 'package:ifafu/provider/score_provider.dart';
import 'package:ifafu/widget/if_app_bar.dart';
import 'package:ifafu/widget/if_empty_view.dart';

class ScoreIesFilterPage extends StatefulWidget {
  final List<Score> scores;

  const ScoreIesFilterPage({super.key, required this.scores});

  @override
  State<ScoreIesFilterPage> createState() => _ScoreIesFilterPageState();
}

class _ScoreIesFilterPageState extends State<ScoreIesFilterPage> {
  final _nameTextStyle = const TextStyle(
    fontSize: 18,
    color: Color(0xFF1185fd),
  );

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Consumer(builder: (context, ref, child) {
      return PopScope(
        onPopInvoked: (canPop) async {
          ref
              .read(scoreTableNotifierProvider.notifier)
              .updateScore(widget.scores);
        },
        child: Scaffold(
          appBar: const IFAppBar(title: '调整免/补修课程'),
          body: widget.scores.isEmpty
              ? const Center(
                  child: IFEmptyView(),
                )
              : ColoredBox(
                  color: Colors.white,
                  child: ListView.separated(
                    padding: padding.copyWith(top: 12, bottom: 12),
                    itemCount: widget.scores.length,
                    itemBuilder: (context, index) {
                      return _buildScoreItem(widget.scores[index]);
                    },
                    separatorBuilder: (context, index) => const Divider(
                      height: 1,
                      thickness: 1,
                      indent: 32,
                      endIndent: 32,
                      color: Color(0xFFF0F0F0),
                    ),
                  ),
                ),
        ),
      );
    });
  }

  Widget _buildScoreItem(Score score) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    score.name,
                    style: _nameTextStyle,
                  ),
                ),
                const SizedBox(width: 2),
                _buildCorner(score),
              ],
            ),
          ),
          Checkbox(
            value: score.iesIgnore,
            onChanged: (value) {
              if (value != null && score.iesIgnore != value) {
                score.iesIgnore = value;
                if (score.iesIgnoreReason == null ||
                    score.iesIgnoreReason!.isEmpty) {
                  score.iesIgnoreReason = '免/补修';
                }
                setState(() {});
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCorner(Score score) {
    Color color = const Color(0xFF1185fd);
    final String text;
    if (score.name.contains('体育')) {
      text = '体';
    } else if (score.nature.contains("任意选修") || score.nature.contains("公共选修")) {
      text = '选';
    } else if (score.score < 60) {
      text = '!';
      color = Colors.red;
    } else {
      return const SizedBox();
    }
    return Container(
      height: 16,
      width: 16,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 10,
          color: Colors.white,
        ),
        strutStyle: const StrutStyle(
          fontWeight: FontWeight.w600,
          height: 1,
          forceStrutHeight: true,
        ),
      ),
    );
  }
}
