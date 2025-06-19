public class Business extends House {
    public Business(String name, String number, double usage) {
        super(name, number, usage);
    }

    @Override
    public String toString() {
        return super.toString() + String.format("  %.1f    %,d원    %,d원    %,d원",
                getUsage(), (int) getCharge('2'), (int) getTax('2'), (int) getCollection('2'));
    }
}
