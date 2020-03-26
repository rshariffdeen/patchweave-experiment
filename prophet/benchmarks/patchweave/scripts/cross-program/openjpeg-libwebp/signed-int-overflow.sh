project_name=openjpeg-libwebp
bug_id=signed-int-overflow
dir_name=$1/$project_name/$bug_id


pc=libwebp-0.3.0
pc_url=https://chromium.googlesource.com/webm/libwebp
pc_commit=v0.3.0

mkdir -p $dir_name
cd $dir_name

git clone $pc_url $pc
cd $pc
git checkout $pc_commit

#sed -i -e '206d' examples/jpegdec.c
#git add examples/jpegdec.c
#git commit -m "remove longjmp"
#
#sed -i -e '28,30d' src/dsp/dsp.h
#git add src/dsp/dsp.h
#git commit -m "remove sse2"
#
#cd $dir_name/$pc;autoreconf -i;./configure
#cd $dir_name/$pc; bear make
#python /patchweave/script/python/format.py $dir_name/$pc


