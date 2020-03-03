import sys
import json
import subprocess
import os


KEY_CATEGORY = "category"
KEY_DONOR = "donor"
KEY_TARGET = "target"
KEY_BUG_NAME = "bug_name"
KEY_POC_PATH = "poc"
KEY_CVE_ID = "cve"

ARG_DATA_PATH = "--data-dir="
ARG_TOOL_PATH = "--tool-path="
ARG_TOOL_NAME = "--tool-name="
ARG_TOOL_PARAMS = "--tool-param="
ARG_DEBUG_MODE = "--debug"

CONF_DATA_PATH = "/data"
CONF_TOOL_PATH = "/patchweave"
CONF_TOOL_PARAMS = ""
CONF_TOOL_NAME = "python3 PatchWeave.py"
CONF_DEBUG = False

FILE_META_DATA = "meta-data"
FILE_ERROR_LOG = "error-log"


DIR_MAIN = os.getcwd()
DIR_LOGS = DIR_MAIN + "/logs"
DIR_SCRIPT = DIR_MAIN + "/scripts"
DIR_CONF = DIR_MAIN + "/configuration"
DIR_POC = DIR_MAIN + "/exploits"


EXPERIMENT_ITEMS = list()


def create_directories():
    if not os.path.isdir(DIR_LOGS):
        create_command = "mkdir " + DIR_LOGS
        execute_command(create_command)
    if not os.path.isdir(CONF_DATA_PATH + "/" + "exploits"):
        copy_command = "cp -rf " + DIR_POC + " " + CONF_DATA_PATH
        execute_command(copy_command)


def execute_command(command):
    if CONF_DEBUG:
        print("\t[COMMAND]" + command)
    process = subprocess.Popen([command], stdout=subprocess.PIPE, shell=True)
    (output, error) = process.communicate()


def setup(script_path, script_name, conf_path, deploy_conf_path):
    global FILE_ERROR_LOG, CONF_DATA_PATH
    print("\t[INFO] running script for setup")
    script_command = "{ cd " + script_path + "; bash " + script_name + " " + CONF_DATA_PATH + ";} 2> " + FILE_ERROR_LOG
    execute_command(script_command)
    print("\t[INFO] copying configuration")
    copy_command = "{ cp " + conf_path + " " + deploy_conf_path + ";} 2> " + FILE_ERROR_LOG
    execute_command(copy_command)


def evaluate(conf_path, bug_name):
    global CONF_TOOL_PARAMS, CONF_TOOL_PATH, CONF_TOOL_NAME, DIR_LOGS
    print("\t[INFO]running evaluation")
    log_path = str(conf_path).replace(".conf", ".log")
    tool_command = "{ cd " + CONF_TOOL_PATH + ";" + CONF_TOOL_NAME + " --conf=" + conf_path + " "+ CONF_TOOL_PARAMS + ";} 2> " + FILE_ERROR_LOG
    execute_command(tool_command)
    copy_log = "{ cp " + CONF_TOOL_PATH + "/logs/log-latest " + log_path + ";} 2> " + FILE_ERROR_LOG
    execute_command(copy_log)


def load_experiment():
    global EXPERIMENT_ITEMS
    print("[DRIVER] Loading experiment data\n")
    with open(FILE_META_DATA, 'r') as in_file:
        json_data = json.load(in_file)
        EXPERIMENT_ITEMS = json_data


def read_arg():
    global CONF_DATA_PATH, CONF_TOOL_NAME, CONF_TOOL_PARAMS, CONF_TOOL_PATH, CONF_DEBUG
    print("[DRIVER] Reading configuration values")
    if len(sys.argv) > 1:
        for arg in sys.argv:
            if ARG_DATA_PATH in arg:
                CONF_DATA_PATH = str(arg).replace(ARG_DATA_PATH, "")
            elif ARG_TOOL_NAME in arg:
                CONF_TOOL_NAME = str(arg).replace(ARG_TOOL_NAME, "")
            elif ARG_TOOL_PATH in arg:
                CONF_TOOL_PATH = str(arg).replace(ARG_TOOL_PATH, "")
            elif ARG_TOOL_PARAMS in arg:
                CONF_TOOL_PARAMS = str(arg).replace(ARG_TOOL_PARAMS, "")
            elif ARG_DEBUG_MODE in arg:
                CONF_DEBUG = True

            else:
                print("Usage: python driver [OPTIONS] ")
                print("Options are:")
                print("\t" + ARG_DATA_PATH + "\t| " + "directory for experiments")
                print("\t" + ARG_TOOL_NAME + "\t| " + "name of the tool")
                print("\t" + ARG_TOOL_PATH + "\t| " + "path of the tool")
                print("\t" + ARG_TOOL_PARAMS + "\t| " + "parameters for the tool")
                print("\t" + ARG_DEBUG_MODE + "\t| " + "enable debug mode")
                exit()


def run():
    global EXPERIMENT_ITEMS, DIR_MAIN, CONF_DATA_PATH, CONF_TOOL_PARAMS
    print("[DRIVER] Running experiment driver")
    read_arg()
    load_experiment()
    create_directories()
    index = 1
    for experiment_item in EXPERIMENT_ITEMS:
        CONF_TOOL_PARAMS = ""
        experiment_name = "Experiment-" + str(index) + "\n-----------------------------"
        print(experiment_name)
        bug_name = str(experiment_item[KEY_BUG_NAME])
        directory_name = str(experiment_item[KEY_DONOR])
        script_name = bug_name + ".sh"
        conf_file_name = bug_name + ".conf"
        category = str(experiment_item[KEY_CATEGORY])
        if category == "cross-program":
            directory_name = str(experiment_item[KEY_DONOR]) + "-" + str(experiment_item[KEY_TARGET])
        script_path = DIR_SCRIPT + "/" + category + "/" + directory_name
        conf_file_path = DIR_CONF + "/" + category + "/" + directory_name + "/" + conf_file_name
        if category == "backporting":
            directory_name = "backport/" + str(experiment_item[KEY_DONOR])
            CONF_TOOL_PARAMS = " --backport "
        deploy_path = CONF_DATA_PATH + "/" + directory_name + "/" + bug_name + "/"
        deployed_conf_path = deploy_path + "/" + conf_file_name
        print("\t[META-DATA] category: " + category)
        print("\t[META-DATA] project: " + directory_name)
        print("\t[META-DATA] bug ID: " + bug_name)
        setup(script_path, script_name, conf_file_path, deployed_conf_path)
        evaluate(deployed_conf_path, bug_name)
        index = index + 1


if __name__ == "__main__":
    try:
        run()
    except KeyboardInterrupt as e:
        print("[DRIVER] Program Interrupted by User")
        exit()
