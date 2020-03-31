#!/usr/bin/env python
from sys import argv
from os import system, path, chdir, getcwd, environ
from tester_common import extract_arguments
import subprocess
import getopt


def compileit(out_dir, compile_only=False, config_only=False, paraj=0):
    ori_dir = getcwd();
    chdir(out_dir);

    my_env = environ;
    # my_env["PATH"] = deps_dir + "/apr-1.5.1-build/bin:" + my_env["PATH"];
    # my_env["PATH"] = deps_dir + "/apr-util-1.5.3-build/bin:" + my_env["PATH"];
    print(compile_only, config_only)
    if not compile_only:
        system("git clean -f -d");
        ret = system("autoreconf -i");
        if (ret != 0):
            print "Autoreconf failed!";
            chdir(ori_dir);
            exit(1);
        # ret = subprocess.call(["./configure"]);
        print("CONFIGURING>>>>>>>>>>>>>>>")
        ret = system("./configure");
        if ret != 0:
            print "Configure Error!";
            chdir(ori_dir);
            exit(1);
        # system("make clean");
    # exit()
    if not config_only:
        if (paraj == 0):
            ret = system("make > /MAKELOG");
            print("MAKE")

        else:
            ret = system("make -j" + str(paraj));
        print(ret)
        if ret != 0:
            print "Failed to make!";
            exit(1);

    # ret = subprocess.call(["make", "install"], env = my_env);
    # if ret != 0:
    #   print "Failed to make install!";
    #   exit(1);

    chdir(ori_dir);


if __name__ == "__main__":
    system("touch /RUNING_BUILD_LIBTIFF")
    arguments = ""
    for arg in argv:
        arguments += arg + " "
    system("echo \"" + arguments + "\" >> /RUNING_BUILD_LIBTIFF")
    deps_dir = getcwd() + "/libtiff-deps"

    compile_only = False;

    opts, args = getopt.getopt(argv[1:], 'cd:hlj:p:r:x');
    dryrun_src = "";

    paraj = 0;

    print_fix_log = False;
    print_usage = False;
    config_only = False;
    for o, a in opts:
        if o == "-d":
            dryrun_src = a;
        elif o == "-p":
            if a[0] == "/":
                deps_dir = a;
            else:
                deps_dir = getcwd() + "/" + a;
        elif o == "-x":
            config_only = True;
        elif o == "-c":
            compile_only = True;
        elif o == "-l":
            print_fix_log = True;
        elif o == "-h":
            print_usage = True;
        elif o == "-j":
            paraj = int(a);

    if (len(args) < 1) or (print_usage):
        print "Usage: libtiff-build.py <directory> [-d src_file | -l] [-h]";
        exit(0);

    out_dir = args[0];
    # fetch from github if the directory does not exist
    if path.exists(out_dir):
        print "Working with existing directory: " + out_dir;
    else:
        print "Non-exists directory";
        exit(1);

    compileit(out_dir, compile_only, config_only, paraj);
    if dryrun_src != "":
        (builddir, buildargs) = extract_arguments(out_dir, dryrun_src);
        if len(args) > 1:
            out_file = open(args[1], "w");
            print >> out_file, builddir;
            print >> out_file, buildargs;
            out_file.close();
        else:
            print builddir;
            print buildargs;

