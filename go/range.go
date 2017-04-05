package main

import "fmt"

/* range
  prefix used to iterate over a variety of data structures

  python equivalent: built into for loop structure
*/

func main(){

 a:= make([]string, 3)
 a[0] = "a"
 a[1] = "b"
 a[2] = "c"

 fmt.Println(a)

 for _, v := range a {
  fmt.Println(v)
 }
 
 // practicing 2d slice fills
 
 fill := make([][]int,3)
 for i :=0; i<3; i++{
  innerLen:=i+1
  fill[i] = make([]int,innerLen)
  for j:=0; j<innerLen; j++{
   fill[i][j] = i+j
  }
 
 }

 for k,v := range fill{
  fmt.Println(k, v)
  fmt.Println(k, v[0]) 
}



}

/* Important syntax:

   make
   append
*/
