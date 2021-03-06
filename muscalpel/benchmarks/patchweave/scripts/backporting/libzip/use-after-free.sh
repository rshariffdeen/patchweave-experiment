bug_id=use-after-free
project_name=libzip
dir_name=$1/backport/$project_name/$bug_id

project_url=https://github.com/nih-at/libzip.git
pa=$project_name-1.3.0
pb=$project_name-1.2.1
pc=$project_name-1.2.0

pa_commit=f0b8dda
pb_commit=2217022b7d
pc_commit=rel-1-2


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


cd $dir_name/$pc;cmake .
cd $dir_name/$pc; bear make
rm -rf $dir_name/$pc/CMakeFiles

python /patchweave/script/format.py $dir_name/$pc

git add *.c
git commit -m "format style"
git reset --hard HEAD

