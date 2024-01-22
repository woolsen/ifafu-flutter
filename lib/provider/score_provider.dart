import 'dart:convert';

import 'package:ifafu/http/api.dart';
import 'package:ifafu/http/model.dart';
import 'package:ifafu/util/sp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'score_provider.g.dart';

@riverpod
class ScoreTableNotifier extends _$ScoreTableNotifier {
  @override
  FutureOr<ScoreTable> build() async {
    final jsonString = SPUtil.getString('SCORE_TABLE');
    if (jsonString != null) {
      final scoreTableMap = json.decode(jsonString);
      state = AsyncValue.data(ScoreTable.fromJson(scoreTableMap));
    }

    final scoreTable = await fetchScores();
    state = AsyncValue.data(scoreTable);
    return scoreTable;
  }

  /// 从网络获取成绩
  Future<ScoreTable> fetchScores() async {
    final scoreTable = await Api.instance.getScores();
    SPUtil.setString('SCORE_TABLE', json.encode(scoreTable.toJson()));
    state = AsyncValue.data(scoreTable);
    return scoreTable;
  }

  /// 更新成绩
  Future<ScoreTable> refreshScores() async {
    final scoreTable = await Api.instance.refreshScores();
    SPUtil.setString('SCORE_TABLE', json.encode(scoreTable.toJson()));
    state = AsyncValue.data(scoreTable);
    return scoreTable;
  }

  void updateScore(List<Score> scores) {
    print('updateScore');
    final scoreTable = state.valueOrNull;
    if (scoreTable != null) {
      final newScores = scoreTable.data.toList(growable: true);
      for (var value in scores) {
        final index = scoreTable.data.indexWhere((e) => e.id == value.id);
        if (index != -1) {
          newScores[index] = value;
        }
      }
      scoreTable.data = newScores;
      state = AsyncValue.data(scoreTable);
    }
  }
}
