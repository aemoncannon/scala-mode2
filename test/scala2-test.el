(defvar scala2-test-abbrevs
  '(("fltf" . font-lock-type-face)
    ("flkf" . font-lock-keyword-face)
    ("flvnf" . font-lock-variable-name-face)
    ("flfnf" . font-lock-function-name-face))
  "Abbreviated face names for use in annotated scala buffers.")

(defvar scala2-test-face-note-re
  "/\\*\\([a-z]+\\)\\*/"
  "RegExp for finding face annotations.")

(defface scala2-test-error-face
  '((((class color)) (:underline "red")))
  "Face used for marking an erroneous region."
  :group 'scala2-test-ui)

(defun scala2-test-show-error (beg end)
  "Mark a region of text as erroneous."
  (let ((ov (make-overlay beg end (current-buffer))))
    (overlay-put ov 'face scala2-test-error-face)
    (overlay-put ov 'scala2-test-error-overlay t)
    ov))

(defun scala2-test-clear-overlays ()
  "Delete all testing overlays from the current buffer."
  (interactive)
  (dolist (ov (overlays-in (point-min) (point-max)))
    (when (overlay-get ov 'scala2-test-error-overlay)
      (delete-overlay ov)
      )))

(defun scala2-test-validate-buffer ()
  "Verify that annotated faces are fontified correctly."
  (interactive)
  (save-excursion
    (scala2-test-clear-overlays)
    (goto-char (point-min))
    (let ((error-count 0))
      (while (search-forward-regexp scala2-test-face-note-re nil t)
	(let ((key (match-string 1)))
	  (when (assoc key scala2-test-abbrevs)
	    (let ((expected-face (cdr (assoc key scala2-test-abbrevs))))
	      (save-excursion
		(search-backward-regexp scala2-test-face-note-re nil t)
		(backward-char)
		(when (not (equal (face-at-point) expected-face))
		  (scala2-test-show-error (point) (+ (point) 5))
		  (incf error-count))
		)))))
      (if (> error-count 0)
	  (message "Validation failed with %s errors." error-count)
	(message "Validation successful."))
      )))


