;;; snakemake-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "snakemake" "snakemake.el" (22378 8912 123035
;;;;;;  145000))
;;; Generated autoloads from snakemake.el

(let ((loads (get 'snakemake 'custom-loads))) (if (member '"snakemake" loads) nil (put 'snakemake 'custom-loads (cons '"snakemake" loads))))

(autoload 'snakemake-graph "snakemake" "\
Display graph for DAG of RULES.

The graph will be displayed with `image-mode'.  From this buffer,
you can call \\<snakemake-graph-mode-map>\\[snakemake-graph-save] to save the graph.

If prefix argument RULE-GRAPH is non-nil, pass --rulegraph
instead of --dag to snakemake.

$ snakemake --{dag,rulegraph} -- RULES | display

\(fn RULES &optional RULE-GRAPH)" t nil)

(autoload 'snakemake-graph-this-file "snakemake" "\
Display graph of DAG for the first rule of the current file.

The graph will be displayed with `image-mode'.  From this buffer,
you can call \\<snakemake-graph-mode-map>\\[snakemake-graph-save] to save the graph.

If RULE-GRAPH is non-nil, pass --rulegraph instead of --dag to
the Snakemake call.  Snakemake is called from DIRECTORY or, if
DIRECTORY is nil, from the current file's directory.

Interactively, \\[universal-argument] indicates to use --rulegraph instead of --dag,
whereas \\[universal-argument] \\[universal-argument] signals to prompt user for a directory from which
to call Snakemake.  With any other non-nil prefix value, both of the
above actions are performed.

$ snakemake -s <current file> --{dag,rulegraph} | display

\(fn &optional RULE-GRAPH DIRECTORY)" t nil)

(autoload 'snakemake-build-targets-at-point "snakemake" "\
Build target(s) at point without any prompts.

$ snakemake [ARGS] -- <targets>

\(fn &optional ARGS)" t nil)

(autoload 'snakemake-build-file-target "snakemake" "\
Build target file.

$ snakemake [ARGS] -- <file>

\(fn &optional ARGS)" t nil)

(autoload 'snakemake-build-rule-target "snakemake" "\
Build target rule, prompting with known rules.

$ snakemake [ARGS] -- <rule>

\(fn &optional ARGS)" t nil)

(autoload 'snakemake-compile "snakemake" "\
Read `compile' command for building targets.

$ snakemake [ARGS] -- <targets>

\(fn &optional ARGS)" t nil)
 (autoload 'snakemake-popup "snakemake" nil t)

;;;***

;;;### (autoloads nil "snakemake-mode" "snakemake-mode.el" (22378
;;;;;;  8912 107027 145000))
;;; Generated autoloads from snakemake-mode.el

(let ((loads (get 'snakemake-mode 'custom-loads))) (if (member '"snakemake-mode" loads) nil (put 'snakemake-mode 'custom-loads (cons '"snakemake-mode" loads))))

(autoload 'snakemake-mode "snakemake-mode" "\
Mode for editing Snakemake files.

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("Snakefile\\'" . snakemake-mode))

(add-to-list 'auto-mode-alist '("\\.\\(?:sm\\)?rules\\'" . snakemake-mode))

(add-to-list 'auto-mode-alist '("\\.snakefile\\'" . snakemake-mode))

;;;***

;;;### (autoloads nil nil ("snakemake-mode-pkg.el") (22378 8912 152677
;;;;;;  801000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; snakemake-mode-autoloads.el ends here
