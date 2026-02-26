%let pgm=utl-altair-slc-reading-and-writing-hdf5-files-with-open-source-matlab-python-and-r;

%stop_submission;

Altair slc reading and writing hdf5 files with open source matlab python and r

Too long to post on a list,see github
https://github.com/rogerjdeangelis/utl-altair-slc-reading-and-writing-hdf5-files-with-open-source-matlab-python-and-r

Problem read write h5(hdf5) files

   1 r write read h5
   2 python write read h5 (most flexible?)
   3 matlab write read h5

Note The .hdf5 extension is more explicit but fully interchangeable with h5.

I did not test if the matlab, r and python hdf5 files can be read by the other two languages.

How to install R rhdf5 package

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
/* .HDF...........................................................`...................................                   */
/* 1...5....10...15...20...25...30...35...40...45...50...55...60...65...70...75...80...85...90...95...1                   */
/* 84440010000000000010000000000000FFFFFFFFC0000000FFFFFFFF00000000600000000000000080000000A00000000000                   */
/* 9846DAAA000008804000000000000000FFFFFFFFAE000000FFFFFFFF00000000000000001000000080000000820000001010                   */
/*                                                                                                                        */
/*                                                                                                                        */
/*  --- Record Number ---  2   ---  Record Length ---- 100                                                                */
/*                                                                                                                        */
/* ....................................TREE............................................................                   */
/* 1...5....10...15...20...25...30...35...40...45...50...55...60...65...70...75...80...85...90...95...1                   */
/* 0000100000001010000080000000A000000055440000FFFFFFFFFFFFFFFF00000000D0000000000000000000000000000000                   */
/* 10008000000010000000800000008200000042550010FFFFFFFFFFFFFFFF0000000004000000800000000000000000000000                   */
/* ...                                                                                                                    */
/* ...                                                                                                                    */
/*  --- Record Number ---  7   ---  Record Length ---- 100                                                                */
/*                                                                                                                        */
/* ................................................................................HEAP....X...........                   */
/* 1...5....10...15...20...25...30...35...40...45...50...55...60...65...70...75...80...85...90...95...1                   */
/* 0000000000000000000000000000000000000000000000000000000000000000000000000000000044450000500000001000                   */
/* 0000000000000000000000000000000000000000000000000000000000000000000000000000000085100000800000008000                   */
/*                                                                                                                        */
/*                                                                                                                        */
/*  --- Record Number ---  8   ---  Record Length ---- 100                                                                */
/*                                                                                                                        */
/* ....................students_out............@.......................................................                   */
/* 1...5....10...15...20...25...30...35...40...45...50...55...60...65...70...75...80...85...90...95...1                   */
/* 0000C00000000000000077766677567700000000000040000000000000000000000000000000000000000000000000000000                   */
/* 0000820000000000000034545E43FF5400001000000000000000000000000000000000000000000000000000000000000000                   */
/*                                                                                                                        */
/*                                                                                                                        */
/*  --- Record Number ---  9   ---  Record Length ---- 100                                                                */
/*                                                                                                                        */
/* .................................................. ......... ...NAME................................                   */
/* 1...5....10...15...20...25...30...35...40...45...50...55...60...65...70...75...80...85...90...95...1                   */
/* 00000000A0000000001000000000000000000000000000000020000010002000444400000000000000000000000000000000                   */
/* 1050100001000000108000001110000070000000700000003001100065000000E1D500000000000000000000000000000000                   */
/*                                                                                                                        */
/*                                                                                                                        */
/*  --- Record Number ---  10   ---  Record Length ---- 100                                                               */
/*                                                                                                                        */
/* ............SEX.............................................AGE.....................................                   */
/* 1...5....10...15...20...25...30...35...40...45...50...55...60...65...70...75...80...85...90...95...1                   */
/* 0000100000005450000000000000000000000000000000000000100000004440000000000000000000000000000000000000                   */
/* 0000310070003580000070000000000000000000000000000000310010001750000080000000000000000000000000000000                   */
/**************************************************************************************************************************/

