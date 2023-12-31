#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
from os import getenv
from os.path import dirname
from os.path import realpath
from subprocess import CalledProcessError
from subprocess import run as run_process

HERE = dirname(realpath(__file__))


def main():
    cmd = [
        "pre-commit",
        "run",
        "--color",
        "always",
        "--config",
        "/pre-commit/pre-commit-config.yaml",
    ]

    if getenv("FULL_CHECK", "False").lower() in ["true", "yes", "t", "1"]:
        cmd.append("--all-files")
    elif len(sys.argv) > 0:
        cmd.append("--files")
        cmd += sys.argv[1:]

    try:
        pre_commit = run_process(cmd, check=True)
        return pre_commit.returncode
    except CalledProcessError as e:
        return e.returncode


if __name__ == "__main__":
    sys.exit(main())
