(defun recursive (l lr r)
  (let (
        (res (* r (+ (first l) (first lr))))
        (ltail (rest l))
        (lrtail (rest lr))
       )
    (if (NULL ltail)
      res
      (recursive ltail lrtail res)
    )
  )
)


(defun main (l)
  (recursive l (reverse l) 1)
)
