(defun russian-upper-case-p (char)
  (position char "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ")
)

(defun russian-char-downcase (char)
  (let ((i (russian-upper-case-p char)))
    (if i
        (char "абвгдеёжзийклмнопрстуфхцчшщъыьэюя" i)
        (char-downcase char)
    )
  )
)

(defun russian-char-equal (char1 char2)
  (char-equal (russian-char-downcase char1)
    (russian-char-downcase char2)
  )
)

(defun main (c s)
  (let ((count 0))
    (loop for i from 0 to (- (length s) 1) do
      (if (OR (char= (char s i) #\Space) (char= (char s i) #\Tab) (char= (char s i) #\Newline));
        (if (russian-char-equal (char s (+ i 1)) c);
          (setq count (+ 1 count))
        )
      )
    )
    (if (russian-char-equal (char s 0) c)
        (setq count (+ 1 count))
    )
    count
  )
)
