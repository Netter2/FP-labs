(defun main (A u v i j)
  (let ((B (make-array (list (+ 1 (array-dimension A 0)) (+ 1 (array-dimension A 1)))))
        (m (array-dimension A 0))
        (n (array-dimension A 1))
       )
    (loop for ii from 0 to (- m 1) do
      (loop for jj from 0 to (- n 1) do
        (cond
         ((AND (< ii i) (< jj j)) (setf (aref B ii jj) (aref A ii jj)))
         ((AND (< ii i) (>= jj j)) (setf (aref B ii (+ 1 jj)) (aref A ii jj)))
         ((AND (>= ii i) (< jj j)) (setf (aref B (+ 1 ii) jj) (aref A ii jj)))
         ((AND (>= ii i) (>= jj j)) (setf (aref B (+ 1 ii) (+ 1 jj)) (aref A ii jj)))
        )
      )
    )
    (loop for k from 0 to (- n 1) do
      (if (< k j)
        (setf (aref B i k) (aref u k))
       (setf (aref B i (+ k 1)) (aref u k))
      )
    )
    (loop for l from 0 to m do
      (setf (aref B l j ) (aref v l))
    )
    B
  )
)
