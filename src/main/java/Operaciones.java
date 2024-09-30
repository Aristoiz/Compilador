import java.util.*;

class Nodo {
    String valor;
    Nodo izquierdo, derecho;

    Nodo(String valor) {
        this.valor = valor;
        izquierdo = derecho = null;
    }
}

class ArbolExpresion {

    // Precedencia de los operadores
    static Map<String, Integer> precedencia;

    static {
        precedencia = new HashMap<>();
        precedencia.put("SUMA", 1);
        precedencia.put("RESTA", 1);
        precedencia.put("MULTIPLICACION", 2);
        precedencia.put("DIVISION", 2);
    }

    // Método para construir el árbol de expresión
    public static Nodo construirArbol(String[] tokens) {
        Stack<Nodo> operandos = new Stack<>();
        Stack<Nodo> operadores = new Stack<>();

        for (String token : tokens) {
            if (esOperador(token)) {
                // Procesar precedencia de operadores
                while (!operadores.isEmpty() && precedencia.get(token) <= precedencia.get(operadores.peek().valor)) {
                    Nodo operador = operadores.pop();
                    operador.derecho = operandos.pop();
                    operador.izquierdo = operandos.pop();
                    operandos.push(operador);
                }
                operadores.push(new Nodo(token));
            } else {
                // Si es un operando (número), agregarlo al stack
                operandos.push(new Nodo(token));
            }
        }

        // Procesar operadores restantes
        while (!operadores.isEmpty()) {
            Nodo operador = operadores.pop();
            operador.derecho = operandos.pop();
            operador.izquierdo = operandos.pop();
            operandos.push(operador);
        }

        // El nodo raíz del árbol
        return operandos.peek();
    }

    // Método para verificar si un token es un operador
    private static boolean esOperador(String token) {
        return precedencia.containsKey(token);
    }

    // Método para evaluar el árbol de expresión
    public static double evaluarArbol(Nodo nodo) {
        // Si es un nodo hoja (número), retornamos su valor convertido a double
        if (nodo.izquierdo == null && nodo.derecho == null) {
            return Double.parseDouble(nodo.valor);
        }

        // Evaluar los subárboles
        double izquierdo = evaluarArbol(nodo.izquierdo);
        double derecho = evaluarArbol(nodo.derecho);

        // Aplicar el operador
        switch (nodo.valor) {
            case "SUMA":
                return izquierdo + derecho;
            case "RESTA":
                return izquierdo - derecho;
            case "MULTIPLICACION":
                return izquierdo * derecho;
            case "DIVISION":
                return izquierdo / derecho;
            default:
                throw new IllegalArgumentException("Operador desconocido: " + nodo.valor);
        }
    }
}


public class Operaciones {
    public static void main(String[] args) {
        // Expresión de ejemplo de cualquier longitud
        String input = "10 SUMA 20 MULTIPLICACION 50 RESTA 30 DIVISION 2";
        String[] tokens = input.split(" ");

        // Construir el árbol de expresión
        Nodo raiz = ArbolExpresion.construirArbol(tokens);

        // Evaluar el árbol de expresión
        double resultado = ArbolExpresion.evaluarArbol(raiz);

        // Imprimir el resultado
        System.out.println("Resultado: " + resultado); // Resultado esperado: 970 (10 + (20 * 50) - (30 / 2))
    }
    public Float operacion(String input) {
        String[] tokens = input.split(" ");
        Nodo raiz = ArbolExpresion.construirArbol(tokens);
        return (float) ArbolExpresion.evaluarArbol(raiz);
    }
}

