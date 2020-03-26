project_name=libsndfile-wavpack
bug_id=shift-overflow
dir_name=$1/$project_name/$bug_id

pc=wavpack-5.1.0
pc_url=https://github.com/dbry/WavPack.git
pc_commit=5.1.0


mkdir -p $dir_name
cd $dir_name


git clone $pc_url $pc
cd $pc
git checkout $pc_commit

#
#cd $dir_name/$pc;autoreconf -i;./configure
#cd $dir_name/$pc; bear make
#python /patchweave/script/python/format.py $dir_name/$pc
#
#git add *.c
#git commit -m "format style"
#git reset --hard HEAD
#
#
