setup:
	verilator -Wall --cc rtl/* --exe tb/sim_main.cpp

setup-trace:
	verilator -Wall --cc rtl/*--exe tb/sim_main_trace.cpp --trace

compile: obj_dir/Vcore.mk
	make -C obj_dir -f Vcore.mk Vcore -j

clean:
	rm -rf obj_dir *.vcd