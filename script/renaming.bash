#!/bin/bash
# Задача этого скрипта - переименовать файлы в *.avi, все файлы остаются в своих папках.
# Скрипт использовался для переименования файлов *.MOD при демонстрации htcondor для группы Байкал.

# Так сработал для вложенной директории, а для корневой еще не готово.  

# https://unix.stackexchange.com/questions/189745/rename-files-depending-on-their-parent-directory 
# http://tldp.org/LDP/abs/html/string-manipulation.html

EK_ROOT=/home/evkuz/MAX2UFM_02
EK_TRY=$EK_ROOT/restore
DEST_DIR=$EK_ROOT/try
OLD_PROJECT="USBRefDesign"
NEW_PROJECT="max2ufm"

cd $EK_ROOT


#                         NOT maxdepth, so there is now try/ itself
for f in $( find $EK_ROOT -maxdepth 1 -type d ); do
   bb=$(basename "$f")
   dd=$(dirname "$f")
#   mv "$f" "$(dirname "$f")_$(basename $f)"
#   printf "$bb\n" # | grep -v try
#    printf "$dd\n"

echo "$dd"
   for ff in $(find $dd/$bb -type f -name 'USBRefDesign*'); do

# $ff_base = only file name
    ff_base=$(basename "$ff")
#    ff_base=${ff_base%"MOD"}"avi"
# $dd/$bb =  full directory name
# $ff = full pathname for file
#   printf "$ff\n"

#echo "$ff"
#echo "$ff" | sed -e 's/USBRefDesign/max2ufm/' 

mv "$ff" "$(echo $ff | sed -e 's/USBRefDesign/max2ufm/')"
#echo "$(basename $ff)"
#   ff_base=$bb"_"$ff_base


# month_year_file 
#   printf "$ff_base\n"

# Key String but no folder name

#   mv $ff $dd/$bb/$ff_base

    done

   done


