(setq my-super-list '(
                      ("xtb" . ("cd $GH/shared"
                                "source dotshrc"
                                "module load $RVCT_MODULE"
                                "cd $GH/logical/testbench/shared/tarmac/"
                                "if [ ! -f verilog/teal_tarmac_capture.sv ];then ./build_tarmac.pl;fi"
                                "cd $GH/logical/testbench/execution_tb/"
                                "bs make run TESTNAME=check_cde_if"
                               ))
                      ("xtb-tests" . ("cd $GH/shared"
                                      "source dotshrc"
                                      "module load $RVCT_MODULE"
                                      "cd $GH/logical/testbench/execution_tb/tests/"
                                      "make clean"
                                      "bs make check_cde_if"
                                      ))
                      ("dvs" . ("cd $GH/shared"
                                "source dotshrc"
                                "module load $RVCT_MODULE"
                                "cd $GH/validation"
                                "source dotrc"
                                "blk_val teal_garda_cde_instruction --dfs console:wave=fsdb --bo tgt1:tarmac=True --build-clean"
                                ))
                      ))

