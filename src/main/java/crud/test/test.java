package crud.test;

import java.util.Scanner;

public class test {
    static int get1(int x,int y){
        if(y==0)
            return 25;
        else
            return -get1(x-1,y+1)+3*get1(x,y+1)-get1(x+1,y+1);
    }
    public static void main(String[] args) {
        int a,b;
        Scanner scanner=new Scanner(System.in);
        a=scanner.nextInt();
        b=scanner.nextInt();
        System.out.println(get1(a, b));



    }
}
