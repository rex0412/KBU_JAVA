import java.util.Scanner;

public abstract class Student extends Person {
    private int kor, eng, math;
    private int sum;
    private float avg;
    private int rank;

    public Student(String hakbun, String name, int kor, int eng, int math, int sum, float avg, int rank) {
        super(hakbun, name);
        this.kor = kor;
        this.eng = eng;
        this.math = math;
        this.sum = sum;
        this.avg = avg;
        this.rank = rank;
    }

    public Student() {
        super("", "");  // 빈 값으로 초기화
    }

    public int getKor() {
        return kor;
    }

    public void setKor(int kor) {
        this.kor = kor;
    }

    public int getEng() {
        return eng;
    }

    public void setEng(int eng) {
        this.eng = eng;
    }

    public int getMath() {
        return math;
    }

    public void setMath(int math) {
        this.math = math;
    }

    public int getSum() {
        return sum;
    }

    public void setSum(int sum) {
        this.sum = sum;
    }

    public float getAvg() {
        return avg;
    }

    public void setAvg(float avg) {
        this.avg = avg;
    }

    public int getRank() {
        return rank;
    }

    public void setRank(int rank) {
        this.rank = rank;
    }

    public void inputData() {
        Scanner keyboard = new Scanner(System.in);
        System.out.print("학번 입력 : ");
        setHakbun(keyboard.nextLine()); // setter 사용
        System.out.print("이름 입력 : ");
        setName(keyboard.nextLine());   // setter 사용
        System.out.print("국어 점수 입력 : ");
        kor = keyboard.nextInt();
        System.out.print("영어 점수 입력 : ");
        eng = keyboard.nextInt();
        System.out.print("수학 점수 입력 : ");
        math = keyboard.nextInt();
        System.out.println();
    }

    public void calculate() {
        sum = kor + eng + math;
        avg = sum / 3.0f;
    }


    private int sum() {
        return kor + eng + math;
    }

    private float avg() {
        return (int) ((kor + eng + math) / 3);
    }

    public abstract void display();

    @Override
    public String toString() {
        return String.format("  %7s   %s   %d   %d   %d   %d   %.2f     %d",
                getHakbun(), getName(), kor, eng, math, sum(), avg(), rank);
    }
}