/*
| | ___   __ _
| |/ _ \ / _` |
| | (_) | (_| |
|_|\___/ \__, |
         |___/
*/

NOTE: AUTOEXEC processing completed

1         %utlfkil(d:/h5/students_to_h5.h5);
2
3         options set=RHOME "C:\Progra~1\R\R-4.5.2\bin\r";
4         proc r;
NOTE: Using R version 4.5.2 (2025-10-31 ucrt) from C:\Program Files\R\R-4.5.2
5         export data=workx.class r=students;
NOTE: Creating R data frame 'students' from data set 'WORKX.class'

6         submit;
7         library(rhdf5)
8
9         # student dataframe to h5 file
10        h5write(students, "d:/h5/students_to_h5.h5", "students_to_h5")
11
12        # h5 file to students_from_h5 data frame
13        students_from_h5 <- h5read("d:/h5/students_to_h5.h5", "students_to_h5")
14        str(students_from_h5)
15
16        endsubmit;

NOTE: Submitting statements to R:

> library(rhdf5)
>
> # student dataframe to h5 file
> h5write(students, "d:/h5/students_to_h5.h5", "students_to_h5")
>
> # h5 file to students_from_h5 data frame
> students_from_h5 <- h5read("d:/h5/students_to_h5.h5", "students_to_h5")
> str(students_from_h5)
>

NOTE: Processing of R statements complete

17        import r=students_from_h5 data=workx.students_from_h5;
NOTE: Creating data set 'WORKX.students_from_h5' from R data frame 'students_from_h5'
NOTE: Data set "WORKX.students_from_h5" has 7 observation(s) and 5 variable(s)

18        run;
NOTE: Procedure r step took :
      real time : 0.477
      cpu time  : 0.031


19
ERROR: Error printed on page 1

NOTE: Submitted statements took :
      real time : 0.595
      cpu time  : 0.109

/*___                _   _                                 _ _                           _   _     ____
|___ \   _ __  _   _| |_| |__   ___  _ __  __      ___ __(_) |_ ___  _ __ ___  __ _  __| | | |__ | ___|
  __) | | `_ \| | | | __| `_ \ / _ \| `_ \ \ \ /\ / / `__| | __/ _ \| `__/ _ \/ _` |/ _` | | `_ \|___ \
 / __/  | |_) | |_| | |_| | | | (_) | | | | \ V  V /| |  | | ||  __/| | |  __/ (_| | (_| | | | | |___) |
|_____| | .__/ \__, |\__|_| |_|\___/|_| |_|  \_/\_/ |_|  |_|\__\___||_|  \___|\__,_|\__,_| |_| |_|____/
        |_|    |___/
*/

%utlfkil(d:/h5/students_to_h5.h5);

options set=PYTHONHOME "D:\py314";
proc python;
submit;
import tables
import pandas as pd
import pyreadstat as ps
students,neta=ps.read_sas7bdat('d:/wpswrkx/class.sas7bdat')
print(students)
students.to_hdf('d:/h5/students_to_h5.h5', key='students', mode='w', format='table')
students_from_h5 = pd.read_hdf('d:/h5/students_to_h5.h5', key='students')
endsubmit;
import python=students_from_h5 data=workx.students_from_h5;
run;

