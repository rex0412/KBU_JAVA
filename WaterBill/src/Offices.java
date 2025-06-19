public class Offices extends House {
    public Offices(String name, String number, double usage) {
        super(name, number, usage);
    }

    @Override
    public String toString() {
        return super.toString() + String.format("  %.1f    %,d원    %,d원    %,d원",
                getUsage(), (int) getCharge('4'), (int) getTax('4'), (int) getCollection('4'));
    }
}
