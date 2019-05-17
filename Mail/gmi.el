(defgroup gmi nil "gmi customization group"
  :group 'convenience)

(defcustom gmi-exit-hook nil
  "Hook run after `gmi' is done."
  :group 'gmi
  :type 'hook)

(defcustom gmi-executable (executable-find "gmi")
  "Where to find the `gmi' utility."
  :group 'gmi
  :type 'string)

(defcustom gmi-args '("sync")
  "List of options to pass to the `gmi' command."
  :group 'gmi
  :type '(repeat string))

(defcustom gmi-auto-accept-certs nil
  "Accept all certificates if true."
  :group 'gmi
  :type 'boolean)

(defcustom gmi-verbose 'normal
  "How many messages to print to minibuffer.  See `gmi-log-levels'."
  :group 'gmi
  :type 'boolean)

(defface gmi-font-lock-error-face
  '((t (:foreground "yellow" :background "red" :bold t)))
  "Face description for all errors."
  :group 'gmi)

;; Newer versions of gmi just report C:, B:, M:, or S: for progress.
(defcustom gmi-status-line-re (rx (or "Channel "
                                         (and (any ?m ?c ?b ?s) ": "))
                                     (+ (any alnum ?/)))
                                 ;; (rx bol "Channel " (+ (any alnum)) eol)
  "Regex which matches an output line to show it in the echo-area."
  :group 'gmi
  :type 'string)

(defvar gmi-process-filter-pos nil)

(defvar gmi-buffer-name "*gmi*")

(defun gmi-elem-index (elt lst)
  "Return index of ELT in LST, or nil if not found."
  (let ((i 0))
    (catch 'found
      (dolist (e lst)
        (if (eq e elt)
            (throw 'found i)
          (incf i))))))

(defvar gmi-log-levels '(quiet normal verbose debug))

(defun gmi-log-level-int (severity)
  "Get the log level of SEVERITY as int."
  (or (gmi-elem-index severity gmi-log-levels)
      0))

(defun gmi-log (severity &rest args)
  "If SEVERITY is less than `gmi-verbose', show user the message ARGS."
  (when (>= (gmi-log-level-int gmi-verbose)
            (gmi-log-level-int severity))
    (apply #'message args)))

(defun gmi-sentinel (proc change)
  "Mail sync is over, message it then run `gmi-exit-hook'.
Arguments PROC, CHANGE as in `set-process-sentinel'."
  (when (eq (process-status proc) 'exit)
    (gmi-log 'normal (format "gmi is done: %s" change))
    (when (not (eq (process-exit-status proc) 0))
      (switch-to-buffer-other-window (process-buffer proc)))
    (run-hooks 'gmi-exit-hook)))

(defun gmi-get-proc ()
  "Get the running gmi process (or nil if no such)."
  (let ((b (get-buffer "*gmi*")))
    (and (buffer-live-p b)
         (get-buffer-process b))))

(defun gmi (&optional show-buffer)
  "Run the `gmi' command from gmailieer, asynchronously, then run `gmi-exit-hook'.
If SHOW-BUFFER, also show the *gmi* output."
  (interactive "P")
  (if (gmi-get-proc)
      (message "Please wait, gmi is already fetching, see buffer *gmi* for details.")
    (let* ((dummy (when (get-buffer gmi-buffer-name)
                    (kill-buffer gmi-buffer-name)))
           (default-directory "/home/loys/.mail/account.gmail")
           (proc (apply 'start-process
                        gmi-buffer-name
                        gmi-buffer-name
                        gmi-executable
                        gmi-args)))
      (set-process-sentinel proc 'gmi-sentinel)))
  (when show-buffer
    (set-window-buffer (selected-window)
                       (process-buffer (gmi-get-proc)))))

(provide 'gmi)

;;; gmi.el ends here