/**************************************************************************************************************************/
/*   WORKX.STUDENTS_FROM_H5 total obs=7                                                                                   */
/*                                                                                                                        */
/*  Obs     NAME      SEX    AGE    HEIGHT    WEIGHT                                                                      */
/*                                                                                                                        */
/*   1     Alfred      M      14     69.0      112.5                                                                      */
/*   2     Alice       F      13     56.5       84.0                                                                      */
/*   3     Barbara     F      13     65.3       98.0                                                                      */
/*   4     Carol       F      14     62.8      102.5                                                                      */
/*   5     Ronald      M      15     67.0      133.0                                                                      */
/*   6     Thomas      M      11     57.5       85.0                                                                      */
/*   7     William     M      15     66.5      112.0                                                                      */
/*                                                                                                                        */
/*------------------------------------------------------------------------------------------------------------------------*/
/*                                                                                                                        */
/* ASCII Flatfile Ruler & Hex                                                                                             */
/* utlrulr                                                                                                                */
/* d:/h5/students_to_h5.h5                                                                                                */
/* d:\txt\delete.hex                                                                                                      */
/*                                                                                                                        */
/* VERY SLIGHT DIFFERENCES FROM R                                                                                         */
/*                                                                                                                        */
/*  --- Record Number ---  1   ---  Record Length ---- 100                                                                */
/*                                                                                                                        */
/* .HDF...................................+J......................`...................................                   */
/* 1...5....10...15...20...25...30...35...40...45...50...55...60...65...70...75...80...85...90...95...1                   */
/* 84440010000000000010000000000000FFFFFFFF24000000FFFFFFFF00000000600000000000000080000000A00000000000                   */
/* 9846DAAA000008804000000000000000FFFFFFFFBA100000FFFFFFFF00000000000000001000000080000000820000001060                   */
/*                                                                                                                        */
/*                                                                                                                        */
/*  --- Record Number ---  2   ---  Record Length ---- 100                                                                */
/*                                                                                                                        */
/* .................... ...............TREE............................................................                   */
/* 1...5....10...15...20...25...30...35...40...45...50...55...60...65...70...75...80...85...90...95...1                   */
/* 0000100000001010000020000000E000000055440000FFFFFFFFFFFFFFFF00000000C0000000000000000000000000000000                   */
/* 10008000000000000000030000000000000042550010FFFFFFFFFFFFFFFF0000000006000000800000000000000000000000                   */
/* ....                                                                                                                   */
/* ....                                                                                                                   */
/*                                                                                                                        */
/*  --- Record Number ---  7   ---  Record Length ---- 100                                                                */
/*                                                                                                                        */
/* ................................................................................HEAP....X...........                   */
/* 1...5....10...15...20...25...30...35...40...45...50...55...60...65...70...75...80...85...90...95...1                   */
/* 0000000000000000000000000000000000000000000000000000000000000000000000000000000044450000500000001000                   */
/* 0000000000000000000000000000000000000000000000000000000000000000000000000000000085100000800000008000                   */
/*                                                                                                                        */
/*                                                                                                                        */
/*  --- Record Number ---  8   ---  Record Length ---- 100                                                                */
/*                                                                                                                        */
/* ....................students................@.......................................................                   */
/* 1...5....10...15...20...25...30...35...40...45...50...55...60...65...70...75...80...85...90...95...1                   */
/* 0000C00000000000000077766677000000000000000040000000000000000000000000000000000000000000000000000000                   */
/* 0000820000000000000034545E43000000001000000000000000000000000000000000000000000000000000000000000000                   */
/*                                                                                                                        */
/*                                                                                                                        */
/*  --- Record Number ---  9   ---  Record Length ---- 100                                                                */
/*                                                                                                                        */
/* .......................... .............TITLE.....................(.............CLASS...............                   */
/* 1...5....10...15...20...25...30...35...40...45...50...55...60...65...70...75...80...85...90...95...1                   */
/* 1010000080000000A00000000020000000000000545440001100000000000000002000000000000044455000110000000000                   */
/* 100000008000000082000000C000000010608040494C50003000100020020000C0800000106080803C133000300050001000                   */
/*                                                                                                                        */
/*                                                                                                                        */
/*  --- Record Number ---  10   ---  Record Length ---- 100                                                               */
/*                                                                                                                        */
/* ....GROUP.....(.............VERSION.................1.0.......8.............PYTABLES_FORMAT_VERSION.                   */
/* 1...5....10...15...20...25...30...35...40...45...50...55...60...65...70...75...80...85...90...95...1                   */
/* 0000454550000020000000000000545544401100000000000000323000000030000000100000555444455445445554554440                   */
/* 000072F50000C08000001080808065239FE030003000100000001E000000C08000001080808009412C53F6F2D14F65239FE0                   */
/**************************************************************************************************************************/

