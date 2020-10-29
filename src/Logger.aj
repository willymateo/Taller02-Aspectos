import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDateTime;

public aspect Logger {
	pointcut success() : call(* money*(..) );
    after() : success() {
    	try (BufferedWriter bw = new BufferedWriter(new FileWriter("log.txt", true))) {
    		LocalDateTime fecha = LocalDateTime.now();
    		
    		String linea = new String("" +", " +fecha);
    		System.out.println(linea);
    		
    		bw.write(linea);
    	} catch (IOException io) {
    		System.out.println("No se pudo encontrar el archivo");
    	}
    }
	
    
}
