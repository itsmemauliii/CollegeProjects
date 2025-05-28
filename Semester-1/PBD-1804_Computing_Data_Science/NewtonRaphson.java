import java.util.Scanner;

public class NewtonRaphson {

    // Define the function f(x) = x^2 - 3
    public static double f(double x) {
        return x * x - 3;
    }

    // Define the derivative f'(x) = 2x
    public static double fPrime(double x) {
        return 2 * x;
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.print("Enter initial guess: ");
        double x0 = sc.nextDouble();

        System.out.print("Enter tolerance (e.g. 0.0001): ");
        double tolerance = sc.nextDouble();

        System.out.print("Enter maximum iterations: ");
        int maxIter = sc.nextInt();

        double x1;
        int i = 1;
        while (i <= maxIter) {
            double fx = f(x0);
            double fpx = fPrime(x0);

            if (fpx == 0) {
                System.out.println("Derivative is zero. Try a different initial guess.");
                return;
            }

            x1 = x0 - fx / fpx;

            System.out.printf("Iteration %d: x = %.6f%n", i, x1);

            if (Math.abs(x1 - x0) < tolerance) {
                System.out.printf("Root found: %.6f after %d iterations%n", x1, i);
                return;
            }

            x0 = x1;
            i++;
        }

        System.out.println("Did not converge within maximum iterations.");
    }
}