/*
| | ___   __ _
| |/ _ \ / _` |
| | (_) | (_| |
|_|\___/ \__, |
         |___/
*/

NOTE: AUTOEXEC processing completed

1         %utlfkil(d:/h5/students_to_h5.h5);
2
3         options set=PYTHONHOME "D:\py314";
4         proc python;
5         submit;
6         import tables
7         import pandas as pd
8         import pyreadstat as ps
9         students,neta=ps.read_sas7bdat('d:/wpswrkx/class.sas7bdat')
10        print(students)
11        students.to_hdf('d:/h5/students_to_h5.h5', key='students', mode='w', format='table')
12        students_from_h5 = pd.read_hdf('d:/h5/students_to_h5.h5', key='students')
13        endsubmit;

NOTE: Submitting statements to Python:


14        import python=students_from_h5 data=workx.students_from_h5;
NOTE: Creating data set 'WORKX.students_from_h5' from Python data frame 'students_from_h5'
NOTE: Data set "WORKX.students_from_h5" has 7 observation(s) and 5 variable(s)

15        run;
NOTE: Procedure python step took :
      real time : 1.183
      cpu time  : 0.031


ERROR: Error printed on page 1

NOTE: Submitted statements took :
      real time : 1.283
      cpu time  : 0.093

/*____               _   _       _                     _                          _   _     ____
|___ /   _ __   __ _| |_| | __ _| |__   __      ___ __(_) ___  _ __ ___  __ _  __| | | |__ | ___|
  |_ \  | `_ \ / _` | __| |/ _` | `_ \  \ \ /\ / / `__| |/ _ \| `__/ _ \/ _` |/ _` | | `_ \|___ \
 ___) | | | | | (_| | |_| | (_| | |_) |  \ V  V /| |  | |  __/| | |  __/ (_| | (_| | | | | |___) |
|____/  |_| |_|\__,_|\__|_|\__,_|_.__/    \_/\_/ |_|  |_|\___||_|  \___|\__,_|\__,_| |_| |_|____/
*/

%utlfkil(d:/h5/students_to_h5.h5);

%slc_mbegin;
cards4;
% Create sample data mimicking a pandas DataFrame (3x3 matrix)
data = [1, 2, 3; 4, 5, 6; 7, 8, 9];

row_names = {"row1"; "row2"; "row3"};   % Optional row labels
col_names = {"col1", "col2", "col_hdr"}; % Optional column labels (note: no comma on last)

% Save to HDF5 file using Octave's HDF5 format
save -hdf5 "d:/h5/students_to_h5.h5" data row_names col_names;
printf("HDF5 file 'd:/h5/students_to_h5.h5' created successfully.\n");
% Read back from HDF5
load("d:/h5/students_to_h5.h5", "data");  % Loads into variable 'data'
printf("Read matrix:\n");
disp(data);  % Displays as "output DataFrame"

% Optional: Display labels
if exist("row_names", "var")
  disp("Row names:"); disp(row_names);
endif
if exist("col_names", "var")
  disp("Column names:"); disp(col_names);
endif
;;;;
%slc_mend;

