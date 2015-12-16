(require 'request) ;; https://github.com/tkf/emacs-request

(defvar ginger-rephrase-end-point
  "http://ro.gingersoftware.com/rephrase/rephrase")

;;;###autoload
(defun ginger-rephrase (&optional $text $beg $end)
  (interactive)
  (lexical-let* (($text
                  (cond ($text $text)
                        ((and $beg $end)
                         (buffer-substring-no-properties $beg $end))
                        (mark-active
                         (buffer-substring-no-properties
                          (region-beginning) (region-end)))
                        (t (error (message "Require region or argument")))))
                 $res)
    (deactivate-mark t)
    (request
     ginger-rephrase-end-point
     :params `((s . ,$text)
               (callback . "jQuery172018291063443757594_1383792045462")
               (_ . "1383792068397"))
     :parser 'buffer-string
     :success
     (function*
      (lambda (&key data &allow-other-keys)
        (cond (data
               (with-current-buffer (get-buffer-create "*rephrase*")
                 (pop-to-buffer (current-buffer))
                 (goto-char (point-min))
                 (let (($p 0))
                   (while (setq $p (string-match
                                    "\"Sentence\"\:\"\\(.+?\\)\""
                                    data (1+ $p)))
                     (setq $res (cons (match-string-no-properties 1 data)
                                      $res))))
                 (insert
                  (propertize "\n---------------------------------\n"
                              'face 'font-lock-constant-face)
                  )
                 (insert (concat
                          (propertize
                           "Original: " 'face 'font-lock-preprocessor-face)
                          (propertize
                           $text 'face 'font-lock-function-name-face)
                          "\n"))
                 (if $res
                     (insert (mapconcat 'identity $res "\n"))
                   (insert "not found"))
                 (re-search-backward "Original")
                 (next-line 1)))
              (t (error (message "Return no rephrase candidate")))))))))
