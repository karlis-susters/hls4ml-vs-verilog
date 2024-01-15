#ifndef NNET_DENSE_CUSTOM_H_
#define NNET_DENSE_CUSTOM_H_

#include "hls_stream.h"
#include "nnet_common.h"
#include "nnet_mult.h"
#include <assert.h>
#include <math.h>

namespace nnet {

template <class data_T, class res_T, typename CONFIG_T>
void dense_custom(data_T data[CONFIG_T::n_in], res_T res[CONFIG_T::n_out],
                               typename CONFIG_T::weight_t weights[CONFIG_T::n_in * CONFIG_T::n_out],
                               typename CONFIG_T::bias_t biases[CONFIG_T::n_out]) {

    const int rufactor = CONFIG_T::reuse_factor;
    const int num_dsps = DIV_ROUNDUP(CONFIG_T::n_in * CONFIG_T::n_out, rufactor);
    //const int block_factor = DIV_ROUNDUP(CONFIG_T::n_in * CONFIG_T::n_out, CONFIG_T::reuse_factor);
    assert (num_dsps >= CONFIG_T::n_out);
    const int num_parallel_cols = num_dsps / CONFIG_T::n_out;
    const int nin = CONFIG_T::n_in;
    const int nout = CONFIG_T::n_out;
    assert(num_dsps == 128);
    assert(nin == 16);
    assert(nout == 64);

    //assert((multiplier_limit % nout == 0 || rufactor >= nin) && "The current Reuse Factor is not allowed");
    //assert((multiplier_limit == block_factor) && "This function is correct only for RF <= N_IN");

    #pragma HLS function_instantiate variable=weights,biases
    //#pragma HLS RESOURCE variable=weights core=RAM_2P_BRAM Commenting out the deisgnation HLS seems to choose correctly
    #pragma HLS ARRAY_RESHAPE   variable=weights block factor=num_dsps
    #pragma HLS ARRAY_PARTITION variable=biases complete
    
    #pragma HLS stable variable=data
    #pragma HLS stable variable=weights
    #pragma HLS stable variable=biases

    typename CONFIG_T::accum_t acc[CONFIG_T::n_out];
    typename CONFIG_T::accum_t last_prod1[CONFIG_T::n_out];
    typename CONFIG_T::accum_t last_prod2[CONFIG_T::n_out];
    #pragma HLS ARRAY_PARTITION variable=acc complete
    #pragma HLS ARRAY_PARTITION variable=last_prod1 complete
    #pragma HLS ARRAY_PARTITION variable=last_prod2 complete

    #pragma HLS ALLOCATION operation instances=mul limit=CONFIG_T::multiplier_limit
    //#pragma HLS PIPELINE off
    //#pragma HLS PIPELINE II=CONFIG_T::reuse_factor
InitAccum:
    for (int iacc = 0; iacc < nout; iacc++) {
        #pragma HLS UNROLL
        acc[iacc] = (typename CONFIG_T::accum_t)biases[iacc];
        last_prod1[iacc] = 0;
        last_prod2[iacc] = 0;
    }

ReuseLoop:
    for (int ir = 0; ir < rufactor; ir++) {
        #pragma HLS PIPELINE II=8
        int w_index = ir*num_parallel_cols*nout;
        int in_index = ir*num_parallel_cols;
    MultLoopRows:
        for (int row = 0; row < nout; row++) {
            //#pragma HLS UNROLL
            //#pragma HLS PIPELINE 
            acc[row] += 
                CONFIG_T::template product<data_T, typename CONFIG_T::weight_t>::product(data[in_index], weights[w_index]) + 
                CONFIG_T::template product<data_T, typename CONFIG_T::weight_t>::product(data[in_index+1], weights[w_index+nout]);
    
            w_index += 1;
        }
    }

// Cast to "res_t" type
Result:
    for (int ires = 0; ires < CONFIG_T::n_out; ires++) {
        #pragma HLS UNROLL
        res[ires] = cast<data_T, res_T, CONFIG_T>(acc[ires]);
    }
}


}
#endif