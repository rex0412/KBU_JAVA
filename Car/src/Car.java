public class Car extends Vehicle {
    public Car(String owner, String manufacturer, String model, int year,
               String carType, String fuelType, int cc, double price) {
        super(owner, manufacturer, model, year, carType, fuelType, cc, price);
    }

    @Override
    public double calculateBaseTax() {
        double rate;
        if (price <= 1800000) rate = 0.007;
        else if (price <= 3600000) rate = 0.008;
        else rate = 0.009;

        double baseTax = price * rate;
        int exceedYears = getExceedYears(2025);
        if (exceedYears > 0) {
            baseTax += baseTax * exceedYears / 100.0;
        }
        return baseTax;
    }

    @Override
    public double calculateEducationTax(double baseTax) {
        return baseTax * 0.10;
    }

    @Override
    public double calculateEnvironmentalTax(double baseTax) {
        if (fuelType.equalsIgnoreCase("Diesel")) {
            return baseTax * 0.07;
        }
        return 0.0;
    }
}
