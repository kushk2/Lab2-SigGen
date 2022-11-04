#cleanup

rm -rf obj_dir
rm -f sinegen.vcd

#Run the verilator to translate .sv (Verilog) into c++, including c++ testbench

verilator -Wall --cc --trace sinegen.sv --exe sinegen_tb.cpp

#build c++ project automaticlaly, using "make", generated by verilator

make -j -C obj_dir/ -f Vsinegen.mk Vsinegen

#run executable

obj_dir/Vsinegen