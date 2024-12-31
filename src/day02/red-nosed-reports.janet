(def parser
  (peg/compile
    ~{:main (any (* :number (choice :s -1)))
      :number (/ (<- (any :d)) ,scan-number)}))

(defn differences [report]
  (->>
    (range 0 (- (length report) 1))
    (map
      (fn [index] (- (report (+ index 1)) (report index))))))

(defn within-limit [item]
  (and
    (<= (math/abs item) 3)
    (>= (math/abs item) 1)))

(defn all-positive [items]
  (all |(>= $ 0) items))

(defn all-negative [items]
  (all |(< $ 0) items))

(defn all-within-limit [differences]
  (all within-limit differences))

(defn is-safe-differences [report-differences]
  (and
    (all-within-limit report-differences)
    (or
      (all-positive report-differences)
      (all-negative report-differences))))

(defn is-safe [report]
  (->>
    (differences report)
    (is-safe-differences)))

(defn solve-a [input]
  (->>
    (string/split "\n" input)
    (map |(string/trim $))
    (map |(peg/match parser $))
    (filter is-safe)
    (length)))

(defn solve-b [input] 31)
