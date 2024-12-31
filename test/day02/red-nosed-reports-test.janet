(import tester :prefix "" :exit true)
(import ../../src/day02/red-nosed-reports :as day02)

(def example
  (string/join
    ["7 6 4 2 1"
     "1 2 7 8 9"
     "9 7 6 2 1"
     "1 3 2 4 5"
     "8 6 4 4 1"
     "1 3 6 7 9"] "\n"))

(deftest
  (test "DAY 02 PART 01"
        (is (= 2 (day02/solve-a example)))))

(deftest
  (test "DAY 02 PART 02"
        (is (= 31 (day02/solve-b example)))))
