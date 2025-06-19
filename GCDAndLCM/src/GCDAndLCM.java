public class GCDAndLCM {
        private int num1;
        private int num2;
        private int gcd;
        private int lcm;

    public GCDAndLCM(int num1, int num2, int gcd, int lcm) {
        this.num1 = num1;
        this.num2 = num2;
        this.gcd = gcd;
        this.lcm = lcm;
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

    public int getLcm() {
        return lcm;
    }

    public void setLcm(int lcm) {
        this.lcm = lcm;
    }

    @Override
        public String toString() {
            return String.format("%d, %d의 GCD(최대공약수)는 %d입니다.\n" +
                    "%d, %d의 LCM(최소공배수)는 %d입니다.", num1, num2, gcd, num1, num2, lcm);
        }
    }