/**************************************************************************************************************************/
/*  Altair SLC                                                                                                            */
/*                                                                                                                        */
/* HDF5 file 'd:/h5/students_to_h5.h5' created successfully.                                                              */
/*                                                                                                                        */
/* Read matrix:                                                                                                           */
/*    1   2   3                                                                                                           */
/*    4   5   6                                                                                                           */
/*    7   8   9                                                                                                           */
/* Row names:                                                                                                             */
/* {                                                                                                                      */
/*   [1,1] = row1                                                                                                         */
/*   [2,1] = row2                                                                                                         */
/*   [3,1] = row3                                                                                                         */
/* }                                                                                                                      */
/* Column names:                                                                                                          */
/* {                                                                                                                      */
/*   [1,1] = col1                                                                                                         */
/*   [1,2] = col2                                                                                                         */
/*   [1,3] = col_hdr                                                                                                      */
/*                                                                                                                        */
/*------------------------------------------------------------------------------------------------------------------------*/
/*                                                                                                                        */
/* VERY SLIGHT DIFFERENCE                                                                                                 */
/*                                                                                                                        */
/* ASCII Flatfile Ruler & Hex                                                                                             */
/* utlrulr                                                                                                                */
/* d:/h5/students_to_h5.h5                                                                                                */
/* d:\txt\delete.hex                                                                                                      */
/*                                                                                                                        */
/*  --- Record Number ---  1   ---  Record Length ---- 100                                                                */
/*                                                                                                                        */
/* .HDF....................................O......................`...................................                   */
/* 1...5....10...15...20...25...30...35...40...45...50...55...60...65...70...75...80...85...90...95...1                   */
/* 84440010000000000010000000000000FFFFFFFFA4000000FFFFFFFF00000000600000000000000080000000A00000000000                   */
/* 9846DAAA000008804000000000000000FFFFFFFF8F000000FFFFFFFF00000000000000001000000080000000820000001030                   */
/*                                                                                                                        */
/*                                                                                                                        */
/*  --- Record Number ---  2   ---  Record Length ---- 100                                                                */
/*                                                                                                                        */
/* .................... .......h.......TREE............................H...............................                   */
/* 1...5....10...15...20...25...30...35...40...45...50...55...60...65...70...75...80...85...90...95...1                   */
/* 00001000000010100000200000006000000055440000FFFFFFFFFFFFFFFF0000000040000000100000000000000000000000                   */
/* 10008000000000000000030000008000000042550010FFFFFFFFFFFFFFFF0000000086000000000000000000000000000000                   */
/*                                                                                                                        */
/*                                                                                                                        */
/*  --- Record Number ---  3   ---  Record Length ---- 100                                                                */
/*                                                                                                                        */
/* ....................................................................................................                   */
/* 1...5....10...15...20...25...30...35...40...45...50...55...60...65...70...75...80...85...90...95...1                   */
/* 0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000                   */
/* 0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000                   */
/* ...                                                                                                                    */
/* ...                                                                                                                    */
/*                                                                                                                        */
/* --- Record Number ---  7   ---  Record Length ---- 100                                                                 */
/*                                                                                                                        */
/* ................................................................................HEAP....X.......0...                   */
/* 1...5....10...15...20...25...30...35...40...45...50...55...60...65...70...75...80...85...90...95...1                   */
/* 0000000000000000000000000000000000000000000000000000000000000000000000000000000044450000500000003000                   */
/* 0000000000000000000000000000000000000000000000000000000000000000000000000000000085100000800000000000                   */
/*                                                                                                                        */
/*                                                                                                                        */
/*  --- Record Number ---  8   ---  Record Length ---- 100                                                                */
/*                                                                                                                        */
/* ....................data....row_names.......col_names...............(...............................                   */
/* 1...5....10...15...20...25...30...35...40...45...50...55...60...65...70...75...80...85...90...95...1                   */
/* 0000C00000000000000066760000767566667000000066656666700000000000000020000000000000000000000000000000                   */
/* 00008200000000000000414100002F7FE1D5300000003FCFE1D5300000001000000080000000000000000000000000000000                   */
/*                                                                                                                        */
/*                                                                                                                        */
/*  --- Record Number ---  9   ---  Record Length ---- 100                                                                */
/*                                                                                                                        */
/* ..........................H.....# Created by Octave 10.3.0, Thu Feb 26 14:00:50 2026 UTC <unknown@SL                   */
/* 1...5....10...15...20...25...30...35...40...45...50...55...60...65...70...75...80...85...90...95...1                   */
/* 1010000080000000A00000000040000022476676626724676762332323225672466233233333333233332554237666676454                   */
/* 100000008000000082000000D08000003032514540290F34165010E3E0C04850652026014A00A500202605430C5EBEF7E03C                   */
/*                                                                                                                        */
/*                                                                                                                        */
/*  --- Record Number ---  10   ---  Record Length ---- 100                                                               */
/*                                                                                                                        */
/* C>..................................`.......TREE....................................................                   */
/* 1...5....10...15...20...25...30...35...40...45...50...55...60...65...70...75...80...85...90...95...1                   */
/* 4300000000001000000010100000F10000006000000055440000FFFFFFFFFFFFFFFF00000000A00000001000000000000000                   */
/* 3E00103010008000000000000000820000000000000042550010FFFFFFFFFFFFFFFF00000000080000000000000000000000                   */
/**************************************************************************************************************************/

