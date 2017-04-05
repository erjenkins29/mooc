package main

import "fmt"

func main(){

 var a [5]int
 fmt.Println("assign empty length-5 integer array:",a)

 // set value at index 4
 a[4] = 202
 fmt.Println("\nsetting value at index 4:",a)

 // get value at index 4
 fmt.Println("\n get value at index 4:",a[4])

 fmt.Println("array length:",len(a))
}

/* Important syntax:


*/
