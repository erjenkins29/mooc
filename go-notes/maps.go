package main

import "fmt"

/* maps:
  go's built-in associative data-type
  variable length, unordered

  python equivalent: dictionaries
*/

func main(){

 m := make(map[string]int)

 m["one"] = 1
 m["two"] = 2
 fmt.Println(m["one"])
 
 delete(m, "one")
 fmt.Println(m)

 // optional second returned value of a map is a boolean
 // whether the key exists in the dictionary
 _, isakey := m["one"]
 fmt.Println(isakey)



}

/* Important syntax:

*/
