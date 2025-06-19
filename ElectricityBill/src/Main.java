import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner keyboard = new Scanner(System.in);
        Person[] person = new Person[10];

        for (int i = 0; i < person.length; i++) {
            System.out.print("고객의 번호 입력: ");
            String number = keyboard.next();

            System.out.print("고객의 이름 입력: ");
            String name = keyboard.next();

            // 번호가 9로 시작하면 Special, 아니면 Customer 객체 생성
            if (number.startsWith("9")) {
                person[i] = new Special(number, name);
            } else {
                person[i] = new Customer(number, name);
            }
            person[i].inputData();  // 전기사용량 입력 받기
            System.out.println(" ");
        }

        // 출력
        PowerOffice office = new PowerOffice(person);
        office.display();
    }
}
