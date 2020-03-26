project_name=libsndfile-wavpack
bug_id=shift-overflow
dir_name=$1/$project_name/$bug_id
pa=libsndfile-1.0.25
pb=libsndfile-1.0.26
pc=wavpack-5.1.0
pa_url=https://github.com/erikd/libsndfile.git
pc_url=https://github.com/dbry/WavPack.git
pa_commit=6b46656
pb_commit=3e91aaf7
pc_commit=5.1.0


mkdir -p $dir_name
cd $dir_name
git clone $pa_url $pa
cp -rf $pa $pb
cd $pa
git checkout $pa_commit


cd ../$pb
git checkout $pb_commit
cd ..

git clone $pc_url $pc
cd $pc
git checkout $pc_commit


cd $dir_name/$pc;autoreconf -i;./configure
cd $dir_name/$pc; bear make
python /patchweave/script/python/format.py $dir_name/$pc

git add *.c
git commit -m "format style"
git reset --hard HEAD


