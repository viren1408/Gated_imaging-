#!/usr/bin/awk -f

BEGIN {
    # Set the output file for coefficients
    coeff_file = "coeff_data_320.dat"
    # Print header for the coefficient file
    print "PSRNAME epoch RPHASE COEFF1 COEFF2 COEFF3" > coeff_file
}

(NR-1) % 3 == 0 {
    epoch = $4;
    PSRNAME = $1
} 

NR % 3 == 2 {
    RPHASE = $1
}

NR % 3 == 0 {
    COEFF1 = $1; COEFF2 = $2; COEFF3 = $3
    print PSRNAME, epoch, RPHASE, COEFF1, COEFF2, COEFF3 >> coeff_file
}

