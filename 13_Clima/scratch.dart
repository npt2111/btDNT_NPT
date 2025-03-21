import 'dart:io';

void main() {
  performTasks();
}

void performTasks() async {
  task1();

  String task2Result = await task2(); // Chờ task2 hoàn thành

  task3(task2Result); // Truyền kết quả task2 vào task3
}

void task1() {
  print('Task 1 complete');
}

Future<String> task2() async {
  Duration threeSeconds = Duration(seconds: 3);

  return await Future.delayed(threeSeconds, () {
    print('Task 2 complete');
    return 'task 2 data'; // Trả về dữ liệu sau khi hoàn thành
  });
}

void task3(String task2Data) {
  print('Task 3 complete with $task2Data');
}
