import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import com.bank.Bank;

public aspect Logger {
	pointcut log() : call(void Bank.money*());
    
	after() : log() {
    	try (BufferedWriter bw = new BufferedWriter(new FileWriter("src/log.txt", true))) {
    		
    		String transType =  thisJoinPoint.getSignature().getName();
    		String fecha = LocalDateTime.now().format(DateTimeFormatter.ofPattern("d-MM-yyyy HH:mm:ss"));
    		    		
    		String linea = new String("");
    		
    		if (transType.equals("moneyMakeTransaction")) {
    			linea += "Realizar transacción, ";
    		}else if (transType.equals("moneyWithdrawal")) {
    			linea += "Retirar dinero, ";
    		}
    		
    		linea += fecha +"\n";
    		System.out.println(linea);
    		bw.write(linea);
    	} catch (IOException io) {
    		System.out.println("No se pudo encontrar el archivo");
    	}
    }
	
}
