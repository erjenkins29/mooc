package main

import "fmt"

func main(){

 a:= make([]string, 3)
 a[0] = "a"
 a[1] = "b"
 a[2] = "c"

 fmt.Println(a)
 
 a = append(a,"d")
 a = append(a,"e","f")
 fmt.Println("appended: ",a)

 c := make([]string, len(a))
 copy(c,a)
 fmt.Println("copy: ",c)

 fmt.Println("slc2to4: ",c[2:4])
 fmt.Println("slc2toend: ",c[2:])
 fmt.Println("slc2to2ndtolast: ",c[2:len(c)-1])

 // practicing 2d slice fills
 
 fill := make([][]int,3)
 for i :=0; i<3; i++{
  innerLen:=i+1
  fill[i] = make([]int,innerLen)
  for j:=0; j<innerLen; j++{
   fill[i][j] = i+j
  }
 
 fmt.Println("filled 2d array:",fill)
 }





}

/* Important syntax:

   make
   append
*/
