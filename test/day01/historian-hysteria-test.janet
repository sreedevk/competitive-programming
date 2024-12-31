(import tester :prefix "" :exit true)
(import ../../src/day01/historian-hysteria :as day01)

(def example (string/join
               ["3   4"
                "4   3"
                "2   5"
                "1   3"
                "3   9"
                "3   3"] "\n"))

(deftest
  (test "DAY 01 PART 01"
        (is (= 11 (day01/solve-a example)))))

(deftest
  (test "DAY 01 PART 02"
        (is (= 31 (day01/solve-b example)))))
