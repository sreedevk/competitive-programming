(import ./day01/historian-hysteria :as d1)
(import ./day02/red-nosed-reports :as d2)

(defn main [&]
  (do
    (print "Solution Day 1 (A): " (d1/solve-a (slurp "./data/historian-hysteria.txt")))
    (print "Solution Day 1 (B): " (d1/solve-b (slurp "./data/historian-hysteria.txt")))
    (print "Solution Day 2 (A): " (d2/solve-a (slurp "./data/red-nosed-reports.txt")))))
