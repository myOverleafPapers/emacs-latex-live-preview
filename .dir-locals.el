((TeX-mode . ((eval . (progn
                        (message "Debug: Starting LaTeX mode configuration")

                        ;; Set up package management
                        (require 'package)
                        (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
                        (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
                        (package-initialize)

                        ;; Function to ensure a package is installed
                        (defun ensure-package-installed (package)
                          "Ensure that PACKAGE is installed."
                          (unless (package-installed-p package)
                            (condition-case nil
                                (package-install package)
                              (error
                               (package-refresh-contents)
                               (package-install package)))))

                        ;; List of required packages
                        (dolist (pkg '(auctex reftex company-reftex flycheck magictex cdlatex texlab digestif)) 
                          (ensure-package-installed pkg))

                        (message "Debug: Required packages checked and installed if necessary")

                        ;; Disable the startup screen
                        (setq inhibit-startup-screen t)
                        (message "Debug: Startup screen disabled")

                        ;; Function to export LaTeX to HTML and open preview using LaTeXML
                        (defun refresh-latex-html-preview ()
                          "Export LaTeX to HTML using LaTeXML, close existing preview, and open a new one."
                          (message "Debug: Entering refresh-latex-html-preview function")
                          (when (and (eq major-mode 'latex-mode) (buffer-file-name))
                            (let* ((latex-file (expand-file-name (buffer-file-name)))
                                   (html-file (concat (file-name-sans-extension latex-file) ".html")))
                              (message "Debug: latex-file: %s" latex-file)
                              (message "Debug: html-file: %s" html-file)
                              (message "Debug: Attempting to export %s to %s" latex-file html-file)
                              (condition-case err
                                  (progn
                                    ;; Close existing eww window if it exists
                                    (when (get-buffer-window "*eww*")
                                      (delete-window (get-buffer-window "*eww*"))
                                      (message "Debug: Closed existing eww window"))

                                    ;; Export to HTML using LaTeXML (replace with your LaTeXML command)
                                    (shell-command (format "latexmlmath %s --destination=%s" latex-file html-file))
                                    (message "Debug: Successfully exported %s to %s" latex-file html-file)

                                    ;; Open new preview
                                    (split-window-right)
                                    (other-window 1)
                                    (eww-open-file html-file)
                                    (other-window 1)
                                    (message "Debug: Opened new HTML preview in eww"))
                                (error (message "Debug: Error during refresh: %s" err))))))

                        ;; Function to maximize the window
                        (defun maximize-frame ()
                          "Maximize the current frame"
                          (interactive)
                          (set-frame-parameter nil 'fullscreen 'maximized)
                          (message "Debug: Window maximized"))
                        
                        ;; Function to check if the buffer is 'main.tex'
                        (defun is-main-tex ()
                          "Check if the current buffer is 'main.tex'."
                          (and (buffer-file-name)
                               (string= (file-name-nondirectory (buffer-file-name)) "main.tex")))

                        ;; Add functions to be run after file is loaded
                        (add-hook 'find-file-hook 
                                  (lambda ()
                                    (when (and (eq major-mode 'latex-mode) (is-main-tex))
                                      (run-at-time "0.5 sec" nil 'maximize-frame)
                                      (run-at-time "1 sec" nil 'refresh-latex-html-preview))))

                        ;; Add function to update preview on save
                        (add-hook 'after-save-hook 
                                  (lambda ()
                                    (when (and (eq major-mode 'latex-mode) (is-main-tex))
                                      (refresh-latex-html-preview))))

                        (message "Debug: Added hooks for maximization, initial preview, and refresh-on-save")

                        ;; Message to confirm loading
                        (message "Debug: LaTeX mode configuration loaded"))))))
