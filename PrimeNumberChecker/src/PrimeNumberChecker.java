public class PrimeNumberChecker {
    private int number;
    private String result;

    public PrimeNumberChecker(int number, String result) {
        this.number = number;
        this.result = result;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    @Override
    public String toString() {
        return String.format("%d은 %s", number, result);
    }
}
