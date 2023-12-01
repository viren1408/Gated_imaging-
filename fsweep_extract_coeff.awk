#!/usr/bin/awk -f

BEGIN {
    # Define an array of frequencies
    frequencies_str = "320 330 340 350 360 370 380 390 400 410 420 430 440 450 460 470 480 490 500 510 520 530 540 550 560 570 580 590 600 610 620 630 640 650 660 670 680 690 700 710 720 730 740 750 760 770 780 790 800 810 820 830 840 850 860 870 880 890 900 910 920 930 940 950 960 970 980 990 1000 1010 1020 1030 1040 1050 1060 1070 1080 1090 1100 1110 1120 1130 1140 1150 1160 1170 1180 1190 1200 1210 1220 1230 1240 1250 1260 1270 1280 1290 1300 1310 1320 1330 1340 1350 1360 1370 1380 1390 1400 1410 1420 1430 1440";  # Add more frequencies if needed
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

