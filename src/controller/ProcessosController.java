package controller;

import java.util.Random;
import java.util.LinkedList;
import java.util.Queue;
import models.Processos;

public class ProcessosController {
    static Queue<Processos> filaProcessos = new LinkedList<Processos>();
    static Random random = new Random();

    public static void fcfs(Processos p1, Processos p2, Processos p3) throws InterruptedException {

        filaProcessos.add(p1);
        filaProcessos.add(p2);
        filaProcessos.add(p3);

        int processo = 1;

        while (!filaProcessos.isEmpty()) {

            Processos p = filaProcessos.remove();

            if (p.getInterrupted()) {
                int interrupted = random.nextInt(p.getTime()) + 1;

                for (int j = 0; j < interrupted; j++) {
                    System.out.print("\r"+ p.getName()+" em: " + j + "s");
                    Thread.sleep(1000);
                }
                filaProcessos.add(new Processos(p.getName(), p.getTime(), false, interrupted));

            } else {
                for (int i = p.getTimeSpent(); i <= p.getTime(); i++) {
                    System.out.print("\r" +p.getName() + " em: " + i + "s");
                    Thread.sleep(1000);
                }
            }
            System.out.println();
            processo++;
        }

    }
}