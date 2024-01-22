import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifafu/http/model.dart';
import 'package:ifafu/page/score_ies_filter.dart';
import 'package:ifafu/route/slide.dart';
import 'package:ifafu/util/collection.dart';
import 'package:ifafu/util/num.dart';
import 'package:ifafu/widget/if_app_bar.dart';
import 'package:ifafu/widget/if_dialog.dart';
import 'package:ifafu/widget/if_empty_view.dart';

class ScoreIesPage extends StatefulWidget {
  static const ifafuColor = Color(0xFF1185fd);

  final List<Score> scores;

  const ScoreIesPage({Key? key, required this.scores}) : super(key: key);

  @override
  State<ScoreIesPage> createState() => _ScoreIesPageState();
}

class _ScoreIesPageState extends State<ScoreIesPage> {
  final normalTextStyle = const TextStyle(
    color: ScoreIesPage.ifafuColor,
    height: 1.5,
  );

  final boldTextStyle = const TextStyle(
    height: 1.5,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    if (widget.scores.isEmpty) {
      return Scaffold(
        appBar: _buildAppBar(context),
        body: const Center(
          child: IFEmptyView(),
        ),
      );
    }

    // 不计入智育分的成绩
    final exceptScores = widget.scores.where((e) => e.iesIgnore);
    // 计入智育分的成绩
    final iesScores = widget.scores.where((e) {
      return !e.iesIgnore;
    }).toList(growable: false);
    // 不及格的成绩
    final failedScores = iesScores.where((e) {
      return e.score < 60 || (e.makeupScore != -1 && e.makeupScore < 60);
    }).toList(growable: false);
    // 需扣除不及格的学分
    final failedCredit = failedScores.sumDoubleOf((e) => e.credit);

    Widget? ignoreTable;
    if (exceptScores.isNotEmpty) {
      // 排除课程
      ignoreTable = Table(
        columnWidths: const {
          0: FlexColumnWidth(10),
          1: FlexColumnWidth(10),
        },
        border: TableBorder.all(
          color: Colors.black12,
          width: 1,
        ),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          _buildTableRow([
            const Text('排除课程', style: TextStyle(fontWeight: FontWeight.bold)),
            const Text('排除原因', style: TextStyle(fontWeight: FontWeight.bold)),
          ]),
          for (var score in exceptScores)
            _buildTableRow([
              Text(score.name),
              Text(score.iesIgnoreReason ?? ''),
            ]),
        ],
      );
    }

