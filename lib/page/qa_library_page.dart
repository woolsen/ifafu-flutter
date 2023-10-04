import 'package:flutter/material.dart';
import 'package:ifafu/http/api.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class QaLibraryPage extends StatefulWidget {
  const QaLibraryPage({Key? key}) : super(key: key);

  @override
  State<QaLibraryPage> createState() => _QaLibraryPageState();
}

///词条库
class _QaLibraryPageState extends State<QaLibraryPage> {
  final itemScrollController = ItemScrollController();
  final itemPositionsListener = ItemPositionsListener.create();

  final highlightIndex = ValueNotifier<int>(0);
  List<String>? indexes;
  List<List<String>>? questions;

  Object? error;

  @override
  void initState() {
    super.initState();
    Api.instance.queryQaLibrary().then((res) {
      indexes = res.keys.toList();
      questions = res.values.toList();
      setState(() {});
    }).catchError((err) {
      error = err;
      setState(() {});
    });
    itemPositionsListener.itemPositions.addListener(() {
      final positions = itemPositionsListener.itemPositions.value;
      if (positions.isNotEmpty) {
        final index = positions
            .reduce((value, element) =>
                value.index < element.index ? value : element)
            .index;
        highlightIndex.value = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (error != null) {
      body = const Center(
        child: Text('词条库获取失败'),
      );
    } else if (indexes == null || questions == null) {
      body = const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      body = Column(
        children: [
          //提示：点击即可查询
          Container(
            color: const Color(0xFFFFF8EB),
            width: double.infinity,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: const Text(
              '提示：点击即可查询',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFFF8AA54),
              ),
            ),
          ),
          Expanded(child: _buildList()),
        ],
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('词条库'),
      ),
      body: body,
    );
  }

  Widget _buildList() {
    return Row(
      children: [
        const SizedBox(width: 12),
        Expanded(
          child: ScrollablePositionedList.builder(
            itemScrollController: itemScrollController,
            itemPositionsListener: itemPositionsListener,
            itemCount: questions!.length,
            itemBuilder: (context, index) {
              //indexes[index]作为标题，questions[index]作为内容，question按行排列，超过换行
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4, top: 8, bottom: 2),
                    child: Text(
                      indexes![index],
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  //item为Chip，按行排列，超过换行
                  Wrap(
                    spacing: 8,
                    runSpacing: 0,
                    children:
                        questions![index].map((e) => _buildChip(e)).toList(),
                  ),
                ],
              );
            },
          ),
        ),
        _buildIndexWidget(),
      ],
    );
  }

  Widget _buildChip(String question) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop(question);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        margin: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            width: 1.2,
            color: Theme.of(context).highlightColor,
          ),
        ),
        child: Text(question),
      ),
    );
  }

  Widget _buildIndexWidget() {
    const secondaryColor = Colors.grey;
    return ValueListenableBuilder(
      valueListenable: highlightIndex,
      builder: (context, position, child) {
        List<Widget> indexWidgets = [];
        //查找index最小的positions
        final indexes = this.indexes!;
        for (int i = 0; i < indexes.length; i++) {
          final highlight = position == i;
          indexWidgets.add(
            Expanded(
              child: GestureDetector(
                onTap: () {
                  itemScrollController.scrollTo(
                    index: i,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOutCubic,
                  );
                },
                child: Container(
                  width: 32,
                  decoration: BoxDecoration(
                      color: highlight ? Colors.blue : Colors.transparent,
                      borderRadius: BorderRadius.circular(40)),
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(right: 2),
                  child: Text(
                    indexes[i],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: highlight ? FontWeight.w900 : null,
                      color: highlight ? Colors.white : secondaryColor,
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 36),
          child: Column(
            children: indexWidgets,
          ),
        );
      },
    );
  }
}
