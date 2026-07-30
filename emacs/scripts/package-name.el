(load (expand-file-name "common.el" (file-name-directory load-file-name)))

(require 'package)

(defconst my-package-desc (with-temp-buffer
                            (insert-file-contents (expand-file-name "../boogie-friends.el" base-directory))
                            (package-buffer-info)))

(defconst my-package-version (package-desc-full-name my-package-desc))

(defun my-package-version ()
  (princ my-package-version))

(defun my-write-pkg-file ()
  (package-generate-description-file
   my-package-desc (expand-file-name "boogie-friends-pkg.el" (pop command-line-args-left))))
