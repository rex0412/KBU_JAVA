public class GCD {
    private int num1;
    private int num2;
    private int gcd;

    public GCD(int num1, int num2, int gcd) {
        this.num1 = num1;
        this.num2 = num2;
        this.gcd = gcd;
    }

    public int getNum1() {
        return num1;
    }

    public void setNum1(int num1) {
        this.num1 = num1;
    }

    public int getNum2() {
        return num2;
    }

    public void setNum2(int num2) {
        this.num2 = num2;
    }

    public int getGcd() {
        return gcd;
    }

    public void setGcd(int gcd) {
        this.gcd = gcd;
    }

    @Override
    public String toString() {
        return String.format("%d, %d의 GCD(최대공약수)는 %d입니다.", num1, num2, gcd);
    }
}
