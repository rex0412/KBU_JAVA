public class Company extends House {
    public Company(String name, String number, double usage) {
        super(name, number, usage);
    }

    @Override
    public String toString() {
        return super.toString() + String.format("  %.1f    %,d원    %,d원    %,d원",
                getUsage(), (int) getCharge('3'), (int) getTax('3'), (int) getCollection('3'));
    }
}
