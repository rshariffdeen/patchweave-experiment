bug_id=div-zero
project_name=libming
dir_name=$1/backport/$project_name/$bug_id


project_url=https://github.com/libming/libming.git
pa=$project_name-0.4.7
pb=$project_name-0.4.8
pc=$project_name-0.4.6

pa_commit=80ebea9
pb_commit=b0704f80
pc_commit=ming-0_4_6


mkdir -p $dir_name
cd $dir_name
git clone $project_url $pa
cp -rf $pa $pb
cp -rf $pa $pc
cd $pa
git checkout $pa_commit
python /patchweave/script/format.py $dir_name/$pa

git add *.c
git commit -m "format style"
git reset --hard HEAD

cd ../$pb
git checkout $pb_commit
python /patchweave/script/format.py $dir_name/$pb

git add *.c
git commit -m "format style"
git reset --hard HEAD


cd ../$pc
git checkout $pc_commit

