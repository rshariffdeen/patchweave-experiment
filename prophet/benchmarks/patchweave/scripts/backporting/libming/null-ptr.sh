bug_id=null-ptr
project_name=libming
dir_name=$1/backport/$project_name/$bug_id


project_url=https://github.com/libming/libming.git
pa=$project_name-0.4.7
pb=$project_name-0.4.8
pc=$project_name-0.4.6

pa_commit=459fa79
pb_commit=80ebea95
pc_commit=ming-0_4_6


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

