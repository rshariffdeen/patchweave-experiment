project_name=jasper-openjpeg
bug_id=heap-overflow
dir_name=$1/$project_name/$bug_id

pc=openjpeg-2.1.0
pc_url=https://github.com/uclouvain/openjpeg.git
pc_commit=version.2.1
opj_file=src/bin/jp2/opj_dump.c
opj_input=JP2_CFMT



mkdir -p $dir_name
cd $dir_name

git clone $pc_url $pc
cd $pc
git checkout $pc_commit
sed -i "s/get_file_format(infile)/$opj_input/g" $opj_file
git add $opj_file
git commit -m "fix input format"

#
#cd $dir_name/$pc;cmake .
#cd $dir_name/$pc; bear make
#rm -rf $dir_name/$pc/CMakeFiles
#python /patchweave/script/python/format.py $dir_name/$pc
#
#git add *.c
#git commit -m "format style"
#git reset --hard HEAD