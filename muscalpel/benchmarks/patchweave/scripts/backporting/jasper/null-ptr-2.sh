bug_id=null-ptr-2
project_name=jasper
dir_name=$1/backport/$project_name/$bug_id


project_url=https://github.com/mdadams/jasper.git
pa=$project_name-2.0.12
pb=$project_name-2.0.13
pc=$project_name-1.900.2

pa_commit=7692d6d
pb_commit=e96fc4fd
pc_commit=version-1.900.2


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
rm aclocal.m4
git add aclocal.m4
git commit -m "removing aclocal"

cd $dir_name/$pc;autoreconf -i;./configure
cd $dir_name/$pc; bear make
python /patchweave/script/format.py $dir_name/$pc

git add *.c
git commit -m "format style"
git reset --hard HEAD

