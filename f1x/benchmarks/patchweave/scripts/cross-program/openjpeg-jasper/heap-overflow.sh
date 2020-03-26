project_name=openjpeg-jasper
bug_id=heap-overflow
dir_name=$1/$project_name/$bug_id

pc=jasper-1.900.13
pc_url=https://github.com/mdadams/jasper.git
pc_commit=version-1.900.13
opj_file=applications/codec/j2k_to_image.c
opj_input=J2K_CFMT

mkdir -p $dir_name
cd $dir_name

git clone $pc_url $pc
cd $pc
git checkout $pc_commit
rm aclocal.m4
git add aclocal.m4
git commit -m "removing aclocal"

#cd $dir_name/$pc;autoreconf -i;./configure
#cd $dir_name/$pc; bear make
#python /patchweave/script/python/format.py $dir_name/$pc
#
#git add *.c
#git commit -m "format style"
#git reset --hard HEAD


