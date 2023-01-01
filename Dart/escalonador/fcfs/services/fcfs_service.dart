import 'dart:collection';
import 'dart:io';
import 'dart:math';
import '../../models/processo.dart';

class FcfsService {
  Queue<Processo> readyQueue = Queue<Processo>();
  Random random = Random();

  void fcfs(Processo p1, Processo p2, Processo p3) {
    readyQueue.add(p1);
    readyQueue.add(p2);
    readyQueue.add(p3);

    int currentTime = 0;

    while (readyQueue.isNotEmpty) {
      Processo p = readyQueue.removeFirst();

      if (p.getInterrupted) {
        int interrupted = random.nextInt(p.getTime - 1) + 1;
        int timeInterrupted = random.nextInt(15);

        for (int i = 0; i <= interrupted; i++) {
          if (i != 0) {
            stdout.write('\r${p.getName} em: $i s');
            currentTime++;
          }
          sleep(Duration(seconds: 1));
        }
        readyQueue.add(Processo(p.getName, p.getTime, false, interrupted + 1,
            timeInterrupted + currentTime));

        print('\r${p.getName} foi interrompido em: $currentTime s');
      } else {
        for (int i = p.getTimeSpent; i <= p.getTime; i++) {
          if (p.stopInterruptionTime > currentTime) {
            stdout.write('\r${p.getName} está interrompido!');
            sleep(Duration(seconds: 1));
            currentTime++;
            readyQueue.add(p);
            break;
          }

          if (p.stopInterruptionTime == currentTime) {
            print('');
          }

          if (i != 0) {
            stdout.write('\r${p.getName} em: $i s');
            currentTime++;
          }
          sleep(Duration(seconds: 1));

          if (i == p.getTime) {
            print('\r${p.getName} finalizado em: $currentTime s');
          }
        }
      }
    }
    print('Tempo total: $currentTime');
  }
}