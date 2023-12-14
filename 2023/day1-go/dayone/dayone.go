package dayone

import (
	"fmt"
	"io/ioutil"
	"regexp"
	"strconv"
	"strings"
	"unicode"
)

func fix_ascii(lines []string) []string {

	patterns := [...]string{`zero`, `one`, `two`, `three`, `four`, `five`, `six`, `seven`, `eight`, `nine`}
	filters := make([]*regexp.Regexp, len(patterns))

	for idx, pattern := range patterns {
		filters[idx] = regexp.MustCompile(pattern)
	}

	ret := make([]string, len(lines))

	for x, line := range lines {
		//fmt.Println(line)
		number := 3
		for number <= len(line) {
			tmp := line[:number]
			//fmt.Println("Trying: " + tmp)
			for y, r := range filters {
				if r.MatchString(tmp) {
					//fmt.Println("Found: " + strconv.Itoa(y))
					line = r.ReplaceAllString((line), strconv.Itoa(y))
				}
			}
			number++
		}
		ret[x] = line
		//fmt.Println(line)
	}
	fmt.Println(ret)
	return ret
}

func Dayone(filename string) int {

	data := make(map[int][]int)
	lines := slurp(filename)
	fixed := fix_ascii(lines)

	// get all digits of each line into a hash
	for x, line := range fixed {
		nums := []int{}
		runes := []rune(line)
		for _, ch := range runes {
			if unicode.IsDigit(ch) {
				nums = append(nums, int(ch-'0'))
			}
		}
		data[x] = nums
	}

	// total it up
	var total int = 0
	for _, nums := range data {
		var first = strconv.Itoa(nums[0])
		var last = strconv.Itoa(nums[len(nums)-1])
		var str = first + last
		var num, _ = strconv.Atoi(str)
		total = total + num
	}

	return total
}

func slurp(f string) []string {
	content, err := ioutil.ReadFile(f)
	check(err)
	text := string(content)
	lines := strings.Split(text, "\n")
	return lines
}

func check(e error) {
	if e != nil {
		panic(e)
	}
}
