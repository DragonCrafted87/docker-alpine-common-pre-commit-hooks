#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os
import sys
from subprocess import CalledProcessError
from subprocess import run as run_process

HERE = os.path.dirname(os.path.realpath(__file__))


def main():
    cmd = [
        "pre-commit",
        "run",
        "--color",
        "always",
        "--config",
        "/pre-commit/pre-commit-config.yaml",
        "--files",
    ] + sys.argv[1:]

    try:
        pre_commit = run_process(cmd, check=True)
        return pre_commit.returncode
    except CalledProcessError as e:
        return e.returncode


if __name__ == "__main__":
    sys.exit(main())