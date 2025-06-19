public abstract class Vehicle {
    protected String owner;
    protected String manufacturer;
    protected String model;
    protected int year;
    protected String carType;   // "승용차", "승합차", "오토바이"
    protected String fuelType;  // "Gasoline", "Diesel", "Electricity"
    protected int cc;           // 배기량
    protected double price;

    public Vehicle(String owner, String manufacturer, String model, int year,
                   String carType, String fuelType, int cc, double price) {
        this.owner = owner;
        this.manufacturer = manufacturer;
        this.model = model;
        this.year = year;
        this.carType = carType;
        this.fuelType = fuelType;
        this.cc = cc;
        this.price = price;
    }

    public abstract double calculateBaseTax();
    public abstract double calculateEducationTax(double baseTax);
    public abstract double calculateEnvironmentalTax(double baseTax);

    public double calculateTotalTax() {
        double baseTax = calculateBaseTax();
        double eduTax = calculateEducationTax(baseTax);
        double envTax = calculateEnvironmentalTax(baseTax);
        return baseTax + eduTax + envTax;
    }

    protected int getExceedYears(int currentYear) {
        int age = currentYear - year;
        return age > 10 ? age - 10 : 0;
    }

    public String getOwner() { return owner; }
}
