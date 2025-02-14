// people_select_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'people_select_bloc.dart';
import 'people_select_event.dart';
import 'people_select_state.dart';

class PeopleSelectPage extends StatelessWidget {
  const PeopleSelectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PeopleSelectBloc>(
      create: (_) => PeopleSelectBloc(),
      child: Builder(
        builder: (context) {
          // 이 context는 이제 BlocProvider 하위임
          return Container(
            height: MediaQuery.of(context).size.height * 0.7,
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
            ),
            child: Column(
              children: [
                // 닫기 버튼
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(height: 10),
                // 제목
                const Text(
                  "인원 선택",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                // 인원 선택 UI 영역
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 인원 수 표시 (BLoC 상태 사용)
                      BlocBuilder<PeopleSelectBloc, PeopleSelectState>(
                        builder: (context, state) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24.0,
                              vertical: 8.0,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              "${state.peopleCount} 명",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                      ),
                      // 증가/감소 버튼
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              context
                                  .read<PeopleSelectBloc>()
                                  .add(const PeopleIncrement());
                            },
                            icon: const Icon(Icons.add, color: Colors.blue),
                            splashRadius: 20,
                          ),
                          IconButton(
                            onPressed: () {
                              context
                                  .read<PeopleSelectBloc>()
                                  .add(const PeopleDecrement());
                            },
                            icon: const Icon(Icons.remove, color: Colors.red),
                            splashRadius: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // 선택 버튼
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      "선택",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
