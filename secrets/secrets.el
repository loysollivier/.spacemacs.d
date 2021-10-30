(setq my-super-list '(
                      ("mth-reg" . ("cd /arm/projectscratch/pd/pj02794_matterhorn/loyoll01/reg/mth/simulation/core_tb/"
                                    "source setupTB"
                                    ""
                                    ))
                      ("mth-dev" . ("cd /arm/projectscratch/pd/pj02794_matterhorn/loyoll01/dev/mth/simulation/core_tb/"
                                    "source setupTB"
                                    ""
                                    ))
                      ("mth-junk" . ("cd /arm/projectscratch/pd/pj02794_matterhorn/loyoll01/junk/mth/simulation/core_tb/"
                                    "source setupTB"
                                    ""
                                    ))
                      ("mth-cov" . ("cd /arm/projectscratch/pd/pj02794_matterhorn/loyoll01/cov/mth/simulation/core_tb/"
                                    "source setupTB"
                                    ""
                                    ))
                      ("asterix-unit" . ("cd /arm/projectscratch/pd/pj02794_matterhorn/loyoll01/asterix"
                                         "source dotshrc"
                                         ""
                                         ))
                      ("asterix-tb" . ("cd /arm/projectscratch/pd/pj02794_matterhorn/loyoll01/asterix"
                                       "cd example_tb"
                                       "export ASTERIX_ROOT=\"..\""
                                       "source dotshrc"
                                       "blk_setup"
                                       ""
                                       ))
                      ))

(setq magit-blacklist-repo '("/arm/projectscratch/pd/pj02794_matterhorn/loyoll01/workdir-6/mth/"
                             "/arm/projectscratch/pd/pj02794_matterhorn/loyoll01/dev/mth/"
                             "/arm/projectscratch/pd/pj02794_matterhorn/loyoll01/cov/mth/"
                             "/arm/projectscratch/pd/pj02794_matterhorn/loyoll01/reg/mth/"))
;; instead of cd: let default-directory
