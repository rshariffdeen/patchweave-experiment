#!/usr/bin/env python
# Copyright (C) 2016 Fan Long, Martin Rianrd and MIT CSAIL
# Prophet
#
# This file is part of Prophet.
#
# Prophet is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Prophet is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Prophet.  If not, see <http://www.gnu.org/licenses/>.
from sys import argv
import getopt
from os import chdir, getcwd, system, path, environ
import subprocess

if __name__ == "__main__":
    opts, args = getopt.getopt(argv[1:], "p:");
    profile_dir = "";
    for o, a in opts:
        if o == "-p":
            profile_dir = a;

    src_dir = args[0];
    test_dir = args[1];
    work_dir = args[2];

    if (len(args) > 3):
        ids = args[3:];
        cur_dir = src_dir;
        if (profile_dir != ""):
            cur_dir = profile_dir

        if (not path.exists(cur_dir + "/my-test")):
            system("cp -rf " + test_dir + " " + cur_dir + "/my_test")
        ori_dir = getcwd()

        # chdir(cur_dir + "/my-test")
        my_env = environ;
        my_env["GENEXPOUT"] = "0"
        my_env["CMPEXPOUT"] = "1"

        # super hacky, because fbc itself calls *ld*, damn it fbc
        for i in ids:
            # ret = system(test_cmd)
            ret = subprocess.call(["timeout 12s " + cur_dir + "/bin/opj_dump -i " + test_dir + "/" + i + ".jp2  1>" + test_dir + "/" + i + ".out  2>" + test_dir + "/" + i + ".err"],
                                  shell=True)
            # print("timeout 12s /jasper/src/appl/imginfo -f /data/" + i + ".jp2 1>/dev/null 2>/dev/null")
            # print("timeout 12s /projects/jasper/src/appl/imginfo -f /workspace/jasper/poc/" + i + ".jp2 1>/dev/null 2>/dev/null")
            # print(i, ret)
            with open(test_dir + "/" + i + ".err", "r") as err_file:
                data = err_file.read().replace('\n', '')
                special_word = "runtime error: unsigned integer overflow: "
                # print(data)
                if special_word in data:
                    ret = 124
            if (ret == 0 or ret == 1):
                print i,

        chdir(ori_dir)