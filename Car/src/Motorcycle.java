public class Motorcycle extends Vehicle {
    public Motorcycle(String owner, String manufacturer, String model, int year,
                      int cc, double price) {
        super(owner, manufacturer, model, year, "오토바이", "Diesel", cc, price);
    }

    @Override
    public double calculateBaseTax() {
        double rate;
        if (cc <= 90) rate = 0.005;
        else if (cc <= 180) rate = 0.006;
        else rate = 0.007;

        double baseTax = price * rate;
        int exceedYears = getExceedYears(2025);
        if (exceedYears > 0) {
            baseTax += baseTax * exceedYears / 100.0;
        }
        return baseTax;
    }

    @Override
    public double calculateEducationTax(double baseTax) {
        return 0.0;
    }

    @Override
    public double calculateEnvironmentalTax(double baseTax) {
        return baseTax * 0.07;
    }
}
