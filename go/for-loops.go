package main

import "fmt"

func main(){

   for i:=2; i<11; i++{    
     if i%2==0 { fmt.Println("iteration:", i) }
     if i==9  { 
       fmt.Println("break at", i)
       break
     }
   }
}

/* Important syntax:
   for
   if {} else if {} else {}
   %
   break
   continue
*/
