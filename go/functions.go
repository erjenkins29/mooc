package main

import "fmt"

func plus(a int, b int) int {return a + b}

func past_tense(s string) string {
  return s+"ed"
}

// A multiple-output function
func multi_ball()(int,int){
   return 2,2
}


// A variadic function:
func sum(nums ...int){
 fmt.Println(nums)
 total:=0
 for _, val := range nums{
  total += val
 }
 fmt.Println("sum:",total)
}


func main() {
 var verb string 
 verb = "kill"

 fmt.Println("past tense of", verb,"is",past_tense(verb))
 a,b := multi_ball()
 fmt.Println("multiball output: ", a,b)
 sum(1,2,3)
 
 slc := []int{1,2,3,4}

 sum(slc...)

}
