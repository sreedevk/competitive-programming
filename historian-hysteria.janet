(def example (string/join
               ["3   4"
                "4   3"
                "2   5"
                "1   3"
                "3   9"
                "3   3"] "\n"))

(def parser
  (peg/compile
    ~{:main (* :lines)
      :lines (any (group :line))
      :line (* :number :spaces :number (choice "\n" -1))
      :spaces (any :s)
      :number (/ (<- (any :d)) ,scan-number)}))

(defn transpose [list]
  (map
    (fn [x] (map |($ x) list))
    (range (length (list 0)))))

(defn similarity-score [item list]
  (->>
    (filter |(= $ item) list)
    (length)
    (* item)))

(defn aggr-similarity-score [[la lb]]
  (->
    (map (fn [lx] (similarity-score lx lb)) la)
    (sum)))

(defn solve-a [input]
  (->> (peg/match parser input)
       (transpose)
       (map |(sort $))
       (transpose)
       (map (fn [[x y]] (math/abs (- x y))))
       (sum)))

(defn solve-b [input]
  (->
    (peg/match parser input)
    (transpose)
    (aggr-similarity-score)))

(defn main [&]
  (do
    (print "Solution Day 1 (A): " (solve-a (slurp "./data/historian-hysteria.txt")))
    (print "Solution Day 1 (B): " (solve-b (slurp "./data/historian-hysteria.txt")))))
