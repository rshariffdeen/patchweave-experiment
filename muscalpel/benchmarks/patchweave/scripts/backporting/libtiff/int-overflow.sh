project_name=libtiff
bug_id=int-overflow
dir_name=$1/backport/$project_name/$bug_id

project_url=https://github.com/vadz/libtiff.git
pa=$project_name-4.0.7
pb=$project_name-4.0.8
pc=$project_name-4.0.1

pa_commit=0a76a8c
pb_commit=66e7bd59
pc_commit=Release-v4-0-1


mkdir -p $dir_name
cd $dir_name
git clone $project_url $pa
cp -rf $pa $pb
cp -rf $pa $pc
cd $pa
git checkout $pa_commit

cd ../$pb
git checkout $pb_commit

cd ../$pc
git checkout $pc_commit

cd $dir_name/$pc;autoreconf -i;./configure
cd $dir_name/$pc; bear make
python /patchweave/script/python/format.py $dir_name/$pc

git add *.c
git commit -m "format style"
git reset --hard HEAD

