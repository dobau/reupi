import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

import com.cgmp.apps.util.GerarSenha;

public class Run extends Thread {
    
    private final String senha;
    private final int count;
    
    public Run(String senha, int count) {
        this.senha = senha;
        this.count = count;
        
        this.setPriority(Thread.MIN_PRIORITY);
    }

    @Override
    public void run() {
        String senhaHash = crypt(senha);
        
        try(BufferedWriter writer = new BufferedWriter(new FileWriter("c:\\dicionario.txt", true))) {
            writer.write(senha);
            writer.write("=");
            writer.write(senhaHash);
            writer.newLine();
        }catch (IOException e) {
            e.printStackTrace();
        }

//        if (count >= 1000) {
//            System.out.println("Executando... " + this);
//        }
    }
    
    @Override
    public String toString() {
        return String.format(" [%s - %s] ", senha, count);
    }

}
