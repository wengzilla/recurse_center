package main
import (
  "fmt"
  "bufio"
  "strconv"
  "os"
  "strings"
  "math"
)

func stringsToInts(arr []string) []int {
  results := []int{}
  for _, i := range arr {
    result, _ := strconv.Atoi(i)
    results = append(results, result)
  }
  return results
}

func main() {
 //Enter your code here. Read input from STDIN. Print output to STDOUT
  inputReader := bufio.NewReader(os.Stdin)    
  countInput, _ := inputReader.ReadString('\n')
  count, _ := strconv.Atoi(strings.TrimSpace(countInput))
  args := [][]int{}

  for i := 0; i <= count; i++ {
    input, _ := inputReader.ReadString('\n')
    args = append(args, stringsToInts(strings.Fields(input)))
  }

  for _, arg := range args {
    a := float64(arg[0])
    b := float64(arg[1])
    x := int64(arg[2])
    fmt.Println(int64(math.Pow(a, b)) - int64(math.Pow(a, b)) % x)
  }
}