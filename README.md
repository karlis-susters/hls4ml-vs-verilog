# hls4ml-vs-verilog
A performance comparison of the HLS layer implementations in hls4ml against custom Verilog implementations.
For L46.

## Repository structure
/notebooks -- Notebooks that were used to run hls4ml, generate verilog and run synthesis. 

/verilog -- The Verilog code for the custom layer implementations. 

/hls -- contains the attempts at producing custom HLS implementations. This should be used to replace the generated HLS from hls4ml in hls4ml_prj/firmware/nnet_utils

## Guide to reproducing results
- Firstly, follow the instructions in https://github.com/fastmachinelearning/hls4ml-tutorial to get a docker container with Vivado set up.  
Then run the notebooks in /notebooks in the docker container to get the baseline hls4ml synthesis results for the various layers.  

- To get the custom Verilog implementation synthesis results, firstly the corresponding layer type notebook should be run, with a "latency" design, to generate the correct IO frame for the custom Verilog.
Then, there should be a generated verilog implementation in hls4ml_prj/myproject_prj/solution1/syn/verilog  
- The corresponding custom Verilog implementation should replace the myproject.v file in this folder, changing the v extension to sv, because I use SystemVerilog.   
- Then, vivado_synth.tcl should be modified to use the Verilog files instead of VHDL for synthesis.  
- Finally, Vivado synthesis (vsynth) can be run from the notebook again, taking care not to run synth or compile the hls4ml project again, which would overwrite the custom Verilog implementation.  

- For the hls4ml cosim testing to work, the custom Verilog should instead replace hls4ml_prj/myproject_prj/solution1/sim/verilog/myproject.v. Then cosim can be run through hls_model.build at the bottom of the notebooks.

## Work log
28th-30th December -- read FPGA neural net papers and try to find an interesting L46 project topic that has not yet been explored  
31th December -- Try to setup docker container with hls4ml and vivado  
1st January -- Continue struggling with Vivado setup, learn usage of hls4ml.  
2nd January -- Run initial experiments with hls4ml and Vivado synthesis. Start implementing a verilog dense layer.  
3rd January -- Finish and test the dense layer, run experiments with it. Run some experiments with Vivado place & route, not just synthesis.  
4th January -- Experiment with 8-bit dense. Try to optimise HLS for dense.  
5th January -- Implement and test the 1D convolution layer. Run experiments with it.  
6th January -- Implement and test the 2D convolution layer. Run experiments with it.  
7th January -- Run 8-bit convolution experiments. Investigate reasons for Verilog underperformance in Dense 8-bit.   
8th January -- Investigate more causes for HLS area overhead. Look at the convolution "resource" implementation latency.  
9th January to 16th January -- Report writeup, intermittent with additional reading, and more investigations into HLS behaviour to explain observed phenomena.  
