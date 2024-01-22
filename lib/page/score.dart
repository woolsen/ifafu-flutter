import 'package:flutter/material.dart';
import 'package:flutter_picker/picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ifafu/http/model.dart';
import 'package:ifafu/page/score_ies.dart';
import 'package:ifafu/page/score_ies_filter.dart';
import 'package:ifafu/provider/score_provider.dart';
import 'package:ifafu/route/slide.dart';
import 'package:ifafu/widget/if_app_bar.dart';
import 'package:ifafu/widget/if_picker.dart';
import 'package:ifafu/widget/score_chart.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ScorePage extends StatefulWidget {
  const ScorePage({Key? key}) : super(key: key);

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  final _refreshController = RefreshController();

  final _nameTextStyle = const TextStyle(
    fontSize: 18,
    color: Color(0xFF1185fd),
  );

  final _scoreTextStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Color(0xFF1185fd),
  );

  int yearIndex = -1;
  int ternIndex = -1;

  static const _divider = Divider(
    height: 1,
    thickness: 1,
    indent: 32,
    endIndent: 32,
    color: Color(0xFFF0F0F0),
  );

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final AsyncValue<ScoreTable?> scoreTable =
          ref.watch(scoreTableNotifierProvider);
      if (scoreTable is AsyncData && yearIndex == -1) {
        final options = scoreTable.value!.options;
        yearIndex = options.defaultYearIndex;
        ternIndex = options.defaultTermIndex;
      }
      final List<Score> scores;
      if (scoreTable case AsyncData(:final ScoreTable value)) {
        scores = filterScore(value);
      } else {
        scores = [];
      }
      return Scaffold(
        appBar: IFAppBar(
          title: '成绩查询',
          actions: [
            IconButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  SlidePageRoute(child: ScoreIesFilterPage(scores: scores)),
                );
              },
              tooltip: '筛选纳入智育分计算的课程',
              icon: const Icon(
                Icons.filter_list_outlined,
                size: 24,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFFFFFFF),
        body: SmartRefresher(
          controller: _refreshController,
          onRefresh: () async {
            try {
              ref.read(scoreTableNotifierProvider.notifier).refreshScores();
              _refreshController.refreshCompleted();
            } catch (e) {
              print(e);
              _refreshController.refreshFailed();
            }
          },
          child: switch (scoreTable) {
            AsyncData(:final ScoreTable value) => _buildScoreList(value),
            AsyncError() => Text(
                'Oops, something unexpected happened, error: ${scoreTable.error}'),
            _ => const CircularProgressIndicator(),
          },
        ),
      );
    });
  }

  List<Score> filterScore(ScoreTable table) {
    final scores = table.data;
    final options = table.options;
    return scores.where((element) {
      if (element.year == options.years[yearIndex] &&
          element.term == options.terms[ternIndex]) {
        return true;
      }
      return false;
    }).toList();
  }

  Widget _buildScoreList(ScoreTable table) {
    final scores = filterScore(table);
    final title = _getSemesterString(table);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildTitle(title, table.options, scores),
          const SizedBox(height: 4),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return _buildScoreItem(scores[index]);
            },
            separatorBuilder: (context, index) => _divider,
            itemCount: scores.length,
          ),
        ],
      ),
    );
  }

  //[0]:智育分小数点前位数，[1]:智育分的小数点后两位(包括小数点)
  Future<List<String>> _calcIES(List<Score> scores) async {
    if (scores.isEmpty) {
      return ['0', ''];
    }
    double totalScore = 0; // 总得分
    double totalCredit = 0; // 总学分
    double totalMinus = 0; // 需扣除的智育分
    for (final score in scores) {
      final iesScore = score.iesScore;
      if (iesScore == -1) {
        continue;
      }
      totalScore += (iesScore * score.credit);
      totalCredit += score.credit;
      if (iesScore < 60) {
        totalMinus += score.credit;
      }
    }
    if (totalCredit == 0) {
      return ['0', ''];
    }
    final result = totalScore / totalCredit - totalMinus;
    var before = result.toInt();
    var after = ((result - before) * 100).round();
    if (after % 10 == 0) {
      after = after ~/ 10;
    }
    return [
      before.toString(),
      after != 0
          ? after < 10
              ? '.0$after'
              : '.$after'
          : after.toString()
    ];
  }

  final _dividerWidth = 12.0;
  final _boxDecoration = const BoxDecoration(
    color: Color(0xFFF0F0F0),
    borderRadius: BorderRadius.all(Radius.circular(12)),
  );

  Widget _buildScoreItem(Score score) {
    final scoreTextStyle = score.score >= 60
        ? _scoreTextStyle
        : _scoreTextStyle.copyWith(color: Colors.red);
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      color: Colors.white,
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
          const SizedBox(width: 16),
          Text(
            score.score.toString(),
            style: scoreTextStyle,
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

  String _getSemesterString(ScoreTable table) {
    final options = table.options;
    if (options.years.isEmpty || options.terms.isEmpty) {
      return '';
    }
    final year = options.years[yearIndex];
    final term = options.terms[ternIndex];
    return '$year学期第$term学期';
  }

  Widget _buildTitle(
    String title,
    SemesterOptions options,
    List<Score> scores,
  ) {
    double gpa = 0.0;
    double credit = 0.0;
    for (var score in scores) {
      gpa += score.gpa;
      credit += score.credit;
    }
    return Container(
      padding: const EdgeInsets.only(top: 8, left: 24, right: 24, bottom: 8),
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: GestureDetector(
              onTap: () => _showOptionsDialog(options),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 210,
            child: Row(
              children: [
                _buildBigTitleItem(scores),
                SizedBox(width: _dividerWidth),
                Expanded(
                  child: Column(
                    children: [
                      _buildLittleTitleItem(
                        '课程数',
                        '${scores.length}门',
                      ),
                      SizedBox(height: _dividerWidth),
                      _buildLittleTitleItem(
                        '学分',
                        '${credit.toStringAsFixed(2)}分',
                      ),
                      SizedBox(height: _dividerWidth),
                      _buildLittleTitleItem(
                        '绩点',
                        gpa.toStringAsFixed(2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBigTitleItem(List<Score> scores) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            SlidePageRoute(
              child: ScoreIesPage(
                scores: scores,
              ),
            ),
          );
        },
        child: Container(
          decoration: _boxDecoration,
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              LayoutBuilder(builder: (context, constraints) {
                return Align(
                  child: CustomPaint(
                    size: Size(constraints.maxWidth, constraints.maxHeight),
                    painter: ScoreChartPainter(scores),
                  ),
                );
              }),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FutureBuilder<List<String>>(
                      future: _calcIES(scores),
                      initialData: const ['-', ''],
                      builder: (context, data) {
                        if (!data.hasData) {
                          return const SizedBox();
                        }
                        final ies = data.data!;
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              ies[0],
                              style: const TextStyle(
                                fontSize: 44,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                height: 1,
                              ),
                            ),
                            Text(
                              '${ies[1]}分',
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black87,
                              ),
                              strutStyle: const StrutStyle(leading: 1),
                            ),
                          ],
                        );
                      },
                    ),
                    const Text('智育分'),
                  ],
                ),
              ),
              const Positioned(
                bottom: 12,
                left: 0,
                right: 0,
                child: Text(
                  '点击查看智育分详情',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF666666), fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLittleTitleItem(String label, String text) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        width: double.infinity,
        decoration: _boxDecoration,
        child: Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 17,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Text(
              text,
              style: const TextStyle(
                fontSize: 17,
                color: Colors.black87,
              ),
              strutStyle: const StrutStyle(
                height: 1,
                fontSize: 20,
                forceStrutHeight: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOptionsDialog(SemesterOptions options) async {
    final pickItems = <PickerItem<String>>[];
    for (var year in options.years) {
      final children = <PickerItem<String>>[];
      for (var term in options.terms) {
        children.add(PickerItem(
          value: '$term',
          text: Text('$term'),
        ));
      }
      pickItems.add(PickerItem(
        value: year,
        text: Text(year),
        children: children,
      ));
    }
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return IFPicker(
          selected: [yearIndex, ternIndex],
          data: pickItems,
          onConfirm: (picker, value) {
            yearIndex = value[0];
            ternIndex = value[1];
            setState(() {});
          },
        );
      },
    );
  }
}
