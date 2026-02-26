# utl-altair-slc-reading-and-writing-hdf5-files-with-open-source-matlab-python-and-r
Altair-slc-reading-and-writing-hdf5-files-with-open-source-matlab-python-and-r
    %let pgm=utl-altair-slc-reading-and-writing-hdf5-files-with-open-source-matlab-python-and-r;

    %stop_submission;

    Altair-slc-reading-and-writing-hdf5-files-with-open-source-matlab-python-and-r

    Too long to post on a list,see github
    https://github.com/rogerjdeangelis/utl-altair-slc-reading-and-writing-hdf5-files-with-open-source-matlab-python-and-r

    Problem read write h5(hdf5) files

       1 r write read h5
       2 python write read h5 (most flexible?)
       3 matlab write read h5

    Note The .hdf5 extension is more explicit but fully interchangeable with h5.

    I did not test if matlab, r and python hdf5 files can be read by the other two languages.

    How to install rhdf5 package

    In R default IDE
    install.packages("BiocManager")
    BiocManager::install("rhdf5")

    /*                   _
    (_)_ __  _ __  _   _| |_
    | | `_ \| `_ \| | | | __|
    | | | | | |_) | |_| | |_
    |_|_| |_| .__/ \__,_|\__|
            |_|
    */
    libname workx "d:/wpswrkx"; /*-- put this in your autoexec ---*/

    proc datasets lib=workx kill;
    run;

    %utlfkil(d:/h5/r_inp.h5);
    %utlfkil(d:/h5/r_out.h5);

    options validvarname=upcase;
    data workx.class;
     informat
       NAME $8.
       SEX $1.
       AGE 8.
       HEIGHT 8.
       WEIGHT 8.
       ;
     input NAME SEX AGE HEIGHT WEIGHT;
    cards4;
    Alfred M 14 69 112.5
    Alice F 13 56.5 84
    Barbara F 13 65.3 98
    Carol F 14 62.8 102.5
    Ronald M 15 67 133
    Thomas M 11 57.5 85
    William M 15 66.5 112
    ;;;;
    run;quit;

    /**************************************************************************************************************************/
    /* WORKX.CLASS total obs=7 26FEB2026:12:19:51                                                                             */
    /*                                                                                                                        */
    /* Obs     NAME      SEX    AGE    HEIGHT    WEIGHT                                                                       */
    /*                                                                                                                        */
    /*  1     Alfred      M      14     69.0      112.5                                                                       */
    /*  2     Alice       F      13     56.5       84.0                                                                       */
    /*  3     Barbara     F      13     65.3       98.0                                                                       */
    /*  4     Carol       F      14     62.8      102.5                                                                       */
    /*  5     Ronald      M      15     67.0      133.0                                                                       */
    /*  6     Thomas      M      11     57.5       85.0                                                                       */
    /*  7     William     M      15     66.5      112.0                                                                       */
    /*                                                                                                                        */
    /**************************************************************************************************************************/

    /*                        _ _                            _   _     ____
    / |  _ __  __      ___ __(_) |_ ___   _ __ ___  __ _  __| | | |__ | ___|
    | | | `__| \ \ /\ / / `__| | __/ _ \ | `__/ _ \/ _` |/ _` | | `_ \|___ \
    | | | |     \ V  V /| |  | | ||  __/ | | |  __/ (_| | (_| | | | | |___) |
    |_| |_|      \_/\_/ |_|  |_|\__\___| |_|  \___|\__,_|\__,_| |_| |_|____/
    */

    %utlfkil(d:/h5/students_to_h5.h5);

    options set=RHOME "C:\Progra~1\R\R-4.5.2\bin\r";
    proc r;
    export data=workx.class r=students;
    submit;
    library(rhdf5)

    # student dataframe to h5 file
    h5write(students, "d:/h5/students_to_h5.h5", "students_to_h5")

    # h5 file to students_from_h5 data frame
    students_from_h5 <- h5read("d:/h5/students_to_h5.h5", "students_to_h5")
    str(students_from_h5)

    endsubmit;
    import r=students_from_h5 data=workx.students_from_h5;
    run;

    /**************************************************************************************************************************/
    /* WORKX.STUDENTS_FROM_H5 total obs=7                                                                                     */
    /*                                                                                                                        */
    /* Obs     NAME      SEX    AGE    HEIGHT    WEIGHT    STRUCTURE                                                          */
    /*                                                                                                                        */
    /*  1     Alfred      M      14     69.0      112.5    data.frame':      7 obs. of  5 variables:                          */
    /*  2     Alice       F      13     56.5       84.0    $ NAME  : chr [1:7(1d)] "Alfred" "Alice" "Barbara" "Carol" ...     */
    /*  3     Barbara     F      13     65.3       98.0    $ SEX   : chr [1:7(1d)] "M" "F" "F" "F" ...                        */
    /*  4     Carol       F      14     62.8      102.5    $ AGE   : num [1:7(1d)] 14 13 13 14 15 11 15                       */
    /*  5     Ronald      M      15     67.0      133.0    $ HEIGHT: num [1:7(1d)] 69 56.5 65.3 62.8 67 57.5 66.5             */
    /*  6     Thomas      M      11     57.5       85.0    $ WEIGHT: num [1:7(1d)] 112 84 98 102 133 ...                      */
    /*  7     William     M      15     66.5      112.0                                                                       */
    /*                                                                                                                        */
    /*------------------------------------------------------------------------------------------------------------------------*/
    /*                                                                                                                        */
    /* ASCII Flatfile Ruler & Hex                                                                                             */
    /* utlrulr                                                                                                                */
    /* d:/h5/r_inp.h5                                                                                                         */
    /* d:\txt\delete.hex                                                                                                      */
    /*                                                                                                                        */
    /*  --- Record Number ---  1   ---  Record Length ---- 100                                                                */
    /*                                                                                                                        */
    /* .HDF..