/*
| | ___   __ _
| |/ _ \ / _` |
| | (_) | (_| |
|_|\___/ \__, |
         |___/
*/
5         % Create sample data mimicking a pandas DataFrame (3x3 matrix)
6         data = [1, 2, 3; 4, 5, 6; 7, 8, 9];
7
8         row_names = {"row1"; "row2"; "row3"};   % Optional row labels
9         col_names = {"col1", "col2", "col_hdr"}; % Optional column labels (note: no comma on last)
10
11        % Save to HDF5 file using Octave's HDF5 format
12        save -hdf5 "d:/h5/students_to_h5.h5" data row_names col_names;
13        printf("HDF5 file 'd:/h5/students_to_h5.h5' created successfully.\n");
14        % Read back from HDF5
15        load("d:/h5/students_to_h5.h5", "data");  % Loads into variable 'data'
16        printf("Read matrix:\n");
17        disp(data);  % Displays as "output DataFrame"
18
19        % Optional: Display labels
20        if exist("row_names", "var")
21          disp("Row names:"); disp(row_names);
22        endif
23        if exist("col_names", "var")
24          disp("Column names:"); disp(col_names);
25        endif
26        ;;;;
27        %slc_mend;

NOTE: The infile rut is:
      Unnamed Pipe Access Device,
      Process=C:\Progra~1\GNUOCT~1\Octave-10.3.0\mingw64\bin\octave-cli c:/temp/m_pgm.m > c:/temp/m_pgm.log,
      Lrecl=32756, Recfm=V

NOTE: No records were written to file PRINT

NOTE: No records were read from file rut
NOTE: The data step took :
      real time : 0.999
      cpu time  : 0.000


WARNING: The filename "ft15f001" has not been assigned

NOTE: The infile 'c:\temp\m_pgm.log' is:
      Filename='c:\temp\m_pgm.log',
      Owner Name=SLC\suzie,
      File size (bytes)=236,
      Create Time=13:50:46 Feb 26 2026,
      Last Accessed=14:40:04 Feb 26 2026,
      Last Modified=14:40:04 Feb 26 2026,
      Lrecl=32767, Recfm=V

HDF5 file 'd:/h5/students_to_h5.h5' created successfully.
Read matrix:
   1   2   3
   4   5   6
   7   8   9
Row names:
{
  [1,1] = row1
  [2,1] = row2
  [3,1] = row3
}
Column names:
{
  [1,1] = col1
  [1,2] = col2
  [1,3] = col_hdr
}
NOTE: 17 records were written to file PRINT

NOTE: 17 records were read from file 'c:\temp\m_pgm.log'
      The minimum record length was 1
      The maximum record length was 57
NOTE: The data step took :
      real time : 0.033
      cpu time  : 0.000

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
