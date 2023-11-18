#!/usr/bin/awk -f

BEGIN {
    # Define an array of frequencies
    frequencies_str = "320 321 322 323 324";  # Add more frequencies if needed
    split(frequencies_str, frequencies);

    # Loop through the frequencies and process each one
    for (i = 1; i <= length(frequencies); i++) {
        # Set the output file for coefficients based on the current frequency
        coeff_file = "coeff_data_" frequencies[i] ".dat";

        # Print header for the coefficient file
        print "PSRNAME epoch f0 RPHASE COEFF1 COEFF2 COEFF3" > coeff_file;
    }
}

(NR-1) % 3 == 0 {
    epoch = $4;
    PSRNAME = $1
} 

NR % 3 == 2 {
    RPHASE = $1;
    f0 = $2
}

NR % 3 == 0 {
    COEFF1 = $1; COEFF2 = $2; COEFF3 = $3

    # Loop through the frequencies and print data to the corresponding file
    for (i = 1; i <= length(frequencies); i++) {
        coeff_file = "coeff_data_" frequencies[i] ".dat";
        print PSRNAME, epoch,f0,RPHASE, COEFF1, COEFF2, COEFF3 >> coeff_file;
    }
}

