import java.io.*;
import java.util.*;
public class LeapRunner{
        public static void main(String[] args){
                LeapController  lc = new LeapController();
                System.out.println("Press Enter to quit...");
        try {
            System.in.read();
        } catch (IOException e) {
            e.printStackTrace();
        }
        }
}