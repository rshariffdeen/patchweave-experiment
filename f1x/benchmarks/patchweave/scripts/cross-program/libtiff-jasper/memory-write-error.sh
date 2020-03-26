project_name=libtiff-jasper
bug_id=memory-write-error
dir_name=$1/$project_name/$bug_id
dir_name_docker=/data/$bug_id

pc=jasper-1.900.8
pc_url=https://github.com/mdadams/jasper.git
pc_commit=version-1.900.8


mkdir -p $dir_name
cd $dir_name

git clone $pc_url $pc
cd $pc
git checkout $pc_commit


#cd $dir_name/$pc;autoreconf -i;./configure
#cd $dir_name/$pc; bear make
#python /patchweave/script/python/format.py $dir_name/$pc
#
#git add *.c
#git commit -m "format style"
#git reset --hard HEAD
#

