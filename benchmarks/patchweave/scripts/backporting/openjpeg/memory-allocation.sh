project_name=openjpeg
bug_id=memory-allocation
dir_name=$1/backport/$project_name/$bug_id

pa=openjpeg-2.2.0
pb=openjpeg-2.3.0
pc=openjpeg-2.1.1
pa_url=https://github.com/uclouvain/openjpeg.git


pa_commit=afb308b
pb_commit=baf0c1ad
pc_commit=version.2.1.1



mkdir -p $dir_name
cd $dir_name
git clone $pa_url $pa
cp -rf $pa $pb $pc

cd $pa
git checkout $pa_commit


cd ../$pb
git checkout $pb_commit
cd ..


cd $pc
git checkout $pc_commit


cd $dir_name/$pc;autoreconf -i;./configure
cd $dir_name/$pc; bear make
python /patchweave/script/python/format.py $dir_name/$pc

git add *.c
git commit -m "format style"
git reset --hard HEAD


