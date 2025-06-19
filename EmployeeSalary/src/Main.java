import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner keyboard = new Scanner(System.in);
        Employee[] employees = new Employee[10];
        int count = 0;

        for (int i = 0; i < 10; i++) {
            System.out.print("사원 구분 <1:정규직, 2:영업직, 3:점장직, 4:일당제> : ");
            int choice = keyboard.nextInt();

            System.out.print("사번: ");
            String id = keyboard.next();
            System.out.print("이름: ");
            String name = keyboard.next();

            if (choice == 1) {
                System.out.print("[정규직] " + name + "님의 급수 입력 : ");
                char grade = keyboard.next().charAt(0);
                employees[count++] = new Regular(id, name, grade);
                System.out.println();
            } else if (choice == 2) {
                System.out.print("[영업직] " + name + "님의 급수 입력 : ");
                char grade = keyboard.next().charAt(0);
                System.out.print("[영업직] " + name + "님의 판매 금액 입력 : ");
                double sales = keyboard.nextDouble();
                System.out.print("[영업직] " + name + "님의 커미션 비율 입력 : ");
                double rate = keyboard.nextDouble();
                employees[count++] = new Salesman(id, name, grade, sales, rate);
                System.out.println();
            } else if (choice == 3) {
                System.out.print("[점장직] " + name + "님의 급수 입력 : ");
                char grade = keyboard.next().charAt(0);
                System.out.print("[점장직] " + name + "님의 인센티브 입력 : ");
                double incentive = keyboard.nextDouble();
                employees[count++] = new Manager(id, name, grade, incentive);
                System.out.println();
            } else if (choice == 4) {
                System.out.print("[일당제] " + name + "님의 일당 입력 : ");
                int dailyWage = keyboard.nextInt();
                System.out.print("[일당제] " + name + "님의 작업 일수 입력 : ");
                int days = keyboard.nextInt();
                employees[count++] = new Temporary(id, name, days, dailyWage);
                System.out.println();
            }
        }

        for (int i = 0; i < count; i++) {
            employees[i].computeSalary();
        }

        sort(employees, count);

        line();
        System.out.println("                     경복주식회사 급여 대장");
        line();
        System.out.println("사번     이름     급      day      일당          기본급            세금            지급액        비고");
        line();

        for (int i = 0; i < count; i++) {
            employees[i].printData();
        }

        line();

        double totalPay = 0;
        for (int i = 0; i < count; i++) {
            totalPay += employees[i].net;
        }
        System.out.printf("       지급액 합계: %,d원\n", (int) totalPay);
        line();

        // 커미션 내역
        System.out.println("\n            영업직 사원 커미션 산출 내역");
        line();
        System.out.print("사번      이름      급      판매 실적      요율      커미션 금액\n");
        line();

        for (int i = 0; i < count; i++) {
            if (employees[i] instanceof Salesman) {
                ((Salesman) employees[i]).printCommissionData();
            }
        }

        line();
    }

    public static void sort(Employee[] employees, int count) {
        for (int i = 0; i < count - 1; i++) {
            for (int j = i + 1; j < count; j++) {
                if (employees[i].net < employees[j].net) {
                    Employee temp = employees[i];
                    employees[i] = employees[j];
                    employees[j] = temp;
                }
            }
        }
    }

    public static void line() {
        System.out.println("*********************************************************************************************");
    }
}
