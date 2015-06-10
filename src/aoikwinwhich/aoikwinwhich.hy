;
(import os)
(import os.path)

;
(defn list_uniq [item_s]
    ;
    (setv item_s_uniq [])

    (for [item item_s]
        (if (not (in item item_s_uniq))
            ; then
            (item_s_uniq.append item)
            ; else
            None
        )
    )

    ; Return
    item_s_uniq
)

;
(defn find_exe_paths [prog]
    ; 8f1kRCu
    (setv env_pathext (os.environ.get "PATHEXT" None))

    ; 4fpQ2RB
    (if (not env_pathext)
        ; then
        ; Return
        []
        ; else
        (do
            ; 6qhHTHF
            ; Split into a list of extensions
            (setv ext_s (env_pathext.split os.pathsep))

            ; 2pGJrMW
            ; Strip
            (setv ext_s (list-comp (x.strip) [x ext_s]))

            ; 2gqeHHl
            ; Remove empty.
            ; Must be done after the stripping at 2pGJrMW.
            (setv ext_s (list-comp x [x ext_s] (!= x "")))

            ; 2zdGM8W
            ; Convert to lowercase
            (setv ext_s (list-comp (x.lower) [x ext_s]))

            ; 2fT8aRB
            ; Uniquify
            (setv ext_s (list_uniq ext_s))

            ; 4ysaQVN
            (setv env_path (os.environ.get "PATH" None))

            ;
            (setv dir_path_s
                ; 5gGwKZL
                (if (not env_path)
                    ; then
                    ; 7bVmOKe
                    ; Go ahead with "dir_path_s" being empty
                    []
                    ; else
                    ; 6mPI0lg
                    ; Split into a list of dir paths
                    (env_path.split os.pathsep)
                )
            )

            ; 5rT49zI
            ; Insert empty dir path to the beginning
            ;
            ; Empty dir handles the case that "prog" is a path, either
            ; relative or absolute. See code 7rO7NIN.
            (dir_path_s.insert 0 "")

            ; 2klTv20
            ; Uniquify
            (setv dir_path_s (list_uniq dir_path_s))

            ; 9gTU1rI
            ; Check if "prog" ends with one of the file extension in
            ; "ext_s".
            ;
            ; "ext_s" are all in lowercase, ensured at 2zdGM8W.
            (setv prog_lc (prog.lower))

            (setv prog_has_ext (prog_lc.endswith (tuple ext_s)))
            ; "endswith" requires tuple, not list.

            ; 6bFwhbv
            (setv exe_path_s [])

            (for [dir_path dir_path_s]
                (do
                    ; 7rO7NIN
                    ; Synthesize a path
                    (setv path
                        (if (= dir_path "")
                            ; then
                            prog
                            ; else
                            (os.path.join dir_path prog)
                        )
                    )

                    ; 6kZa5cq
                    ; If "prog" ends with executable file extension
                    (if prog_has_ext
                        ; then
                        ; 3whKebE
                        (if (os.path.isfile path)
                            ; then
                            ; 2ffmxRF
                            (exe_path_s.append path)
                            ; else
                            None
                        )
                        ; else
                        None
                    )

                    ; 2sJhhEV
                    ; Assume user has omitted the file extension
                    (for [ext ext_s]
                        (do
                            ; 6k9X6GP
                            ; Synthesize a path with one of the file extensions
                            ; in PATHEXT
                            (setv path_2 (+ path ext))

                            ; 6kabzQg
                            (if (os.path.isfile path_2)
                                ; then
                                ; 7dui4cD
                                (exe_path_s.append path_2)
                                ; else
                                None
                            )
                        )
                    )
                )
            )

            ; 8swW6Av
            ; Uniquify
            (setv exe_path_s (list_uniq exe_path_s))

            ; 7y3JlnS
            ; Return
            exe_path_s
        )
    )
)

; 4zKrqsC
; Program entry
(defmain [&rest args]
    ; 9mlJlKg
    ; If not exactly one command argument is given
    (if (!= (len args) 2)
        ; then
        (do
            ; 7rOUXFo
            ; Print program usage
            (print r"Usage: aoikwinwhich PROG

#/ PROG can be either name or path
aoikwinwhich notepad.exe
aoikwinwhich C:\Windows\notepad.exe

#/ PROG can be either absolute or relative
aoikwinwhich C:\Windows\notepad.exe
aoikwinwhich Windows\notepad.exe

#/ PROG can be either with or without extension
aoikwinwhich notepad.exe
aoikwinwhich notepad
aoikwinwhich C:\Windows\notepad.exe
aoikwinwhich C:\Windows\notepad")

            ; 3nqHnP7
            ; Exit
            ;
            ; Hy 0.11.0 on Windows prints "defmain"'s return value, instead of
            ; setting the return value as exit code. So we return None here to
            ; avoid the printing.
            None
        )
        ; else
        (do
            ; 9m5B08H
            ; Get executable name or path
            (setv prog (. args[1]))

            ; 8ulvPXM
            ; Find executable paths
            (setv exe_path_s (find_exe_paths prog))

            ; 5fWrcaF
            ; If has found none
            (if (not exe_path_s)
                ; then
                ; Exit
                None
                ; else
                ; If has found some
                ;
                (do
                    ; 9xPCWuS
                    ; Print result
                    (print ((. "\n" join) exe_path_s))

                    ; 4s1yY1b
                    ; Exit
                    None
                )
            )
        )
    )
)
