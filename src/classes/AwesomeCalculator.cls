/**
 * Created by solol on 25.12.2019.
 */

public class AwesomeCalculator {
    public static Double add(Double x, Double y) {
        calculatorServices.CalculatorImplPort calculator =
                new calculatorServices.CalculatorImplPort();
        return calculator.doAdd(x,y);
    }
}