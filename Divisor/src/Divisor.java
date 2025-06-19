public class Divisor {
    private int number;   // 자연수
    private String divisor;   // 약수들
    private int divisorSum;   // 약수의 합

    public Divisor(int number, String divisor, int divisorSum) {
        this.number = number;
        this.divisor = divisor;
        this.divisorSum = divisorSum;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public String getDivisor() {
        return divisor;
    }

    public void setDivisor(String divisor) {
        this.divisor = divisor;
    }

    public int getDivisorSum() {
        return divisorSum;
    }

    public void setDivisorSum(int divisorSum) {
        this.divisorSum = divisorSum;
    }

    @Override
    public String toString() {
        return String.format("%d의 약수는 %s입니다.\n약수의 합은 %d입니다.",
                number, divisor, divisorSum);
    }
}
