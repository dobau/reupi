import java.util.concurrent.Executors;
import java.util.concurrent.ThreadPoolExecutor;



public class GerarDicionarioSenha {
    
    private static int size = 8;

    public static void main(String[] args) throws Exception {
        ThreadPoolExecutor executor = (ThreadPoolExecutor) Executors.newFixedThreadPool(500);

        init();
        
        while (hasNext()) {
            executor.execute(new Run(next(), count++));
            
            if (count > 10000) {
                //System.err.println("1000");
                
                while ((executor.getTaskCount() - executor.getCompletedTaskCount()) > 5000) {
                    //System.err.println("Threads: " + (executor.getTaskCount() - executor.getCompletedTaskCount()));
                    Thread.sleep(1000);
                }
                
                count = 0;
            }
        }
        
        executor.shutdown();
        while (!executor.isTerminated()) {
            Thread.sleep(1000);
        }
        
        System.exit(0);
    }

    private static int count = 0;
    private static int[] index = new int[size];
    private static char[] abc = new char[size];
    
    private static void init() {
        for (int i = 0; i < abc.length; i++) {
            abc[i] = '0';
        }
    }
    
    private synchronized static String next() {
        for (int i = 0; i < index.length; i++) {
            if (abc[i] != '}') {
                abc[i]++;
                
                return new String(abc); 
            }
            
            if (i < (abc.length - 1) && abc[i+1] != '}') {
                abc[i] = '0';
            }
        }
        
        return "";
    }

    private static boolean hasNext() {
        for (int i = 0; i < abc.length;i++) {
            if (abc[i] != '}') {
                return true;
            }
        }
        
        return false;
    }
    
}