    //不及格课程
    Widget? failedTable;
    if (failedScores.isNotEmpty) {
      failedTable = Table(
        columnWidths: const {
          0: FlexColumnWidth(6),
          1: FlexColumnWidth(2),
          2: FlexColumnWidth(3),
        },
        border: TableBorder.all(
          color: Colors.black12,
          width: 1,
        ),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          _buildTableRow([
            const Text('不及格课程', style: TextStyle(fontWeight: FontWeight.bold)),
            const Text('成绩', style: TextStyle(fontWeight: FontWeight.bold)),
            const Text('扣除智育分', style: TextStyle(fontWeight: FontWeight.bold)),
          ]),
          for (var score in failedScores)
            _buildTableRow([
              Text(score.name),
              Text(
                score.score.toString(),
                textAlign: TextAlign.center,
              ),
              Text(
                score.credit.toString(),
                textAlign: TextAlign.center,
              ),
            ]),
        ],
      );
    }

    // 计算智育分
    double total = iesScores.sumDoubleOf((e) {
      return e.credit * e.iesScore;
    }).roundTo(2);
    double totalCredit = iesScores.sumDoubleOf((e) => e.credit);
    double ies = ((total / totalCredit - failedCredit) * 1000).round() / 1000;

    Widget empty = const SizedBox.shrink();
    List<TableRow> scoreTableRows = [];
    scoreTableRows.add(_buildTableRow([
      const Text('课程名称', style: TextStyle(fontWeight: FontWeight.bold)),
      const Text('成绩', style: TextStyle(fontWeight: FontWeight.bold)),
      empty,
      const Text('学分', style: TextStyle(fontWeight: FontWeight.bold)),
      empty,
      empty,
    ]));
    var first = true;
    for (var score in iesScores) {
      if (!first) {
        scoreTableRows.add(_buildTableRow([
          empty,
          empty,
          empty,
          const Text('+'),
          empty,
          const Text('+'),
        ]));
      } else {
        first = false;
      }
      scoreTableRows.add(_buildTableRow([
        Text(score.name),
        Text(
          score.iesScore.toString(),
          textAlign: TextAlign.center,
        ),
        const Text('×'),
        Text(
          score.credit.toString(),
          textAlign: TextAlign.center,
        ),
        const Text('='),
        Text(
          ((score.score * score.credit * 100).round() / 100).toString(),
          textAlign: TextAlign.center,
        ),
      ]));
    }
    scoreTableRows.add(_buildTableRow([
      empty,
      empty,
      empty,
      const Text('='),
      empty,
      const Text('='),
    ]));
    scoreTableRows.add(_buildTableRow([
      empty,
      empty,
      empty,
      Text('$totalCredit'),
      empty,
      Text('$total'),
    ]));

    Widget scoreTable = Table(
      columnWidths: const {
        0: FlexColumnWidth(10),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(2),
        4: FlexColumnWidth(1),
        5: FlexColumnWidth(3),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: scoreTableRows,
    );
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Container(
          padding: MediaQuery.of(context)
              .padding
              .copyWith(top: 8)
              .add(const EdgeInsets.only(left: 12, right: 12, bottom: 12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (ignoreTable != null) ...[
                ignoreTable,
                const SizedBox(height: 24),
              ],
              if (failedTable != null) ...[
                failedTable,
                const SizedBox(height: 24),
              ],
              scoreTable,
              const SizedBox(height: 4),
              Text(
                '智育分：$total ÷ $totalCredit${failedScores.isEmpty ? '' : ' - $failedCredit'} = $ies',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () => _showIesRuleDialog(context),
                child: const Text(
                  '查看智育分计算规则',
                  style: TextStyle(
                    color: ScoreIesPage.ifafuColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TableRow _buildTableRow(List<Widget> children) {
    return TableRow(
      children: children.map((child) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Center(child: child),
        );
      }).toList(),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return IFAppBar(
      title: '智育分详情',
      actions: [
        IconButton(
          onPressed: () async {
            await Navigator.push(
              context,
              SlidePageRoute(
                child: ScoreIesFilterPage(
                  scores: widget.scores,
                ),
              ),
            );
            setState(() {});
          },
          tooltip: '筛选纳入智育分计算的课程',
          icon: const Icon(
            Icons.filter_list_outlined,
            size: 24,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  void _showIesRuleDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return const IFDialog(
          width: 300,
          title: '智育分计算规则',
          text: '1.若课程纳入智育分计算且正常通过，计算结果为所有课程加权平均，也就是每一门课程成绩与对应学分的乘积和除以总学分。\n'
              '2.对于未通过课程，若补考成绩未出，以期末成绩计算；若补考成绩已出，补考成绩及格以上，则以60计算，否则以补考成绩计算。\n'
              '3.任意选修课、体育课、缓考、免修、重修、补修课程不纳入智育分计算。\n'
              '4.大一第一学期，若有英语2，英语2纳入智育分计算，否则英语1纳入智育分计算；大一第二学期，若有英语3，英语3纳入智育分计算，否则英语2纳入智育分计算...以此类推。\n'
              '5.纳入智育分计算的不及格课程，在依照以上规则计算完毕后，还需扣除对应不及格课程的学分等值的智育分。\n'
              '6.补/免修课程，仅英语课程程序课根据第4条规则可对对应免修课程予以识别和排除，其他免/补修课程请您点击智育分下方的“调整免/补修课程”添加，添加入“调整免/补修课程”列表中的课程将不被纳入智育分计算。',
          cancelText: '收到',
        );
      },
    );
  }
}
