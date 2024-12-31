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
