(defclass cart ()
  ((x :initarg :x :reader cart-x)
   (y :initarg :y :reader cart-y)))

(defclass polar ()
  ((radius :initarg :radius :accessor radius)
   (angle  :initarg :angle  :accessor angle))
)

(defmethod cart-x ((p polar))
  (float (* (radius p) (cos (angle p))) 1.0)
)

(defmethod cart-y ((p polar))
  (float (* (radius p) (sin (angle p))) 1.0)
)

(defgeneric to-cart (arg)
  (:method ((c cart))
    c
  )
  (:method ((p polar))
    (make-instance 'cart
      :x (cart-x p)
      :y (cart-y p)
    )
  )
)

(defun l-belong (point1 point2 point3 &optional (tolerance 0))
  (>= tolerance (/ (abs (+ (* (- (cart-y point2) (cart-y point1)) (cart-x point3))
                          (* (- (cart-x point1) (cart-x point2)) (cart-y point3))
                          (* (cart-x point2) (cart-y point1))
                          (* (- 0 1) (cart-y point2) (cart-x point1))))
                 (sqrt (+ (* (- (cart-y point2) (cart-y point1)) (- (cart-y point2) (cart-y point1)))
                          (* (- (cart-x point2) (cart-x point1)) (- (cart-x point2) (cart-x point1)))))))

)


(defgeneric main (v1 v2 v3 &optional tolerance)
  (:method ((c1 cart) (c2 cart) (c3 cart) &optional (tolerance 0))
    (OR (l-belong c1 c2 c3 tolerance) (l-belong c1 c3 c2 tolerance) (l-belong c2 c3 c1 tolerance))
  )
  (:method ((p1 polar) (p2 polar) (p3 polar) &optional (tolerance 0))
    (OR (l-belong (to-cart p1) (to-cart p2) (to-cart p3) tolerance) (l-belong (to-cart p1) (to-cart p3) (to-cart p2) tolerance) (l-belong (to-cart p2) (to-cart p3) (to-cart p1) tolerance))
  )
)

;(main (make-instance 'polar :radius 10 :angle ( - (/ (* 3 pi) 4))) (make-instance 'polar :radius 1 :angle ( - (/ (* 6 pi) 8))) (make-instance 'polar :radius 3 :angle (/ pi 4)))
;(main (make-instance 'cart :x 1 :y 1) (make-instance 'cart :x 2 :y 2) (make-instance 'cart :x 4 :y 3))
;(main (make-instance 'cart :x 1 :y 1) (make-instance 'cart :x 2 :y 2) (make-instance 'cart :x 4 :y 3) 1)
