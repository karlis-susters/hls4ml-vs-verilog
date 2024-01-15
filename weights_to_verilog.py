# A utility script to convert a list of flotaing point weights into a verilog array of fixed point numbers

import struct
import math

def float_to_fixed_point(value, integer_bits=8, fractional_bits=8):
    scale_factor = 2 ** fractional_bits
    fixed_point_value = int(value * scale_factor) if (value > 0) else int(math.floor(value*scale_factor))
    return fixed_point_value

def int_to_hex_bytes(integer_value):
    # Specify the number of bytes you want in the output
    num_bytes = 1
    byte_representation = integer_value.to_bytes(num_bytes, byteorder='big', signed=True)
    return byte_representation.hex()

def main():
    weights = [
        0.28108, -0.28074, 0.24655, 0.17637, 0.21598, -0.16836, 0.22973, 0.14653, -0.25934, -0.23010, 0.15737, 0.30703, 0.28357, -0.23491, -0.17725, -0.30426, 0.18190, 0.26760, -0.15906, -0.27633, 0.00447, -0.17353, -0.12015, 0.19359, 0.11656
    ]
    biases =  [
        -1.26169
    ]
    
    integer_bits = 3
    fractional_bits = 5
    total_bits = integer_bits + fractional_bits

    weights_fixed = [float_to_fixed_point(value, integer_bits, fractional_bits) for value in weights]
    biases_fixed = [float_to_fixed_point(value, integer_bits, fractional_bits) for value in biases]

    num_weights = len(weights)
    num_biases = len(biases)
    
    print (f"localparam [{total_bits-1}:0] weights [0:{num_weights-1}] = " + "{")
    for number in weights_fixed:
        print (f"{total_bits}'h{int_to_hex_bytes(number)}, ", end="")
        
    print ("};")
    print (f"localparam [{total_bits-1}:0] biases [0:{num_biases-1}] = " + "{")
    for number in biases_fixed:
        print (f"{total_bits}'h{int_to_hex_bytes(number)}, ", end = "")
    print("};")
if __name__ == "__main__":
    main()
