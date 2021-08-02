#!/bin/bash



rm -fr /develop/way/deng/amoeba_move/build/*

/develop/app/diem/target/debug/move-build \
	/develop/way/tpm/amoeba_move/src/*/*.move \
	-d /develop/app/diem/language/diem-framework/modules/*.move \
	-d /develop/app/diem/language/move-stdlib/modules/*.move \
	-d /develop/app/diem/language/move-stdlib/nursery/*.move \
	-o /develop/way/tpm/amoeba_move/build

