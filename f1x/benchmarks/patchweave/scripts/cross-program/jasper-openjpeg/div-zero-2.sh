project_name=jasper-openjpeg
bug_id=div-zero-2
dir_name=$1/$project_name/$bug_id

pc=openjpeg-1.3
pc_url=https://github.com/uclouvain/openjpeg.git
pc_commit=version.1.3
opj_file=codec/j2k_to_image.c
opj_input=J2K_CFMT


mkdir -p $dir_name
cd $dir_name

git clone $pc_url $pc
cd $pc
git checkout $pc_commit
sed -i "s/get_file_format(infile)/$opj_input/g" $opj_file
git add $opj_file
git commit -m "fix input format"
sed -i "s/CFLAGS = -O3 -lstdc++ # -g -p -pg/CFLAGS = -O3 -lstdc++ # -g -p -pg\nCC = clang/g" codec/Makefile
sed -i "s/gcc/\$(CC)/g" codec/Makefile
git add codec/Makefile
git commit -m "fix make error"

#
#
#cd $dir_name/$pc; bear make
#python /patchweave/script/python/format.py $dir_name/$pc
#
#git add *.c
#git commit -m "format style"
#git reset --hard HEAD
#
#
