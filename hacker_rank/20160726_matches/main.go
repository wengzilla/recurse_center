package main
import ("fmt"
  "bufio"
  "os"
  "strings"
  "strconv"
)


func findShortest(matches [][]int) [][]int {
  currentMatches := matches[len(matches) - 1]
  
  if len(currentMatches) != 0 {
    fmt.Println(len(currentMatches))
  } else {
    return matches[:len(matches) - 1]
  }

  min := findMin(currentMatches)

  nextMatches := []int{}

  for _, match := range currentMatches {
    if match - min != 0 {
      nextMatches = append(nextMatches, match - min)
    }
  }

  return findShortest(append(matches, nextMatches))
}

func findMin(arr []int) int {
  min := arr[0]
  for i := range arr {
    if arr[i] < min {
      min = arr[i]
    }
  }
  return min
}

func stringsToInts(arr []string) []int {
  results := []int{}
  for _, i := range arr {
    result, _ := strconv.Atoi(i)
    results = append(results, result)
  }
  return results
}

func main() {
  inputReader := bufio.NewReader(os.Stdin)
  inputReader.ReadString('\n')
  matches, _ := inputReader.ReadString('\n')

  matchesArr := stringsToInts(strings.Fields(matches))
  findShortest([][]int{matchesArr})
}