package main

import "fmt"
import "time"

func main(){

  i:=3
  switch i{
  case 1: fmt.Println(1)
  case 2: fmt.Println(2)
  case 3: fmt.Println(3)
  }


  switch time.Now().Weekday(){
  case time.Saturday, time.Sunday: fmt.Println("it's a weekend")
  default: fmt.Println("get back to work!")
  }

  whatsMyType := func(i interface{}) {
    switch t := i.(type) {
    case bool: fmt.Println("boolean")
    case int:  fmt.Println("integer")
    default:   fmt.Println("type is %T\n",t)

    }

  }
  whatsMyType(true)
  whatsMyType(9)
  whatsMyType("nihao")


}

/* Important syntax:

   switch
   case
   time (.Now(), .Hour(), .Saturday, .Sunday, .Weekday())
   default
*/
