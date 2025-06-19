public class Account {
    private String accountNumber; // 계좌번호
    private String password; // 비밀번호
    private String owner; // 예금주
    private double balance; // 잔액
    private double interestRate; // 이율

    public Account(String accountNumber, String password, String owner,
                   double balance, double interestRate) {
        this.accountNumber = accountNumber;
        this.password = password;
        this.owner = owner;
        this.balance = balance;
        this.interestRate = interestRate;
    }

    public String getAccountNumber() {
        return accountNumber;
    }

    public void setAccountNumber(String accountNumber) {
        this.accountNumber = accountNumber;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    public double getBalance() {
        return balance;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }

    public double getInterestRate() {
        return interestRate;
    }

    public void setInterestRate(double interestRate) {
        this.interestRate = interestRate;
    }

    @Override // 비밀번호는 출력되면 안되므로 제외
    public String toString() {
        return "Account { " +
                "계좌번호 = '" + accountNumber + '\'' +
                ", 예금주 = '" + owner + '\'' +
                ", 잔액 = " + balance +
                ", 이율 = " + interestRate + "% " +
                '}';
    }
}
