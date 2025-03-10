(require
  hyrule [seq defseq])
(import
  hyrule [Sequence end-sequence inc dec rest])


(defn test-infinite-sequence []
  (assert (= (list (cut (seq [n] n) 5))
             [0 1 2 3 4])))


(defn test-indexing-sequence []
  (defseq shorty [n]
    (cond [(< n 10) n]
          [True (end-sequence)]))
  (setv 0-to-9 (list (range 10)))
  (assert (= (get shorty 0)
             (get 0-to-9 0))
          "getting first element failed")
  (assert (= (get shorty 5)
             (get 0-to-9 5))
          "getting 5th element failed")
  (assert (= (get shorty -1)
             (get 0-to-9 -1))
          "getting element -1 failed"))


(defn test-slicing-sequence []
  (defseq shorty [n]
    (cond [(< n 10) n]
          [True (end-sequence)]))
  (setv 0-to-9 (list (range 10)))
  (assert (= (get shorty 0)
             (get 0-to-9 0))
          "getting first failed")
  (assert (= (list (rest shorty))
             (list (rest 0-to-9)))
          "getting rest failed")
  (assert (= (list (cut shorty 2 6))
             (list (cut 0-to-9 2 6)))
          "cutting 2-6 failed")
  (assert (= (list (cut shorty 2 8 2))
             (list (cut 0-to-9 2 8 2)))
          "cutting 2-8-2 failed")
  (assert (= (list (cut shorty 8 2 -2))
             (list (cut 0-to-9 8 2 -2)))
          "negative cut failed"))


(defn test-recursive-sequence []
  (defseq fibonacci [n]
    (cond [(= n 0) 0]
          [(= n 1) 1]
          [True (+ (get fibonacci (- n 1))
                   (get fibonacci (- n 2)))]))
  (assert (= (get fibonacci 0)
             0)
          "first element of fibonacci didn't match")
  (assert (= (get fibonacci 1)
             1)
          "second element of fibonacci didn't match")
  (assert (= (get fibonacci 40)
             102334155)
          "40th element of fibonacci didn't match")
  (assert (= (list (cut fibonacci 9))
             [0 1 1 2 3 5 8 13 21])
          "taking 8 elements of fibonacci didn't match"))


(defn test-nested-functions []
  (defseq primes [n]
    "infinite sequence of prime numbers"
    (defn divisible? [n prevs]
      "is n divisible by any item in prevs?"
      (any (map (fn [x]
                  (not (% n x)))
                prevs)))
    (defn previous-primes [n]
      "previous prime numbers"
      (cut primes (dec n)))
    (defn next-possible-prime [n]
      "next possible prime after nth prime"
      (inc (get primes (dec n))))
    (cond [(= n 0) 2]
          [True (do (setv guess (next-possible-prime n))
                    (while (divisible? guess (previous-primes n))
                      (setv guess (inc guess)))
                    guess)]))
  (assert (= (list (cut primes 10))
             [2 3 5 7 11 13 17 19 23 29])
          "prime sequence didn't match"))
